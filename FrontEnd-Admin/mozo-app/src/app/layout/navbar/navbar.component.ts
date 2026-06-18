import { ChangeDetectionStrategy, Component, DestroyRef, inject } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { Router, RouterLink, RouterOutlet } from "@angular/router";
import { ModalService } from '@sharedServices/modal.service';
import { AuthService } from '@app/core/services/auth.service';
import { NgIcon } from "@ng-icons/core";
import { LoginPage } from "@app/features/auth/pages/login/login.page";
import { ModalControl } from "@app/shared/components/modal/modal.control";
import { PermisoModel } from '@app/shared/models/seguridad/permiso.model';

@Component({
  selector: '[app-navbar-component]',
  standalone: true,
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
  imports: [RouterOutlet, NgIcon, LoginPage, ModalControl],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class NavbarComponent {

  private readonly auth = inject(AuthService);
  private readonly modalService = inject(ModalService);
  private readonly router = inject(Router);
  private readonly destroyRef = inject(DestroyRef);

  readonly user = this.auth.user;

  openLogin(): void {
    const login: PermisoModel = {
      coPermiso: 0,
      coPersona: 0,
      noUsuario: '',
      noClave: ''
    };

    this.modalService.open<PermisoModel>({
      modalName: 'login-page',
      title: 'Login',
      size: 'sm',
      data: { model: login }
    });
  }

  logout(): void {
    this.auth.logout()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => this.router.navigate(['/logout'], { replaceUrl: true }),
        error: () => this.router.navigate(['/logout'], { replaceUrl: true })
      });
  }

}
