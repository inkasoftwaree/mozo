import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth-guard';

export const routes: Routes = [
  {
    path: 'logout',
    loadComponent: () => import('./shared/pages/logout/logout.page').then(m => m.LogoutPage)
  },
  {
    path: 'forbidden',
    loadComponent: () => import('./shared/pages/forbidden/forbidden.page').then(m => m.ForbiddenPage)
  },
  {
    path: 'home',
    loadComponent: () => import('./shared/pages/home/home.page').then(m => m.HomePage),
    canActivate: [authGuard]
  },
  {
    path: 'seguridad',
    loadChildren: () => import('@module/seguridad/seguridad.router').then(m => m.default),
    canActivate: [authGuard]
  },
  {
    path: 'maestro',
    loadChildren: () => import('@module/maestro/maestro.router').then(m => m.default),
    canActivate: [authGuard]
  },
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full'
  },
  {
    path: '**',
    redirectTo: 'home'
  }
];
