import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from '@app/core/services/auth.service';
import { BehaviorSubject, catchError, filter, finalize, switchMap, take, throwError } from 'rxjs';

const PUBLIC_ENDPOINTS = [
  '/login/permiso/login',
  '/login/permiso/login-renew',
  '/login/ingreso/renew',
];

// Estado compartido del refresh — fuera del interceptor para que sea singleton
let isRefreshing = false;
const refreshToken$ = new BehaviorSubject<string | null>(null);

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);

  // 1. Saltar endpoints públicos (incluyendo el propio refresh para evitar loops)
  if (PUBLIC_ENDPOINTS.some(endpoint => req.url.includes(endpoint))) {
    return next(req);
  }

  return next(addAuthHeader(req, authService.getToken())).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status !== 401) {
        return throwError(() => error);
      }

      // 2. Si ya hay un refresh en curso, esperar a que termine y reintentar
      if (isRefreshing) {
        return refreshToken$.pipe(
          filter((token): token is string => token !== null),
          take(1),
          switchMap(token => next(addAuthHeader(req, token)))
        );
      }

      // 3. Iniciar el refresh una sola vez
      isRefreshing = true;
      refreshToken$.next(null);

      return authService.refreshToken().pipe(
        switchMap(() => {
          const newToken = authService.getToken();
          refreshToken$.next(newToken);
          return next(addAuthHeader(req, newToken));
        }),
        catchError(refreshError => {
          authService.logout();
          return throwError(() => refreshError);
        }),
        finalize(() => {
          isRefreshing = false;
        })
      );
    })
  );
};

function addAuthHeader(req: import('@angular/common/http').HttpRequest<unknown>, token: string | null) {
  return token
    ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
    : req;
}