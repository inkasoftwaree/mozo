import { afterNextRender, ChangeDetectionStrategy, Component, effect, ElementRef, inject, Injector, viewChild } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { ModuloModel } from '@app/shared/models/seguridad/modulo.model';
import { ModalService } from '@app/shared/services/modal.service';
import { buildForm, getError, V } from '@app/core/global/form.helper';
import { FormFieldControl } from "@app/shared/components/form-field/form-field.control";
import { ButtonControl } from "@app/shared/components/button/button.control";
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { FormModalBase } from '@app/shared/components/form/form-modal-base';
import { TipoParticularService } from '../../services/tipo-particular.service';
import { TipoParticularModel } from '@app/shared/models/maestro/tipo-particular.model';

@Component({
  selector: 'mz-tipo-particular-form-page',
  standalone: true,
  imports: [ReactiveFormsModule, ButtonControl, FormFieldControl],
  templateUrl: './tipo-particular-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class TipoParticularFormPage extends FormModalBase<TipoParticularModel> {
  private readonly tipoParticularService = inject(TipoParticularService);
  public readonly modalService = inject(ModalService);
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  private readonly injector = inject(Injector);
  private readonly firstInputRef = viewChild<ElementRef<HTMLInputElement>>('firstInput');

  constructor() {
    super();
    effect(() => {
      const payload = this.data();
      this.clearForm();
      if (!payload) return;
      if (this.action() === 'update') this.selById(payload.model!);
      afterNextRender(() => this.firstInputRef()?.nativeElement.focus(), { injector: this.injector });
    });
  }

  form = buildForm(this.fb, [
    { name: 'coGrupo', validators: V.required},
    { name: 'coEmpresa', validators: V.required},
    { name: 'coGrupoPadre'},
    { name: 'coTipoPadre'},
    { name: 'nuOrden', validators: [...V.required, ...V.integer] },
    { name: 'noTipo', validators: [...V.required, ...V.maxLength(150)] },
    { name: 'txDescripcion', validators: [...V.maxLength(1000)] },
    { name: 'noSigla', validators: [...V.maxLength(5)] },  
    //{ name: 'flEstReg', value: true, validators: V.required},
    { name: 'flDefault', value: 0 }
  ]);

  private selById(c: TipoParticularModel): void {
    this.tipoParticularService.selById(c)
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

    const observable$ = this.action() === 'insert'
      ? this.tipoParticularService.insert(request)
      : this.tipoParticularService.update(request);

    observable$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (response) => {
          if (this.action() === 'insert') {
            request.coModulo = response;
          }
          this.handleSuccess('Tipo guardado exitosamente', request);
          this.modalService.close();
        }
      });
  }

  private buildRequest(): TipoParticularModel {
    const raw = this.form.getRawValue();
    return {
      coGrupo: this.model()?.coGrupo,
      coTipo: this.model()?.coTipo,
      coEmpresa: this.model()?.coEmpresa,
      coModulo: this.model()?.coModulo,
      coGrupoPadre: this.model()?.coGrupoPadre,
      coTipoPadre: this.model()?.coTipoPadre,
    
      nuOrden: raw['nuOrden'] ?? 0,
      noTipo: raw['noTipo'] ?? '',
      txDescripcion: raw['txDescripcion'] ?? '',
      noSigla: raw['noSigla'] ?? '',
     
      flDefault: raw['flDefault'] == true ? 1 : 0,   
    };
  }


  getError(field: string): string | null {
    return getError(this.form, field);
  }


}
