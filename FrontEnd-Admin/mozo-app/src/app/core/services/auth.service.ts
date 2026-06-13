import { inject, Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError, Observable, tap, throwError } from 'rxjs';
import { CredencialResponseModel } from '@sharedModels/seguridad/auth/credencial-response.model';
import { CredencialModel } from '@sharedModels/seguridad/auth/credencial.model';
import { API_ROUTES, STORAGE_KEYS } from '@app/core/global/constants';
import { ModuloUsuarioModel } from '@app/shared/models/seguridad/modulo-usuario.model';
import { OptionService } from '@app/core/services/option.service';
import { PermisoModel } from '@app/shared/models/seguridad/permiso.model';
import { UrlApiService } from './url-api.service';
import { TipoArchivoCatalogoService } from './tipo-archivo-catalogo.service';

interface JwtPayload {
  exp?: number;
  [key: string]: unknown;
}

@Injectable({ providedIn: 'root' })
export class AuthService {

  // ── Dependencias ────────────────────────────────────────────────────────────
  private readonly api = inject(UrlApiService);
  private readonly http = inject(HttpClient);
  private readonly optionService = inject(OptionService);
  private readonly tipoArchivoCatalogoService = inject(TipoArchivoCatalogoService);

  // ── URLs ────────────────────────────────────────────────────────────────────
  private readonly permisoUrl = this.api.buildUrl(API_ROUTES.login.permiso);
  private readonly ingresoUrl = this.api.buildUrl(API_ROUTES.login.ingreso);
  private readonly baseMenuUrl = this.api.buildUrl(API_ROUTES.login.menu);

  // ── Estado reactivo ─────────────────────────────────────────────────────────
  private readonly userSignal = signal<CredencialModel | null>(this.getUser());

  /** Signal de solo lectura con el usuario autenticado actualmente. */
  readonly user = this.userSignal.asReadonly();

  // ══════════════════════════════════════════════════════════════════════════
  // Autenticación
  // ══════════════════════════════════════════════════════════════════════════

  /** Inicia sesión con credenciales del usuario. */
  login(credenciales: PermisoModel): Observable<CredencialResponseModel> {
    const { noUsuario, noClave } = credenciales;
    return this.http
      .post<CredencialResponseModel>(this.permisoUrl, { noUsuario, noClave })
      .pipe(tap(res => this.handleAuthSuccess(res)));
  }


  /**
   * Renueva el access token usando el refresh token.
   * La coordinación de concurrencia (evitar duplicados) la maneja el interceptor;
   * este método solo ejecuta la petición HTTP y persiste el resultado.
   */
  refreshToken(): Observable<CredencialResponseModel> {
    const noRefreshToken = this.getRefreshToken();

    if (!noRefreshToken) {
      return throwError(() => new Error('No hay refresh token disponible.'));
    }

    return this.http
      .post<CredencialResponseModel>(`${this.ingresoUrl}/renew`, { noRefreshToken })
      .pipe(
        tap(res => this.handleAuthSuccess(res)),
        catchError(err => throwError(() => err))
      );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Menú / módulos
  // ══════════════════════════════════════════════════════════════════════════

  /** Obtiene los módulos/menús disponibles para el usuario autenticado. */
  getMenus(): Observable<ModuloUsuarioModel[]> {
    return this.http.get<ModuloUsuarioModel[]>(`${this.baseMenuUrl}/modulos`);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Sesión
  // ══════════════════════════════════════════════════════════════════════════

  /** Revoca el refresh token en el servidor y elimina todos los datos de sesión locales. */
  logout(): Observable<void> {
    const refreshToken = this.getRefreshToken();
    this.clearLocalState();

    if (!refreshToken) {
      return throwError(() => new Error('No hay refresh token para revocar.'));
    }

    return this.http.post<void>(`${this.ingresoUrl}/revoke`, { noRefreshToken: refreshToken });
  }

  /** Limpia la sesión local sin llamar al servidor (útil como medida de seguridad). */
  clearSession(): void {
    this.clearLocalState();
  }


  private clearLocalState(): void {
    localStorage.removeItem(STORAGE_KEYS.TOKEN);
    localStorage.removeItem(STORAGE_KEYS.REFRESH_TOKEN);
    localStorage.removeItem(STORAGE_KEYS.USER);

    this.optionService.clear();
    this.tipoArchivoCatalogoService.limpiar();

    this.userSignal.set(null);
  }

  /** Retorna `true` si el usuario está autenticado según el signal. */
  isAuthenticated(): boolean {
    const exp = this.getTokenExpiration();
    return !!exp && Date.now() < exp;
  }

  /** Retorna `true` si el token expira en menos de 1 minuto. */
  isTokenExpiringSoon(): boolean {
    const exp = this.getTokenExpiration();
    return !exp || (exp - Date.now()) < 60_000;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Almacenamiento — Token
  // ══════════════════════════════════════════════════════════════════════════

  getToken(): string | null {
    return localStorage.getItem(STORAGE_KEYS.TOKEN);
  }

  getRefreshToken(): string | null {
    return localStorage.getItem(STORAGE_KEYS.REFRESH_TOKEN);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Almacenamiento — Usuario
  // ══════════════════════════════════════════════════════════════════════════

  getUser(): CredencialModel | null {
    const raw = localStorage.getItem(STORAGE_KEYS.USER);
    try {
      return raw ? (JSON.parse(raw) as CredencialModel) : null;
    } catch {
      return null;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // JWT
  // ══════════════════════════════════════════════════════════════════════════

  getTokenExpiration(): number | null {
    const token = this.getToken();
    if (!token) return null;
    const decoded = this.decodeToken(token);
    return decoded?.exp ? decoded.exp * 1000 : null;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Privados
  // ══════════════════════════════════════════════════════════════════════════

  /** Persiste los datos de autenticación y notifica a los suscriptores. */
  private handleAuthSuccess({ credencial, noToken, noTokenRefresh }: CredencialResponseModel): void {
    localStorage.setItem(STORAGE_KEYS.TOKEN, noToken);
    localStorage.setItem(STORAGE_KEYS.REFRESH_TOKEN, noTokenRefresh);
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(credencial));

    this.userSignal.set(credencial);
  }

  /** Decodifica el payload de un JWT sin librerías externas. */
  private decodeToken(token: string): JwtPayload | null {
    try {
      const payload = token.split('.')[1].replace(/-/g, '+').replace(/_/g, '/');
      return JSON.parse(atob(payload));
    } catch {
      return null;
    }
  }
}