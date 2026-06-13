import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { finalize } from 'rxjs/operators';
import { LoadingService } from '@app/core/services/loading.service';

// Requests that run silently in the background without showing the global spinner
const SILENT_ENDPOINTS = [
  '/login/ingreso/renew',
];

export const loadingInterceptor: HttpInterceptorFn = (req, next) => {
  const loadingService = inject(LoadingService);

  if (SILENT_ENDPOINTS.some(url => req.url.includes(url))) {
    return next(req);
  }

  loadingService.show();

  return next(req).pipe(
    finalize(() => loadingService.hide())
  );
};
