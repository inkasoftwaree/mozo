import { ChangeDetectionStrategy, Component, computed, effect, inject, signal } from '@angular/core';
import { rxResource, takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { forkJoin } from 'rxjs';
import { MenuControlModel } from '@app/shared/models/controls/menu-control.model';
import { MenuControl } from "@app/shared/components/menu/menu.control";
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { StateControl } from "@app/shared/components/state/state.control";
import { ModalService } from '@app/shared/services/modal.service';
import { ModalControl } from "@app/shared/components/modal/modal.control";
import { ButtonControl } from "@app/shared/components/button/button.control";
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { EmpresaFormPage } from "./empresa-form.page";
import { EmpresaModel } from '@app/shared/models/seguridad/empresa.model';
import { EmpresaService } from '../../services/empresa.service';
import { PaginationControl } from "@app/shared/components/pagination/pagination.control";
import { EmpresaModuloService } from '../../services/empresa-modulo.service';
import { EmpresaModuloModel } from '@app/shared/models/seguridad/empresa-modulo.model';
import { GenericGridCControl } from "@app/shared/components/grid/grid.control";
import { CrudListPageBase, WritableListResource } from '@app/shared/components/list/crud-list-page-base';

@Component({
  selector: 'mz-empresa-list-page',
  standalone: true,
  templateUrl: './empresa-list.page.html',
  styleUrl: './empresa-list.page.css',
  imports: [MenuControl, ModalControl, StateControl, ButtonControl, EmpresaFormPage, PaginationControl, GenericGridCControl],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class EmpresaListPage extends CrudListPageBase<EmpresaModel> {
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  private readonly empresaModuloService = inject(EmpresaModuloService);
  private readonly modalService = inject(ModalService);

  protected override readonly crudService = inject(EmpresaService);
  protected override readonly entityLabel = 'Empresa';

  readonly pageIndex = signal(1);
  readonly pageSize = 10;

  private readonly empresasResource = rxResource({
    params: () => this.pageIndex(),
    stream: ({ params: pageIndex }) =>
      this.crudService.selAll({
        pageIndex: pageIndex - 1,
        pageSize: this.pageSize
      } as EmpresaModel)
  });

  /** Adapts the paginated resource to the flat-array interface required by CrudListPageBase. */
  protected override readonly listResource: WritableListResource<EmpresaModel> = {
    update: (updater) => this.empresasResource.update(result =>
      result ? { ...result, data: updater(result.data) } : result
    ),
    reload: () => this.empresasResource.reload()
  };

  readonly empresas = computed(() => this.empresasResource.value()?.data ?? []);
  readonly rowsCount = computed(() => this.empresasResource.value()?.rowsCount ?? 0);

  get pageCount(): number {
    return Math.ceil(this.rowsCount() / this.pageSize);
  }

  readonly empresaModulos = signal<Map<number, EmpresaModuloModel[]>>(new Map());

  constructor() {
    super();
    effect(() => this.loadEmpresaModulos(this.empresas()));
  }

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit, action: 'edit' },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById' },
    { type: MenuControlTypeEnum.State, action: 'updateState' }
  ];

  goToPage(p: number): void {
    this.pageIndex.set(p);
  }

  protected override matchesId(a: EmpresaModel, b: EmpresaModel): boolean {
    return a.coEmpresa === b.coEmpresa;
  }

  protected override getDeleteDescription(_c: EmpresaModel): string {
    return 'Se eliminará la Empresa';
  }

  protected override openModal(c: EmpresaModel | null): void {
    const payload: ModalPayload<EmpresaModel> = {
      model: c,
      metaData: { action: c ? 'update' : 'insert' }
    };
    this.modalService.open<EmpresaModel>({
      modalName: 'empresa-form-page',
      title: (c ? 'Editar' : 'Nuevo') + ' Empresa',
      size: 'lg',
      data: payload
    });
  }

  /** Overrides base to also decrement rowsCount in the paginated result. */
  protected override async deleteById(c: EmpresaModel): Promise<void> {
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
          this.empresasResource.update(result => result
            ? {
                ...result,
                data: result.data.filter(x => x.coEmpresa !== c.coEmpresa),
                rowsCount: result.rowsCount - 1
              }
            : result
          );
          this.toastr.success(`${this.entityLabel} eliminado`, 'Éxito');
        }
      });
  }

  /** Carga los módulos de todas las empresas en paralelo (evita N+1 secuencial). */
  loadEmpresaModulos(empresas: EmpresaModel[]): void {
    if (!empresas.length) {
      this.empresaModulos.set(new Map());
      return;
    }

    const requests = empresas.map(emp =>
      this.empresaModuloService.selAll({ coEmpresa: emp.coEmpresa } as EmpresaModuloModel)
    );

    forkJoin(requests)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(results => {
        const map = new Map<number, EmpresaModuloModel[]>();
        empresas.forEach((emp, i) => map.set(emp.coEmpresa!, results[i]));
        this.empresaModulos.set(map);
      });
  }

  getModulosTexto(coEmpresa: number): string {
    const mods = this.empresaModulos().get(coEmpresa);
    if (!mods) return '...';
    return mods.map(m => m.noModulo).join(', ');
  }
}
