import { ChangeDetectionStrategy, Component, DestroyRef, effect, inject, input, signal } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { forkJoin, Observable, Subject, switchMap, takeUntil } from 'rxjs';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { EmpresaModuloService } from '../../services/empresa-modulo.service';
import { EmpresaModuloModel } from '@app/shared/models/seguridad/empresa-modulo.model';
import { EmpresaModel } from '@app/shared/models/seguridad/empresa.model';
import { ButtonControl } from '@app/shared/components/button/button.control';
import { ToastrService } from 'ngx-toastr';


type ModuloFormValue = {
  coEmpresaModulo: number | null;
  coModulo: number;
  flEstReg: boolean;
  isChanged: boolean;
};


@Component({
  selector: 'mz-empresa-modulo-form-page',
  standalone: true,
  imports: [ReactiveFormsModule, ButtonControl],
  templateUrl: './empresa-modulo-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class EmpresaModuloFormPage {

  private readonly toastr = inject(ToastrService);
  private readonly empresaModuloService = inject(EmpresaModuloService);
  private readonly destroyRef = inject(DestroyRef);
  protected readonly fb = inject(FormBuilder);
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  // Emits before every form rebuild to cancel stale valueChanges subscriptions
  private readonly formSubs$ = new Subject<void>();

  // Trigger for HTTP load — switchMap cancels the previous in-flight request
  private readonly loadTrigger$ = new Subject<EmpresaModuloModel>();

  readonly data = input<EmpresaModel | null>(null);
  readonly empresa = signal<EmpresaModel | null>(null);
  readonly empresaModulos = signal<EmpresaModuloModel[]>([]);

  form = this.fb.group({
    modulos: this.fb.array<FormGroup>([])
  });

  get modulosArray(): FormArray {
    return this.form.get('modulos') as FormArray;
  }

  constructor() {
    this.destroyRef.onDestroy(() => this.formSubs$.complete());

    this.loadTrigger$.pipe(
      switchMap(params => this.empresaModuloService.selSelectAndUnSelectAll(params)),
      takeUntilDestroyed(this.destroyRef),
    ).subscribe((modulos: EmpresaModuloModel[]) => {
      this.empresaModulos.set(modulos);
      this.buildForm(modulos);
    });

    effect(() => {
      const empresa = this.data();
      if (!empresa) return;
      this.empresa.set(empresa);
      this.modulosArray.clear();
      this.empresaModulos.set([]);
      this.loadTrigger$.next({ coEmpresa: empresa.coEmpresa });
    });
  }

  onSave(): void {
    const raw = this.form.getRawValue() as { modulos: ModuloFormValue[] };
    const changedIndexes: number[] = [];

    const observables: Observable<number | void>[] = raw.modulos
      .filter((modulo, index) => {
        if (!modulo.isChanged) return false;
        // No DB record + user left it unchecked → nothing to do
        if (modulo.coEmpresaModulo == null && !modulo.flEstReg) return false;
        // DB record exists + user left it checked → toggled and reverted
        if (modulo.coEmpresaModulo != null && modulo.flEstReg) return false;
        changedIndexes.push(index);
        return true;
      })
      .map(modulo => {
        const payload: EmpresaModuloModel = {
          coEmpresa: this.empresa()!.coEmpresa,
          coEmpresaModulo: modulo.coEmpresaModulo ?? undefined,
          coModulo: modulo.coModulo,
          flEstReg: modulo.flEstReg ? 1 : 0,
        };
        // No DB record → INSERT (user checked a new module)
        // DB record exists → DELETE (user unchecked an existing module)
        return modulo.coEmpresaModulo == null
          ? this.empresaModuloService.insert(payload)
          : this.empresaModuloService.deleteById(payload);
      });

    if (observables.length === 0) {
      this.toastr.info('No se encontraron cambios en Módulos para la Empresa', 'Información');
      return;
    }

    forkJoin(observables)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          changedIndexes.forEach(index =>
            this.modulosArray.at(index).get('isChanged')?.setValue(false, { emitEvent: false })
          );
          this.toastr.success(
            `Se guardaron ${observables.length} cambio(s) de Módulos para la Empresa`,
            'Éxito'
          );
        }
      });
  }

  private buildForm(modulos: EmpresaModuloModel[]): void {
    // Cancel stale valueChanges subscriptions before clearing the array
    this.formSubs$.next();
    this.modulosArray.clear();

    modulos.forEach(modulo => {
      const group = this.fb.group({
        coEmpresaModulo: [modulo.coEmpresaModulo ?? null],
        coModulo: [modulo.coModulo],
        flEstReg: [!!modulo.flEstReg],  // normalize API number (0/1) → boolean
        isChanged: [false],
      });

      // Track checkbox changes — tied to formSubs$ so rebuild cancels old subscriptions
      group.get('flEstReg')!.valueChanges
        .pipe(takeUntil(this.formSubs$))
        .subscribe(() => group.get('isChanged')!.setValue(true, { emitEvent: false }));

      this.modulosArray.push(group);
    });
  }
}
