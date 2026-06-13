import { afterNextRender, ChangeDetectionStrategy, Component, effect, ElementRef, inject, Injector, signal, viewChild } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { ModalService } from '@app/shared/services/modal.service';
import { buildForm, getError, V } from '@app/core/global/form.helper';
import { FormFieldControl } from "@app/shared/components/form-field/form-field.control";
import { ButtonControl } from "@app/shared/components/button/button.control";
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { PerfilService } from '@moduleSeguridad/services/perfil.service';
import { PerfilModel } from '@app/shared/models/seguridad/perfil.model';
import { ModuloModel } from '@app/shared/models/seguridad/modulo.model';
import { FormModalBase } from '@app/shared/components/form/form-modal-base';

@Component({
  selector: 'mz-perfil-form-page',
  standalone: true,
  imports: [ReactiveFormsModule, ButtonControl, FormFieldControl],
  templateUrl: './perfil-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PerfilFormPage extends FormModalBase<PerfilModel> {

  private readonly perfilService = inject(PerfilService);
  public readonly modalService = inject(ModalService);
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  private readonly injector = inject(Injector);
  private readonly firstInputRef = viewChild<ElementRef<HTMLInputElement>>('firstInput');

  readonly modulo = signal<ModuloModel | null>(null);

  constructor() {
    super();
    effect(() => {
      const payload = this.data();
      this.clearForm();
      if (!payload) return;
      this.modulo.set(this.getRelation<ModuloModel>('modulo'));
      if (this.action() === 'update') this.selById(payload.model!);
      afterNextRender(() => this.firstInputRef()?.nativeElement.focus(), { injector: this.injector });
    });
  }

  form = buildForm(this.fb, [
    { name: 'noPerfil', validators: [...V.required, ...V.maxLength(100)] },
    { name: 'flDefault', value: 1 }
  ]);

  private selById(c: PerfilModel): void {
    this.perfilService.selById(c)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: c => {
          this.form.patchValue(c);
        }
      });
  }

  protected override onSave(): void {
    this.form.markAllAsTouched();

    if (this.form.invalid) return;
    const request = this.buildRequest();

    request.coModulo = this.modulo()?.coModulo;

    const observable$ = this.action() === 'insert'
      ? this.perfilService.insert(request)
      : this.perfilService.update(request);

    observable$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (response) => {
          if (this.action() === 'insert') {
            request.coPerfil = response;
          }
          this.handleSuccess('Perfil guardado exitosamente', request);
          this.modalService.close();
        }
      });
  }

  private buildRequest(): PerfilModel {
    const raw = this.form.getRawValue();
    return {
      coPerfil: this.model()?.coPerfil,
      noPerfil: raw['noPerfil'],
      coModulo: raw['coModulo'],
      flDefault: raw['flDefault'] == true ? 1 : 0
    };
  }

  getError(field: string): string | null {
    return getError(this.form, field);
  }

}
