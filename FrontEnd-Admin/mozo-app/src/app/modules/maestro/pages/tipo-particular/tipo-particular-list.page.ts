import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
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

  private readonly empresaModuloService = inject(EmpresaModuloService);
  private readonly modalService = inject(ModalService);

  protected override readonly crudService = inject(TipoParticularService);
  protected override readonly entityLabel = 'Tipo Particular';

  readonly selectedModulo = signal<number | null>(null);
  readonly selectedGrupo = signal<number | null>(null);
  readonly pageIndex = signal(1);
  readonly pageSize = 10;

  readonly modulos = toSignal(this.empresaModuloService.selAll({ flEmpresaNotKey: 0 }), { initialValue: [] });

  private readonly gruposModulo = signal<number | null>(null);

  private readonly gruposResource = rxResource({
    defaultValue: [] as TipoParticularModel[],
    params: () => this.gruposModulo(),
    stream: ({ params: coModulo }) =>
      coModulo !== null
        ? this.crudService.selAllGroupsByModule({ coModulo } as TipoParticularModel)
        : of([] as TipoParticularModel[]),
  });

  private readonly tipoParticularResource = rxResource({
    defaultValue: EMPTY_PAGE,
    params: () => {
      const coGrupo = this.selectedGrupo();
      const coModulo = this.selectedModulo();
      if (coGrupo === null || coModulo === null) return null;
      return {
        coModulo,
        coGrupo,
        pageIndex: this.pageIndex(),
      };
    },
    stream: ({ params }) => {
      if (params === null) return of(EMPTY_PAGE);
      return this.crudService.selAll({
        coModulo: params.coModulo,
        coGrupo: params.coGrupo,
        pageIndex: params.pageIndex - 1,
        pageSize: this.pageSize,
      } as TipoParticularModel);
    },
  });

  /** Adapts the paginated resource to the flat-array interface required by CrudListPageBase. */
  protected override readonly listResource: WritableListResource<TipoParticularModel> = {
    update: (updater) =>
      this.tipoParticularResource.update((result) =>
        result ? { ...result, data: updater(result.data) } : result
      ),
    reload: () => this.tipoParticularResource.reload(),
  };

  readonly grupos = computed(() => this.gruposResource.value() ?? []);
  readonly isLoadingGrupos = computed(() => this.gruposResource.isLoading());
  readonly tipoParticulares = computed(() => this.tipoParticularResource.value()?.data ?? []);
  readonly rowsCount = computed(() => this.tipoParticularResource.value()?.rowsCount ?? 0);
  readonly isLoadingGrid = computed(
    () => this.selectedGrupo() !== null && this.tipoParticularResource.isLoading()
  );
  readonly gridEmptyMessage = computed(() =>
    this.selectedGrupo() === null
      ? 'Seleccione un grupo para ver los tipos'
      : 'No hay tipos registrados'
  );

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit, action: 'edit' },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById' },
    { type: MenuControlTypeEnum.State, action: 'updateState' },
  ];

  readonly showPagination = computed(() => this.pageCount > 1);

  get pageCount(): number {
    return Math.ceil(this.rowsCount() / this.pageSize);
  }

  onModuloChange(coModulo: number): void {
    this.selectedModulo.set(coModulo);
    this.selectedGrupo.set(null);
    this.pageIndex.set(1);
    this.tipoParticularResource.update(() => EMPTY_PAGE);
    this.gruposModulo.set(coModulo);
    this.gruposResource.reload();
  }

  onGrupoChange(coGrupo: number): void {
    this.selectedGrupo.set(coGrupo);
    this.pageIndex.set(1);
    this.tipoParticularResource.reload();
  }

  goToPage(p: number): void {
    this.pageIndex.set(p);
  }

  protected override matchesId(a: TipoParticularModel, b: TipoParticularModel): boolean {
    return a.coTipo === b.coTipo;
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

    const payload: ModalPayload<TipoParticularModel> = {
      model: c ?? {
        coModulo: this.selectedModulo()!,
        coGrupo: this.selectedGrupo()!,
      },
      metaData: { action: c ? 'update' : 'insert' },
    };

    this.modalService.open<TipoParticularModel>({
      modalName: 'tipo-particular-form-page',
      title: (c ? 'Editar' : 'Nuevo') + ' Tipo',
      size: 'lg',
      data: payload,
    });
  }

  /** Overrides base to also decrement rowsCount in the paginated result. */
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
          this.tipoParticularResource.update((result) =>
            result
              ? {
                  ...result,
                  data: result.data.filter((x) => x.coTipo !== c.coTipo),
                  rowsCount: result.rowsCount - 1,
                }
              : result
          );
          this.toastr.success(`${this.entityLabel} eliminado`, 'Éxito');
        },
      });
  }
}
