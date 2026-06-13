import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject, isDevMode } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

/**
 * Interfaz para ProblemDetails de .NET
 */
interface ProblemDetails {
  type?: string;
  title?: string;
  status?: number;
  detail?: string;
  code?: string;
  errors?: ErrorDetail[];
  timestamp?: string;
  traceId?: string;
  message?: string;
  [key: string]: any;
}

interface ErrorDetail {
  field: string;
  message: string;
  code: string;
}

export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);
  const toastr = inject(ToastrService);

  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      // 1. Dejar que authInterceptor maneje los 401 — evita doble manejo
      if (error.status === 401) {
        return throwError(() => error);
      }

      const problem: ProblemDetails = error.error || {};
      const message = problem.detail ?? problem.message ?? 'Ocurrió un error inesperado';
      const title   = problem.title ?? `Error ${error.status}`;
      const code    = problem.code  ?? String(error.status);

      if (isDevMode()) console.error('HTTP Error:', {
        httpStatus: error.status,
        code,
        detail: problem.detail,
        traceId: problem.traceId,
      });

      switch (error.status) {
        case 400: handleBadRequest(toastr, problem, message, title, code); break;
        case 403: handleForbidden(toastr, router, message, code);          break;
        case 404: handleNotFound(toastr, message, code);                   break;
        case 500: handleServerError(toastr, problem, message, code);       break;
        default:  toastr.error(message, `Error ${error.status}`);          break;
      }

      return throwError(() => error);
    })
  );
};

// ── Handlers ────────────────────────────────────────────────────────────────

function handleBadRequest(
  toastr: ToastrService,
  problem: ProblemDetails,
  message: string,
  title: string,
  code: string
): void {
  const errors: ErrorDetail[] = Array.isArray(problem.errors) ? problem.errors : [];

  if (errors.length === 0) {
    toastr.error(message, `${title} (${code})`);
    return;
  }

  if (errors.length === 1) {
    toastr.error(`${errors[0].field}: ${errors[0].message}`, `Validación (${code})`);
    return;
  }

  // Múltiples errores: mostrar uno por uno para que el usuario los vea todos
  errors.forEach(e =>
    toastr.error(`${e.field}: ${e.message}`, `Validación (${e.code})`)
  );
}

function handleForbidden(
  toastr: ToastrService,
  router: Router,
  message: string,
  code: string
): void {
  toastr.error(message || 'No tienes permisos para realizar esta acción', `Prohibido (${code})`);
  router.navigate(['/forbidden']);
}

function handleNotFound(toastr: ToastrService, message: string, code: string): void {
  toastr.error(message || 'Recurso no encontrado', `Error ${code}`);
}

function handleServerError(
  toastr: ToastrService,
  problem: ProblemDetails,
  message: string,
  code: string
): void {
  toastr.error(message || 'Error interno del servidor', `Error ${code}`);

  if (problem.traceId && isDevMode()) {
    console.error(`Trace ID para soporte: ${problem.traceId}`);
  }
}