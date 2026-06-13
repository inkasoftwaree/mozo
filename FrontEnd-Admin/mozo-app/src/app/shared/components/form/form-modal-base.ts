import { Directive, DestroyRef, effect, inject, input, output, signal, computed } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ModalMetaData, ModalPayload } from '@app/shared/models/controls/modal-control.model';

/**
 * Base para todos los formularios modales.
 * Reacciona a cambios de data via effect() — sin ngOnInit ni @Input setter.
 */
@Directive()
export abstract class FormModalBase<T = object> {
  protected readonly fb = inject(FormBuilder);
  protected readonly toastr = inject(ToastrService);
  protected readonly destroyRef = inject(DestroyRef);

  /** Input signal — el padre vincula con [data]="payload" */
  readonly data = input<ModalPayload<T> | null>(null);

  /** Output signal — emite el modelo guardado */
  readonly saved = output<T | null>();

  protected readonly payload$ = signal<ModalPayload<T> | null>(null);
  protected readonly isLoading = signal(false);

  protected readonly model = computed(() => this.payload$()?.model ?? null);
  protected readonly relations = computed<Record<string, unknown>>(() => this.payload$()?.relations ?? {});
  protected readonly metadata = computed<ModalMetaData>(() => this.payload$()?.metaData ?? {});

  protected readonly action = computed<'insert' | 'update' | 'view'>(() => {
    const meta = this.metadata();
    return (meta?.action as 'insert' | 'update' | 'view') ?? (this.model() === null ? 'insert' : 'update');
  });

  abstract form: FormGroup;

  constructor() {
    // Sync payload$ whenever the data input changes; notify subclasses via onDataChanged
    effect(() => {
      const payload = this.data();
      this.payload$.set(payload);
      if (payload) this.onDataChanged(payload);
    });
  }

  /**
   * Se ejecuta cada vez que los datos del modal cambian
   * Subclases pueden override para cargar datos específicos
   */
  protected onDataChanged(payload: ModalPayload<T>): void {
    // Implementar en subclases si necesitan
  }

  protected getRelation<R = unknown>(key: string): R | null {
    return (this.relations()[key] as R) ?? null;
  }

  protected getAllRelations(): Record<string, unknown> {
    return this.relations();
  }

  /**
   * Validar formulario y guardar
   */
  save(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    this.onSave();
  }

  /**
   * Método abstracto - cada subclase implementa su guardado
   */
  protected abstract onSave(): void;

  /**
   * Lógica común de éxito
   */
  protected handleSuccess(
    message: string = 'Se grabaron los cambios',
    model?: T
  ): void {
    this.isLoading.set(false);
    this.toastr.success(message, 'Éxito');

    const dataToEmit = model || this.model();
    if (dataToEmit !== null) {
      this.saved.emit(dataToEmit);
    }
  }

  /**
   * Lógica común de error
   */
  protected handleError(_error: unknown, message: string = 'Error al guardar'): void {
    this.isLoading.set(false);
    this.toastr.error(message, 'Error');
  }

  /**
   * Reset del formulario
   */
  protected resetForm(): void {
    this.form.reset();
  }

  protected getFormValue(): T {
    return this.form.getRawValue() as T;
  }

  protected getFormValueIfValid(): T | null {
    return this.form.valid ? (this.form.getRawValue() as T) : null;
  }

  protected markAllAsTouched(): void {
    this.form.markAllAsTouched();
  }

  protected clearForm(): void {
    this.form.reset();
    this.form.markAsPristine();
    this.form.markAsUntouched();
  }

  protected disableForm(): void {
    this.form.disable();
  }

  protected enableForm(): void {
    this.form.enable();
  }

  protected getFormStatus(): {
    valid: boolean;
    pristine: boolean;
    touched: boolean;
    dirty: boolean;
  } {
    return {
      valid: this.form.valid,
      pristine: this.form.pristine,
      touched: this.form.touched,
      dirty: this.form.dirty
    };
  }

}
