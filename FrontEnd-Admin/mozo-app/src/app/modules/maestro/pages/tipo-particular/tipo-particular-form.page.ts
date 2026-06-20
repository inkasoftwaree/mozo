import {
  afterNextRender,
  ChangeDetectionStrategy,
  Component,
  computed,
  effect,
  ElementRef,
  inject,
  Injector,
  signal,
  untracked,
  viewChild,
} from '@angular/core';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { rxResource, takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { of } from 'rxjs';
import { ModalService } from '@app/shared/services/modal.service';
import { ConfirmService } from '@app/shared/services/confirm.service';
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { buildForm, getError, V } from '@app/core/global/form.helper';
import { FormFieldControl } from '@app/shared/components/form-field/form-field.control';
import { ButtonControl } from '@app/shared/components/button/button.control';
import { StateControl } from '@app/shared/components/state/state.control';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { FormModalBase } from '@app/shared/components/form/form-modal-base';
import { PagedResult } from '@app/shared/models/base.model';
import { TipoParticularService } from '../../services/tipo-particular.service';
import { TipoParticularModel } from '@app/shared/models/maestro/tipo-particular.model';

type HijoRow = TipoParticularModel & { _tempId?: number };
type HijoField = 'noTipo' | 'nuOrden';
type HijoFieldErrors = Partial<Record<HijoField, string>>;

const EMPTY_PAGE: PagedResult<TipoParticularModel> = { rowsCount: 0, data: [] };

@Component({
  selector: 'mz-tipo-particular-form-page',
  standalone: true,
  imports: [ReactiveFormsModule, FormsModule, ButtonControl, FormFieldControl, StateControl],
  templateUrl: './tipo-particular-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class TipoParticularFormPage extends FormModalBase<TipoParticularModel> {
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  private readonly tipoParticularService = inject(TipoParticularService);
  private readonly confirmService = inject(ConfirmService);
  private readonly injector = inject(Injector);
  private readonly firstInputRef = viewChild<ElementRef<HTMLInputElement>>('firstInput');

  readonly modalService = inject(ModalService);

  private readonly loadedModel = signal<TipoParticularModel | null>(null);
  private readonly grupoContext = signal<TipoParticularModel | null>(null);
  private readonly hijosFetchReady = signal(false);
  private readonly hijoFieldErrors = signal<Map<number, HijoFieldErrors>>(new Map());

  readonly hijos = signal<HijoRow[]>([]);
  readonly editandoId = signal<number | null>(null);
  readonly showParentFormErrors = signal(false);
  readonly showHijosAvailableHint = signal(false);

  private tempIdCounter = -1;
  private currentInitKey: string | null = null;
  private nextOrderKey: string | null = null;

  readonly coGrupoHijo = computed(
    () => this.loadedModel()?.coGrupoHijo ?? this.grupoContext()?.coGrupoHijo ?? 0
  );
  readonly hasChildren = computed(
    () => this.coGrupoHijo() > 0 && this.loadedModel()?.coTipo != null
  );
  readonly isLoadingHijos = computed(() => this.hijosResource.isLoading());

  form = buildForm(this.fb, [
    { name: 'nuOrden', validators: [...V.required, ...V.integer] },
    { name: 'noTipo', validators: [...V.required, ...V.maxLength(150)] },
    { name: 'txDescripcion', validators: [...V.maxLength(1000)] },
    { name: 'noSigla', validators: [...V.maxLength(5)] },
    { name: 'flDefault', value: false },
  ]);

  private readonly hijosResource = rxResource({
    defaultValue: EMPTY_PAGE,
    params: () => {
      if (!this.hijosFetchReady()) return null;

      const parent = this.loadedModel();
      const coGrupoHijo = this.coGrupoHijo();
      if (!parent?.coTipo || !coGrupoHijo) return null;

      return {
        coTipoPadre: parent.coTipo,
        coGrupoPadre: parent.coGrupo,
        coGrupo: coGrupoHijo,
        coModulo: parent.coModulo,
        coEmpresa: parent.coEmpresa,
      };
    },
    stream: ({ params }) => {
      if (params === null) return of(EMPTY_PAGE);
      return this.tipoParticularService.selAllChildren(params as TipoParticularModel);
    },
  });

  constructor() {
    super();

    effect(() => {
      const payload = this.data();
      if (!payload) {
        untracked(() => {
          this.currentInitKey = null;
          this.nextOrderKey = null;
          this.resetModalState();
        });
        return;
      }

      const initKey = this.buildInitKey(payload);
      if (initKey === this.currentInitKey) return;

      untracked(() => this.initFromPayload(payload, initKey));
    });

    effect(() => {
      const page = this.hijosResource.value();
      if (!page || this.hijosResource.isLoading()) return;
      untracked(() => this.syncHijosFromServer(page.data ?? []));
    });
  }

  // ── Template API ──────────────────────────────────────────────────────────

  getError(field: string): string | null {
    return getError(this.form, field) || null;
  }

  getHijoError(hijo: HijoRow, field: HijoField): string | null {
    return this.hijoFieldErrors().get(this.hijoKey(hijo))?.[field] ?? null;
  }

  hasHijoErrors(hijo: HijoRow): boolean {
    const errors = this.hijoFieldErrors().get(this.hijoKey(hijo));
    return !!errors && Object.keys(errors).length > 0;
  }

  clearHijoError(hijo: HijoRow, field: HijoField): void {
    const key = this.hijoKey(hijo);
    const current = this.hijoFieldErrors().get(key);
    if (!current?.[field]) return;

    const nextErrors = { ...current };
    delete nextErrors[field];
    this.setHijoErrors(hijo, nextErrors);
  }

  clearParentFormError(field: string): void {
    if (!this.showParentFormErrors()) return;
    if (this.form.get(field)?.invalid) return;
    if (!Object.values(this.form.controls).some((c) => c.invalid)) {
      this.showParentFormErrors.set(false);
    }
  }

  isEditando(item: HijoRow): boolean {
    const id = this.editandoId();
    return id !== null && (id === item.coTipo || id === item._tempId);
  }

  // ── Padre ───────────────────────────────────────────────────────────────────

  protected override onSave(): void {
    this.form.markAllAsTouched();
    if (this.form.invalid) {
      this.showParentFormErrors.set(true);
      return;
    }
    this.showParentFormErrors.set(false);

    const request = this.buildRequest();
    const isInsert = request.coTipo == null;
    const save$ = isInsert
      ? this.tipoParticularService.insert(request)
      : this.tipoParticularService.update(request);

    save$.pipe(takeUntilDestroyed(this.destroyRef)).subscribe({
      next: (response) => {
        const coTipo = Number(isInsert ? response : (request.coTipo ?? response));
        this.refreshAndCompleteSave({ ...request, coTipo }, coTipo, isInsert);
      },
      error: () => this.handleError(null, 'Error al guardar el tipo'),
    });
  }

  // ── Hijos ─────────────────────────────────────────────────────────────────

  agregarHijo(): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();

    const parent = this.loadedModel();
    const coGrupoHijo = this.coGrupoHijo();
    if (!parent?.coTipo || !coGrupoHijo) return;

    const tempId = this.tempIdCounter--;
    const nueva: HijoRow = {
      _tempId: tempId,
      coModulo: parent.coModulo,
      coEmpresa: parent.coEmpresa,
      coGrupo: coGrupoHijo,
      coGrupoPadre: parent.coGrupo,
      coTipoPadre: parent.coTipo,
      nuOrden: 0,
      noTipo: '',
      noSigla: '',
      txDescripcion: '',
      flDefault: 0,
    };

    this.hijos.update((list) => [...list, nueva]);
    this.editandoId.set(tempId);

    this.tipoParticularService
      .selNextOrder(nueva)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (response) => {
          const nuOrden = this.resolveNuOrden(response);
          this.hijos.update((list) =>
            list.map((x) => (x._tempId === tempId ? { ...x, nuOrden } : x))
          );
          this.focusHijoNoTipo(tempId);
        },
      });
  }

  editarHijo(item: HijoRow): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();

    const current = this.findHijo(item);
    if (!current) return;

    this.clearHijoErrors(current);
    const id = current.coTipo ?? current._tempId!;
    this.editandoId.set(id);
    this.focusHijoNoTipo(id);
  }

  guardarHijo(item: HijoRow): void {
    const current = this.findHijo(item);
    if (!current) return;

    const errors = this.validateHijo(current);
    if (Object.keys(errors).length > 0) {
      this.setHijoErrors(current, errors);
      this.focusFirstHijoError(current, errors);
      return;
    }
    this.clearHijoErrors(current);

    const esNuevo = !current.coTipo;
    const request = this.buildHijoRequest(current);
    const save$ = esNuevo
      ? this.tipoParticularService.insert(request)
      : this.tipoParticularService.update(request);

    save$.pipe(takeUntilDestroyed(this.destroyRef)).subscribe({
      next: (id) => {
        const saved = esNuevo
          ? { ...request, coTipo: id, flEstReg: current.flEstReg ?? 1 }
          : request;

        this.hijos.update((list) =>
          list.map((x) =>
            (esNuevo && x._tempId === current._tempId) || (!esNuevo && x.coTipo === current.coTipo)
              ? { ...saved, _tempId: undefined }
              : x
          )
        );
        this.editandoId.set(null);
        this.clearHijoErrors(current);

        if (this.hijosFetchReady()) {
          this.hijosResource.reload();
        } else {
          this.hijosFetchReady.set(true);
        }

        this.toastr.success('Registro hijo guardado', 'Éxito');
      },
      error: () => this.toastr.error('Error al guardar el registro hijo', 'Error'),
    });
  }

  cancelarEdicion(item: HijoRow): void {
    if (!item.coTipo) {
      this.hijos.update((list) => list.filter((x) => x._tempId !== item._tempId));
    }
    this.clearHijoErrors(item);
    this.editandoId.set(null);
  }

  async eliminarHijo(item: HijoRow): Promise<void> {
    const current = this.findHijo(item);
    if (!current) return;

    const ok = await this.confirmService.confirm(
      '¿Eliminar registro hijo?',
      `Se eliminará ${current.noTipo ?? 'el registro'}`,
      'Sí, eliminar'
    );
    if (!ok) return;

    if (!current.coTipo) {
      this.hijos.update((list) => list.filter((x) => x._tempId !== current._tempId));
      this.editandoId.set(null);
      return;
    }

    this.tipoParticularService
      .deleteById(this.buildHijoKey(current))
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          const coTipo = Number(current.coTipo);
          this.hijos.update((list) => list.filter((x) => Number(x.coTipo) !== coTipo));
          this.editandoId.set(null);
          this.toastr.success('Registro hijo eliminado', 'Éxito');
        },
        error: () => this.toastr.error('Error al eliminar', 'Error'),
      });
  }

  updateStateHijo(item: HijoRow): void {
    const current = this.findHijo(item);
    if (!current?.coTipo) return;

    const flEstReg = current.flEstReg === 1 ? 0 : 1;

    this.tipoParticularService
      .updateState({ ...this.buildHijoRequest(current), flEstReg })
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.hijos.update((list) =>
            list.map((x) => (x.coTipo === current.coTipo ? { ...x, flEstReg } : x))
          );
          this.toastr.success('Estado actualizado', 'Éxito');
        },
        error: () => this.toastr.error('Error al actualizar estado', 'Error'),
      });
  }

  // ── Inicialización ────────────────────────────────────────────────────────

  private initFromPayload(payload: ModalPayload<TipoParticularModel>, initKey: string): void {
    this.currentInitKey = initKey;
    this.resetModalState();

    const grupo = payload.relations?.['grupo'] as TipoParticularModel | undefined;
    if (grupo) this.grupoContext.set(grupo);

    const action = payload.metaData?.action ?? (payload.model?.coTipo != null ? 'update' : 'insert');

    if (action === 'update' && payload.model) {
      this.loadById(payload.model);
      return;
    }

    if (payload.model) {
      this.loadedModel.set(payload.model);
      this.ensureGrupoFallback(payload.model);
      this.loadNextOrderPadre(payload.model);
    }
  }

  private resetModalState(): void {
    this.nextOrderKey = null;
    this.showHijosAvailableHint.set(false);
    this.hijosFetchReady.set(false);
    this.hijoFieldErrors.set(new Map());
    this.showParentFormErrors.set(false);
    this.loadedModel.set(null);
    this.grupoContext.set(null);
    this.hijos.set([]);
    this.editandoId.set(null);
    this.clearForm();
  }

  private buildInitKey(payload: ModalPayload<TipoParticularModel>): string {
    const action = payload.metaData?.action ?? (payload.model?.coTipo != null ? 'update' : 'insert');
    const model = payload.model;
    return [action, model?.coModulo, model?.coGrupo, model?.coTipo ?? 'new'].join(':');
  }

  // ── Carga de datos ────────────────────────────────────────────────────────

  private loadById(source: TipoParticularModel): void {
    this.tipoParticularService
      .selById(this.buildSelByIdParams(source))
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (record) => this.applyRecord(source, record),
        error: () => {
          this.loadedModel.set(source);
          this.enableHijosIfNeeded(source);
        },
      });
  }

  private refreshAndCompleteSave(
    pending: TipoParticularModel,
    coTipo: number,
    isInsert: boolean
  ): void {
    this.tipoParticularService
      .selById(this.buildSelByIdParams(pending))
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (record) => this.completeParentSave({ ...pending, ...record }, coTipo, isInsert),
        error: () => this.completeParentSave(pending, coTipo, isInsert),
      });
  }

  private applyRecord(source: TipoParticularModel, record: TipoParticularModel): void {
    const merged = { ...source, ...record };
    this.loadedModel.set(merged);
    this.patchForm(record);
    this.enableHijosIfNeeded(merged);
  }

  private completeParentSave(
    record: TipoParticularModel,
    coTipo: number,
    isInsert: boolean
  ): void {
    const saved: TipoParticularModel = {
      ...record,
      coTipo,
      flEstReg: record.flEstReg ?? 1,
      qtHijo: record.qtHijo ?? 0,
    };

    this.loadedModel.set(saved);

    const canAddHijos = (saved.coGrupoHijo ?? 0) > 0;
    if (canAddHijos) {
      this.hijos.set([]);
      this.hijosFetchReady.set(true);
    }

    if (isInsert && canAddHijos) {
      this.showHijosAvailableHint.set(true);
      this.handleSuccess('Tipo guardado. Ya puede agregar registros hijos.', saved);
      return;
    }

    this.handleSuccess('Tipo guardado exitosamente', saved);
    this.modalService.close();
  }

  private enableHijosIfNeeded(record: TipoParticularModel): void {
    if ((record.coGrupoHijo ?? 0) > 0) {
      this.hijosFetchReady.set(true);
      return;
    }
    this.loadGrupoFallback(record, () => this.hijosFetchReady.set(true));
  }

  private ensureGrupoFallback(model: TipoParticularModel): void {
    if (this.coGrupoHijo() > 0) return;
    this.loadGrupoFallback(model);
  }

  private loadGrupoFallback(model: TipoParticularModel, onReady?: () => void): void {
    if (!model.coGrupo) {
      onReady?.();
      return;
    }

    const existing = this.grupoContext();
    if (existing?.coGrupoHijo && existing.coGrupo === model.coGrupo) {
      onReady?.();
      return;
    }

    this.tipoParticularService
      .selGroup({
        coGrupo: model.coGrupo,
        coModulo: model.coModulo,
        coEmpresa: model.coEmpresa,
      } as TipoParticularModel)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (grupo) => {
          this.grupoContext.set(grupo);
          onReady?.();
        },
        error: () => onReady?.(),
      });
  }

  private loadNextOrderPadre(model: TipoParticularModel): void {
    const key = `padre:${model.coModulo}:${model.coGrupo}`;
    if (this.nextOrderKey === key) return;
    this.nextOrderKey = key;

    this.tipoParticularService
      .selNextOrder(model)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (response) => {
          this.form.patchValue({ nuOrden: this.resolveNuOrden(response) }, { emitEvent: false });
          this.focusNoTipo();
        },
        error: () => {
          this.nextOrderKey = null;
        },
      });
  }

  private syncHijosFromServer(serverRows: HijoRow[]): void {
    const pending = untracked(() => this.hijos().filter((h) => h._tempId != null));
    this.hijos.set(pending.length ? [...serverRows, ...pending] : serverRows);
  }

  // ── Builders ──────────────────────────────────────────────────────────────

  private buildRequest(): TipoParticularModel {
    const raw = this.form.getRawValue();
    const current = this.loadedModel();

    return {
      coGrupo: current?.coGrupo ?? this.model()?.coGrupo,
      coTipo: current?.coTipo ?? this.model()?.coTipo,
      coEmpresa: current?.coEmpresa ?? this.model()?.coEmpresa,
      coModulo: current?.coModulo ?? this.model()?.coModulo,
      coGrupoPadre: current?.coGrupoPadre ?? this.model()?.coGrupoPadre,
      coTipoPadre: current?.coTipoPadre ?? this.model()?.coTipoPadre,
      nuOrden: raw['nuOrden'] ?? 0,
      noTipo: raw['noTipo'] ?? '',
      txDescripcion: raw['txDescripcion'] ?? '',
      noSigla: raw['noSigla'] ?? '',
      flDefault: raw['flDefault'] === true ? 1 : 0,
    };
  }

  private buildSelByIdParams(source: TipoParticularModel): TipoParticularModel {
    const base = this.loadedModel() ?? this.model();

    return {
      coTipo: source.coTipo ?? base?.coTipo,
      coGrupo: source.coGrupo ?? base?.coGrupo,
      coModulo: source.coModulo ?? base?.coModulo,
      coEmpresa: source.coEmpresa ?? base?.coEmpresa,
    };
  }

  private buildHijoKey(item: HijoRow): TipoParticularModel {
    const parent = this.loadedModel();
    const coGrupoHijo = this.coGrupoHijo();

    return {
      coTipo: item.coTipo,
      coGrupo: coGrupoHijo || item.coGrupo,
      coEmpresa: item.coEmpresa ?? parent?.coEmpresa,
      coModulo: item.coModulo ?? parent?.coModulo,
      coGrupoPadre: item.coGrupoPadre ?? parent?.coGrupo,
      coTipoPadre: item.coTipoPadre ?? parent?.coTipo,
    };
  }

  private buildHijoRequest(item: HijoRow): TipoParticularModel {
    return {
      ...this.buildHijoKey(item),
      nuOrden: Number(item.nuOrden ?? 0),
      noTipo: item.noTipo?.trim() ?? '',
      txDescripcion: item.txDescripcion ?? '',
      noSigla: item.noSigla ?? '',
      flDefault: item.flDefault === 1 ? 1 : 0,
      flEstReg: item.flEstReg,
    };
  }

  // ── Validación hijos ──────────────────────────────────────────────────────

  private validateHijo(hijo: HijoRow): HijoFieldErrors {
    const errors: HijoFieldErrors = {};

    if (!hijo.noTipo?.trim()) {
      errors.noTipo = 'El nombre es obligatorio';
    }

    const nuOrden = Number(hijo.nuOrden);
    if (hijo.nuOrden == null || !Number.isFinite(nuOrden) || nuOrden < 0) {
      errors.nuOrden = 'El orden es obligatorio';
    }

    return errors;
  }

  private setHijoErrors(hijo: HijoRow, errors: HijoFieldErrors): void {
    const key = this.hijoKey(hijo);
    this.hijoFieldErrors.update((map) => {
      const next = new Map(map);
      if (Object.keys(errors).length === 0) next.delete(key);
      else next.set(key, errors);
      return next;
    });
  }

  private clearHijoErrors(hijo: HijoRow): void {
    this.setHijoErrors(hijo, {});
  }

  // ── Utilidades ────────────────────────────────────────────────────────────

  private findHijo(item: HijoRow): HijoRow | undefined {
    return this.hijos().find(
      (h) =>
        (item._tempId != null && h._tempId === item._tempId) ||
        (item.coTipo != null && Number(h.coTipo) === Number(item.coTipo))
    );
  }

  private hijoKey(hijo: HijoRow): number {
    return hijo.coTipo ?? hijo._tempId!;
  }

  private cancelarEdicionActual(): void {
    const editingId = this.editandoId();
    if (editingId != null) {
      const editing = this.hijos().find(
        (h) => h.coTipo === editingId || h._tempId === editingId
      );
      if (editing) this.clearHijoErrors(editing);
    }
    this.hijos.update((list) => list.filter((x) => x.coTipo != null));
    this.editandoId.set(null);
  }

  private resolveNuOrden(response: TipoParticularModel | number): number {
    return typeof response === 'number' ? response : (response.nuOrden ?? 0);
  }

  private patchForm(record: TipoParticularModel): void {
    this.form.patchValue({
      nuOrden: record.nuOrden,
      noTipo: record.noTipo,
      txDescripcion: record.txDescripcion,
      noSigla: record.noSigla,
      flDefault: record.flDefault === 1,
    });
  }

  private focusNoTipo(): void {
    afterNextRender(() => {
      const el = this.firstInputRef()?.nativeElement;
      el?.focus();
      el?.select();
    }, { injector: this.injector });
  }

  private focusHijoNoTipo(id: number): void {
    afterNextRender(() => {
      const el = document.getElementById(`hijo-noTipo-${id}`) as HTMLInputElement | null;
      el?.focus();
      el?.select();
    }, { injector: this.injector });
  }

  private focusFirstHijoError(hijo: HijoRow, errors: HijoFieldErrors): void {
    const id = this.hijoKey(hijo);
    if (errors.noTipo) {
      this.focusHijoNoTipo(id);
      return;
    }
    if (errors.nuOrden) {
      afterNextRender(() => {
        const el = document.getElementById(`hijo-nuOrden-${id}`) as HTMLInputElement | null;
        el?.focus();
        el?.select();
      }, { injector: this.injector });
    }
  }
}
