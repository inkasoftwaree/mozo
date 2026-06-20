import { ChangeDetectionStrategy, Component, computed, effect, inject, signal, untracked } from '@angular/core';
import { rxResource, takeUntilDestroyed, toSignal } from '@angular/core/rxjs-interop';
import { of } from 'rxjs';
import { FormsModule } from '@angular/forms';
import { MenuControlModel } from '@app/shared/models/controls/menu-control.model';
import { MenuControl } from '@app/shared/components/menu/menu.control';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { StateControl } from '@app/shared/components/state/state.control';
import { ModalService } from '@app/shared/services/modal.service';
import { ModalControl } from '@app/shared/components/modal/modal.control';
import { ButtonControl } from '@app/shared/components/button/button.control';
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { PaginationControl } from '@app/shared/components/pagination/pagination.control';
import { GenericGridCControl } from '@app/shared/components/grid/grid.control';
import { CrudListPageBase, WritableListResource } from '@app/shared/components/list/crud-list-page-base';
import { TipoParticularService } from '../../services/tipo-particular.service';
import { TipoParticularModel } from '@app/shared/models/maestro/tipo-particular.model';
import { TipoParticularFormPage } from './tipo-particular-form.page';
import { FormFieldControl } from '@app/shared/components/form-field/form-field.control';
import { MSG_FIELD_FORM } from '@app/core/global/constants';
import { PagedResult } from '@app/shared/models/base.model';
import { EmpresaModuloService } from '@app/modules/seguridad/services/empresa-modulo.service';

const EMPTY_PAGE: PagedResult<TipoParticularModel> = { rowsCount: 0, data: [] };
const MODAL_NAME = 'tipo-particular-form-page';

