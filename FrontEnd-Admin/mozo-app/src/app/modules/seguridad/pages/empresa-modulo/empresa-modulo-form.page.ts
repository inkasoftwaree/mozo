import { ChangeDetectionStrategy, Component, DestroyRef, computed, effect, inject, input, signal } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { forkJoin, Observable, Subject, switchMap, takeUntil } from 'rxjs';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { EmpresaModuloService } from '../../services/empresa-modulo.service';
import { EmpresaModuloModel } from '@app/shared/models/seguridad/empresa-modulo.model';
import { ButtonControl } from '@app/shared/components/button/button.control';
import { ToastrService } from 'ngx-toastr';
import { EmpresaModel } from '@app/shared/models/seguridad/empresa.model';

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
  private readonly fb = inject(FormBuilder);

  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  readonly data = input<EmpresaModel | null>(null);

  // Derivado reactivamente del input — elimina el writable signal y el set manual en el effect
  readonly empresa = computed(() => this.data());

  readonly empresaModulos = signal<EmpresaModuloModel[]>([]);

  readonly form = this.fb.group({
    modulos: this.fb.array<FormGroup>([]),
  });

  get modulosArray(): FormArray {
    return this.form.get('modulos') as FormArray;
  }

  // Emite antes de cada reconstrucción del form para cancelar suscripciones valueChanges anteriores
  private readonly formSubs$ = new Subject<void>();

  // switchMap cancela la petición HTTP anterior si llega una nueva antes de completar
  private readonly loadTrigger$ = new Subject<EmpresaModuloModel>();

  constructor() {
    this.destroyRef.onDestroy(() => this.formSubs$.complete());

    this.loadTrigger$.pipe(
      switchMap(params => this.empresaModuloService.selSelectAndUnSelectAll(params)),
      takeUntilDestroyed(this.destroyRef),
    ).subscribe((modulos: EmpresaModuloModel[]) => {
      this.empresaModulos.set(modulos);
      this.buildModulosForm(modulos);
    });

    effect(() => {
      const empresa = this.data();
      if (!empresa) return;
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
        if (modulo.coEmpresaModulo == null && !modulo.flEstReg) return false;
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
        },
      });
  }

  private buildModulosForm(modulos: EmpresaModuloModel[]): void {
    this.formSubs$.next();
    this.modulosArray.clear();

    modulos.forEach(modulo => {
      const group = this.fb.group({
        coEmpresaModulo: [modulo.coEmpresaModulo ?? null],
        coModulo: [modulo.coModulo],
        flEstReg: [!!modulo.flEstReg],
        isChanged: [false],
      });

      // Vincula el cambio del checkbox con isChanged; formSubs$ cancela al reconstruir
      group.get('flEstReg')!.valueChanges
        .pipe(takeUntil(this.formSubs$))
        .subscribe(() => group.get('isChanged')!.setValue(true, { emitEvent: false }));

      this.modulosArray.push(group);
    });
  }
}
