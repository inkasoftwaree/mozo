import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';
import { provideRouter, withComponentInputBinding, withViewTransitions } from '@angular/router';

import { routes } from './app.routes';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { authInterceptor } from './core/interceptors/auth-interceptor';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideToastr } from 'ngx-toastr';

import { provideIcons } from '@ng-icons/core';


// Importa solo los iconos que vas a usar (Lucide)
import {
  lucideHome,
  lucidePackage,
  lucideMenu,
  lucideMoreVertical,
  lucidePanelRightOpen, // Desplegar menu

  lucideShieldUser, // Módulo de Seguridad
  lucideDatabaseZap, // Módulo de Maestros
  lucideSchool, // Módulo de Empresa
  lucideBuilding2, // Módulo de Condominio
  lucideFileStack, // Módulo de Tramite documentario
  lucideLifeBuoy, // Módulo de Soporte tecnico
  lucideCalculator, // Módulo de Contabilidad
  lucideGraduationCap, // Módulo de Matricula
  lucideShoppingBasket, // Módulo de Producto

  lucideUser,
  lucideUsers,
  lucidePlus, // Nuevo
  lucidePencil, // Editar
  lucideTrash2, // Eliminar

  lucideSquareCheck, // Active
  lucideSquare, // Inactive


  lucideSave, // Guardar
  lucideList,
  lucideEye,
  lucideLogOut, // Salir
  lucideCheckLine,   // Defect
  lucideToggleRight, // Toogle
  lucideShield,
  lucideSettings,
  lucideInfo,
  lucideMessageCircle


} from '@ng-icons/lucide';
import { loadingInterceptor } from './core/interceptors/loading.interceptor';
import { errorInterceptor } from './core/interceptors/error.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes, withComponentInputBinding(), withViewTransitions()),
    provideHttpClient(withInterceptors([authInterceptor, loadingInterceptor, errorInterceptor])),
    provideAnimations(),
    provideToastr({
      closeButton: true,
      timeOut: 3000,
      positionClass: 'toast-top-right',
      preventDuplicates: true
    }),
    provideIcons({
      lucideHome,
      lucidePackage,
      lucideMenu,
      lucideMoreVertical,
      lucidePanelRightOpen, // Desplegar menu
      lucideDatabaseZap, // Módulo de Maestros
      lucideShieldUser, // Módulo de Seguridad
      lucideSchool, // Módulo de Empresa
      lucideBuilding2, // Módulo de Condominio
      lucideFileStack, // Módulo de Tramite documentario
      lucideLifeBuoy, // Módulo de Soporte tecnico
      lucideCalculator, // Módulo de Contabilidad
      lucideGraduationCap, // Módulo de Matricula
      lucideShoppingBasket, // Módulo de Producto


      lucideUser,
      lucideUsers,

      lucidePlus, // Nuevo
      lucidePencil, // Editar
      lucideTrash2, // Eliminar

      lucideSquareCheck, // Active
      lucideSquare, // Inactive

      lucideSave, // Guardar
      lucideList,
      lucideEye,
      lucideLogOut, // Salir
      lucideCheckLine,   // Defecto
      lucideToggleRight, // Toogle
      lucideShield,
      lucideSettings,
      lucideInfo,
      lucideMessageCircle
    })
  ]
};