@Component({
  selector: 'mz-tipo-particular-list-page',
  standalone: true,
  templateUrl: './tipo-particular-list.page.html',
  imports: [
    FormsModule,
    MenuControl,
    ModalControl,
    StateControl,
    ButtonControl,
    PaginationControl,
    GenericGridCControl,
    TipoParticularFormPage,
    FormFieldControl,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class TipoParticularListPage extends CrudListPageBase<TipoParticularModel> {
  protected readonly MSG_FIELD_FORM = MSG_FIELD_FORM;
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;
  protected override readonly crudService = inject(TipoParticularService);
  protected override readonly entityLabel = 'Tipo Particular';

  private readonly empresaModuloService = inject(EmpresaModuloService);
  private readonly modalService = inject(ModalService);

  readonly selectedModulo = signal<number | null>(null);
  readonly selectedGrupo = signal<number | null>(null);
  readonly pageIndex = signal(1);
  readonly pageSize = 10;

  readonly modulos = toSignal(this.empresaModuloService.selAll({ flEmpresaNotKey: 0 }), { initialValue: [] });

  private readonly gruposModulo = signal<number | null>(null);
  private formModalWasOpen = false;

  private readonly gruposResource = rxResource({
    defaultValue: [] as TipoParticularModel[],
    params: () => this.gruposModulo(),
    stream: ({ params: coModulo }) => {
      if (coModulo === null) return of([]);

      const modulo = this.modulos().find((m) => m.coModulo === coModulo);
      return this.crudService.selAllGroupsByModule({
        coModulo,
        coEmpresa: modulo?.coEmpresa,
      } as TipoParticularModel);
    },
  });

  private readonly gridQueryParams = computed(() => {
    const coGrupo = this.selectedGrupo();
    const coModulo = this.selectedModulo();
    if (coGrupo === null || coModulo === null) return null;

    const modulo = this.modulos().find((m) => m.coModulo === coModulo);
    return {
      coModulo,
      coGrupo,
      coEmpresa: modulo?.coEmpresa,
      pageIndex: this.pageIndex(),
    };
  });

  private readonly tipoParticularResource = rxResource({
    defaultValue: EMPTY_PAGE,
    params: () => this.gridQueryParams(),
    stream: ({ params }) => {
      if (params === null) return of(EMPTY_PAGE);

      return this.crudService.selAll({
        coModulo: params.coModulo,
        coGrupo: params.coGrupo,
        coEmpresa: params.coEmpresa,
        pageIndex: params.pageIndex - 1,
        pageSize: this.pageSize,
      } as TipoParticularModel);
    },
  });

  protected override readonly listResource: WritableListResource<TipoParticularModel> = {
    update: (updater) =>
      this.tipoParticularResource.update((result) =>
        result ? { ...result, data: updater(result.data) } : result
      ),
    reload: () => this.tipoParticularResource.reload(),
  };

  readonly grupos = computed(() => this.gruposResource.value() ?? []);
  readonly isLoadingGrupos = computed(() => this.gruposResource.isLoading());
  readonly tipoParticulares = computed(() => {
    if (!this.hasGridFilters()) return [];
    return this.tipoParticularResource.value()?.data ?? [];
  });
  readonly rowsCount = computed(() => {
    if (!this.hasGridFilters()) return 0;
    return this.tipoParticularResource.value()?.rowsCount ?? 0;
  });
  readonly isLoadingGrid = computed(
    () => this.selectedGrupo() !== null && this.tipoParticularResource.isLoading()
  );
  readonly gridEmptyMessage = computed(() =>
    this.selectedGrupo() === null
      ? 'Seleccione un grupo para ver los tipos'
      : 'No hay tipos registrados'
  );
  readonly showPagination = computed(() => this.pageCount > 1);

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit, action: 'edit' },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById' },
    { type: MenuControlTypeEnum.State, action: 'updateState' },
  ];

  constructor() {
    super();

    effect(() => {
      const isFormOpen = this.modalService.state()?.modalName === MODAL_NAME;
      const wasOpen = untracked(() => this.formModalWasOpen);

      if (wasOpen && !isFormOpen && this.selectedGrupo() !== null) {
        untracked(() => this.tipoParticularResource.reload());
      }

      untracked(() => {
        this.formModalWasOpen = isFormOpen;
      });
    });
  }

  get pageCount(): number {
    return Math.ceil(this.rowsCount() / this.pageSize);
  }

  // ── Filtros ───────────────────────────────────────────────────────────────

  onModuloChange(coModulo: number): void {
    this.selectedModulo.set(coModulo);
    this.selectedGrupo.set(null);
    this.pageIndex.set(1);
    this.tipoParticularResource.update(() => EMPTY_PAGE);
    this.gruposModulo.set(coModulo);
  }

  onGrupoChange(coGrupo: number): void {
    this.selectedGrupo.set(coGrupo);
    this.pageIndex.set(1);
  }

  goToPage(page: number): void {
    this.pageIndex.set(page);
  }

  // ── CRUD ──────────────────────────────────────────────────────────────────

  override onSaved(saved?: unknown): void {
    const raw = saved as TipoParticularModel | null | undefined;
    if (!raw?.coTipo || !this.hasGridFilters()) return;

    const item = this.enrichSavedItem(raw);
    const coTipo = Number(item.coTipo);

    this.pageIndex.set(1);
    this.tipoParticularResource.update((result) => {
      if (!result) return result;

      const exists = result.data.some((x) => Number(x.coTipo) === coTipo);
      if (exists) {
        return {
          ...result,
          data: result.data.map((x) =>
            Number(x.coTipo) === coTipo ? { ...x, ...item } : x
          ),
        };
      }

      return {
        ...result,
        data: [item, ...result.data],
        rowsCount: result.rowsCount + 1,
      };
    });
  }

  protected override matchesId(a: TipoParticularModel, b: TipoParticularModel): boolean {
    return Number(a.coTipo) === Number(b.coTipo);
  }

  protected override getDeleteDescription(c: TipoParticularModel): string {
    return `Se eliminará ${c.noTipo ?? 'el registro'}`;
  }

  protected override async openModal(c: TipoParticularModel | null): Promise<void> {
    if (this.selectedModulo() === null) {
      await this.confirmService.error('Crear Tipo', 'Falta seleccionar el Módulo');
      return;
    }
    if (this.selectedGrupo() === null) {
      await this.confirmService.error('Crear Tipo', 'Falta seleccionar el Grupo');
      return;
    }

    const modulo = this.selectedModuloItem();

    this.modalService.open<TipoParticularModel>({
      modalName: MODAL_NAME,
      title: (c ? 'Editar' : 'Nuevo') + ' Tipo',
      size: 'lg',
      data: this.buildModalPayload(c, modulo),
    });
  }

  protected override async deleteById(c: TipoParticularModel): Promise<void> {
    const ok = await this.confirmService.confirm(
      `¿Eliminar ${this.entityLabel}?`,
      this.getDeleteDescription(c),
      'Sí, eliminar'
    );
    if (!ok) return;

    this.crudService
      .deleteById(c)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          const coTipo = Number(c.coTipo);
          this.tipoParticularResource.update((result) =>
            result
              ? {
                  ...result,
                  data: result.data.filter((x) => Number(x.coTipo) !== coTipo),
                  rowsCount: result.rowsCount - 1,
                }
              : result
          );
          this.toastr.success(`${this.entityLabel} eliminado`, 'Éxito');
        },
      });
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  private hasGridFilters(): boolean {
    return this.selectedGrupo() !== null && this.selectedModulo() !== null;
  }

  private selectedModuloItem() {
    return this.modulos().find((m) => m.coModulo === this.selectedModulo());
  }

  private selectedGrupoItem() {
    return this.grupos().find(
      (g) => (g.coGrupo ?? g.coTipo) === this.selectedGrupo()
    );
  }

  private buildModalPayload(
    c: TipoParticularModel | null,
    modulo: ReturnType<typeof this.selectedModuloItem>
  ): ModalPayload<TipoParticularModel> {
    return {
      model: c ?? {
        coModulo: this.selectedModulo()!,
        coGrupo: this.selectedGrupo()!,
        coEmpresa: modulo?.coEmpresa,
      },
      relations: { grupo: this.selectedGrupoItem() ?? null },
      metaData: { action: c ? 'update' : 'insert' },
    };
  }

  private enrichSavedItem(item: TipoParticularModel): TipoParticularModel {
    const grupo = this.selectedGrupoItem();
    const modulo = this.selectedModuloItem();

    return {
      ...item,
      coGrupo: item.coGrupo ?? this.selectedGrupo() ?? undefined,
      coModulo: item.coModulo ?? this.selectedModulo() ?? undefined,
      coEmpresa: item.coEmpresa ?? modulo?.coEmpresa,
      coGrupoHijo: item.coGrupoHijo ?? grupo?.coGrupoHijo,
      qtHijo: item.qtHijo ?? 0,
      flEstReg: item.flEstReg ?? 1,
    };
  }
}
