import { afterNextRender, ChangeDetectionStrategy, Component, effect, ElementRef, inject, Injector, viewChild } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '@app/core/services/auth.service';
import { buildForm, getError, V } from '@app/core/global/form.helper';
import { ModalService } from '@app/shared/services/modal.service';
import { from, switchMap, tap } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { OptionService } from '@app/core/services/option.service';
import { PermisoModel } from '@app/shared/models/seguridad/permiso.model';
import { FormModalBase } from '@app/shared/components/form/form-modal-base';
import { TipoArchivoCatalogoService } from '@app/core/services/tipo-archivo-catalogo.service';

@Component({
  selector: 'mz-login-page',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './login.page.html',
  styleUrl: './login.page.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class LoginPage extends FormModalBase<PermisoModel> {
  private auth = inject(AuthService);
  private router = inject(Router);
  public modalService = inject(ModalService);
  private optionService = inject(OptionService);
  private tipoArchivoCatalogo = inject(TipoArchivoCatalogoService);

  private readonly injector = inject(Injector);
  private readonly noUsuarioRef = viewChild<ElementRef<HTMLInputElement>>('noUsuarioInput');

  constructor() {
    super();
    effect(() => {
      const payload = this.data();
      this.clearForm();
      if (!payload) return;
      this.form.patchValue({ noUsuario: '' });
      afterNextRender(() => this.noUsuarioRef()?.nativeElement.focus(), { injector: this.injector });
    });
  }

  form = buildForm(this.fb, [
    { name: 'noUsuario', validators: V.username },
    { name: 'noClave', validators: V.password }
  ]);

  private buildRequest(): PermisoModel {
    const raw = this.form.getRawValue();
    return {
      noUsuario: raw['noUsuario'] ?? '',
      noClave: raw['noClave'] ?? ''
    };
  }

  protected override onSave(): void {
    this.form.markAllAsTouched();
    if (this.form.invalid) return;

    const request = this.buildRequest();

    this.auth.login(request)
      .pipe(
        switchMap(() => this.auth.getMenus()),
        tap(menus => this.optionService.setMenus(menus)),
        switchMap(() => from(this.tipoArchivoCatalogo.cargar())),
        takeUntilDestroyed(this.destroyRef)
      )
      .subscribe({
        next: () => {
          this.isLoading.set(false);
          this.modalService.close();
          this.toastr.success('Bienvenido', 'Login exitoso');
          this.form.reset();
          setTimeout(() => this.router.navigate(['/home']), 100);
        },
        error: () => {
          this.isLoading.set(false);
          this.toastr.error('Error en el login', 'Login fallido');
        }
      });
  }

  getError(field: string): string | null {
    return getError(this.form, field);
  }
}
