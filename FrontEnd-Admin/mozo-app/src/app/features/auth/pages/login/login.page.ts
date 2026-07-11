import { afterNextRender, ChangeDetectionStrategy, Component, effect, ElementRef, inject, Injector, signal, viewChild } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { NgIcon } from '@ng-icons/core';
import { Router } from '@angular/router';
import { AuthService } from '@app/core/services/auth.service';
import { buildForm, getError, V } from '@app/core/global/form.helper';
import { ModalService } from '@app/shared/services/modal.service';
import { from, switchMap, tap } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { OptionService } from '@app/core/services/option.service';
import { UsuarioModel } from '@app/shared/models/seguridad/usuario.model';
import { FormModalBase } from '@app/shared/components/form/form-modal-base';
import { TipoArchivoCatalogoService } from '@app/core/services/tipo-archivo-catalogo.service';
import { CredentialEmpresaModel } from '@app/shared/models/seguridad/auth/credencial-response.model';

@Component({
  selector: 'mz-login-page',
  standalone: true,
  imports: [ReactiveFormsModule, NgIcon],
  templateUrl: './login.page.html',
  styleUrl: './login.page.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class LoginPage extends FormModalBase<UsuarioModel> {
  private auth = inject(AuthService);
  private router = inject(Router);
  public modalService = inject(ModalService);
  private optionService = inject(OptionService);
  private tipoArchivoCatalogo = inject(TipoArchivoCatalogoService);

  private readonly injector = inject(Injector);
  private readonly noUsuarioRef = viewChild<ElementRef<HTMLInputElement>>('noUsuarioInput');

  step = signal<'login' | 'empresa'>('login');

  empresas = signal<CredentialEmpresaModel[]>([]);

  tokenTemporal = signal<string>('');


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

  private buildRequest(): UsuarioModel {
    const raw = this.form.getRawValue();
    return {
      noUsuario: raw['noUsuario'] ?? '',
      noClave: raw['noClave'] ?? ''
    };
  }

  protected override onSave(): void {
    this.form.markAllAsTouched();
    if (this.form.invalid)
      return;

    const request = this.buildRequest();

    this.auth.login(request)
      .pipe(
        takeUntilDestroyed(this.destroyRef)
      )
      .subscribe({
        next: (response) => {
          this.isLoading.set(false);

          if (response.flRequiereSeleccionEmpresa === 1) {

            this.empresas.set(response.empresaLst ?? []);
            this.tokenTemporal.set(response.noToken);
            this.step.set('empresa');

            return;
          }
          this.finalizarLogin();        
        },
        error: () => {
          this.isLoading.set(false);
          this.toastr.error('Error en el login', 'Login fallido');
        }
      });
  }


  seleccionarEmpresa(coEmpresa: number): void {
    //this.isLoading.set(true);
    this.auth.loginEmpresa(
      this.tokenTemporal(),
      coEmpresa
    )
      .pipe(
        takeUntilDestroyed(this.destroyRef)
      )
      .subscribe({
        next: () => {
          this.isLoading.set(false);
          this.finalizarLogin();
        },
        error: () => {
          this.isLoading.set(false);
          this.toastr.error('No fue posible ingresar a la empresa', 'Error');
        }
      });

  }


  private finalizarLogin(): void {
    this.auth.getMenus()
      .pipe(
        tap(menus => this.optionService.setMenus(menus)),
        switchMap(() => from(this.tipoArchivoCatalogo.cargar())),
        takeUntilDestroyed(this.destroyRef)
      )
      .subscribe({
        next: () => {
          this.isLoading.set(false);
          this.modalService.close();
          this.toastr.success('Bienvenido','Login exitoso');
          this.form.reset();
          this.step.set('login');
          this.empresas.set([]);
          this.tokenTemporal.set('');
          setTimeout(() => {
            this.router.navigate(['/home']);
          }, 100);
        },
        error: () => {
          this.toastr.error('No fue posible cargar la información inicial','Error');
        }
      });

  }

  getError(field: string): string | null {
    return getError(this.form, field);
  }

}
