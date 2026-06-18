import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
import { rxResource, takeUntilDestroyed, toSignal } from '@angular/core/rxjs-interop';
import { of } from 'rxjs';
import { ButtonControl } from "@app/shared/components/button/button.control";
import { FormFieldControl } from "@app/shared/components/form-field/form-field.control";
import { ModuloService } from '@moduleSeguridad/services/modulo.service';
import { MenuControlModel } from '@app/shared/models/controls/menu-control.model';
import { MenuControl } from "@app/shared/components/menu/menu.control";
import { StateControl } from "@app/shared/components/state/state.control";
import { MenuModel } from '@app/shared/models/seguridad/menu.model';
import { MenuService } from '../../services/menu.service';
import { ModalService } from '@app/shared/services/modal.service';
import { ModuloModel } from '@app/shared/models/seguridad/modulo.model';
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { FormsModule } from '@angular/forms';
import { ModalControl } from "@app/shared/components/modal/modal.control";
import { MenuFormPage } from "./menu-form.page";
import { PaginaModel } from '@app/shared/models/seguridad/pagina.model';
import { PaginaService } from '../../services/pagina.service';
import { PaginaFormPage } from "../pagina/pagina-form.page";
import { MSG_FIELD_FORM } from '@app/core/global/constants';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { CrudListPageBase, WritableListResource } from '@app/shared/components/list/crud-list-page-base';

@Component({
  selector: 'mz-menu-list-page',
  standalone: true,
  imports: [ButtonControl, FormFieldControl, MenuControl, StateControl, FormsModule, ModalControl, MenuFormPage, PaginaFormPage],
  templateUrl: './menu-list.page.html',
  styleUrl: './menu-list.page.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class MenuListPage extends CrudListPageBase<MenuModel> {
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;
  protected readonly MSG_FIELD_FORM = MSG_FIELD_FORM;

  private readonly moduloService = inject(ModuloService);
  private readonly paginaService = inject(PaginaService);
  private readonly modalService = inject(ModalService);

  protected override readonly crudService = inject(MenuService);
  protected override readonly entityLabel = 'Menú';

  readonly modulos        = toSignal(this.moduloService.selAllActive(), { initialValue: [] });
  readonly selectedModulo = signal<number | null>(null);

  private readonly menusResource = rxResource({
    params: () => this.selectedModulo(),
    stream: ({ params: coModulo }) =>
      coModulo !== null
        ? this.crudService.selArbol({ coModulo } as MenuModel)
        : of([])
  });

  /** Adaptador explícito: traduce rxResource<MenuModel[]> → WritableListResource<MenuModel> */
  protected override readonly listResource: WritableListResource<MenuModel> = {
    update: (updater) => this.menusResource.update(items => items ? updater(items) : items),
    reload: () => this.menusResource.reload()
  };

  readonly menus     = computed(() => this.menusResource.value() ?? []);
  readonly isLoading = computed(() => this.menusResource.isLoading());

  onModuloChange(coModulo: number): void {
    this.selectedModulo.set(coModulo);
  }

  /** Despacha acciones propias (newPagina) y delega el resto a la clase base. */
  override onMenuAction(action: string, c: MenuModel | null): void {
    if (action === 'newPagina') {
      this.openModalPagina(c!, null);
      return;
    }
    super.onMenuAction(action, c);
  }

  onMenuPaginaAction(action: string, menu: MenuModel, pagina: PaginaModel | null): void {
    const actions: Record<string, () => void> = {
      edit:        () => this.openModalPagina(menu, pagina),
      updateState: () => this.updateStatePagina(pagina!),
      deleteById:  () => this.deletePaginaById(pagina!)
    };
    actions[action]?.();
  }

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit,   action: 'edit'        },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById'  },
    { type: MenuControlTypeEnum.State,  action: 'updateState' },
    { type: MenuControlTypeEnum.New,    action: 'newPagina', label: 'Agregar sub Menú' }
  ];

  readonly menuPaginaItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit,   action: 'edit'        },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById'  },
    { type: MenuControlTypeEnum.State,  action: 'updateState' },
  ];

  protected override matchesId(a: MenuModel, b: MenuModel): boolean {
    return a.coMenu === b.coMenu;
  }

  protected override async openModal(c: MenuModel | null): Promise<void> {
    if (this.selectedModulo() === null) {
      await this.confirmService.error('Crear Menú', 'Falta seleccionar el Módulo');
      return;
    }
    const modulo: ModuloModel = this.modulos().find(m => m.coModulo === this.selectedModulo())!;
    const payload: ModalPayload<MenuModel> = {
      model: c,
      relations: { modulo },
      metaData: { action: c ? 'update' : 'insert' }
    };
    this.modalService.open<MenuModel>({
      modalName: 'menu-form-page-modal',
      title: (c ? 'Editar' : 'Nuevo') + ' Menú',
      size: 'sm',
      data: payload
    });
  }

  private async openModalPagina(menu: MenuModel, pagina: PaginaModel | null): Promise<void> {
    if (this.selectedModulo() === null) {
      await this.confirmService.error('Crear sub Menú', 'Falta seleccionar el Módulo');
      return;
    }
    const modulo: ModuloModel = this.modulos().find(m => m.coModulo === this.selectedModulo())!;
    const payload: ModalPayload<PaginaModel> = {
      model: pagina,
      relations: { modulo, menu },
      metaData: { action: pagina ? 'update' : 'insert' }
    };
    this.modalService.open<PaginaModel>({
      modalName: 'pagina-form-page-modal',
      title: (pagina ? 'Editar' : 'Nuevo') + ' sub Menú',
      size: 'lg',
      data: payload
    });
  }

  private updateStatePagina(c: PaginaModel): void {
    const flEstReg = c.flEstReg === 1 ? 0 : 1;

    this.paginaService
      .updateState({ ...c, flEstReg })
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.menusResource.update(menus =>
            (menus ?? []).map(menu =>
              menu.coMenu === c.coMenu
                ? {
                    ...menu,
                    paginaLst: (menu.paginaLst ?? []).map(p =>
                      p.coPagina === c.coPagina ? { ...p, flEstReg } : p
                    )
                  }
                : menu
            )
          );
          this.toastr.success('sub Menú actualizado', 'Éxito');
        }
      });
  }

  private async deletePaginaById(c: PaginaModel): Promise<void> {
    const ok = await this.confirmService.confirm(
      '¿Eliminar sub Menú?',
      'Se eliminará el registro',
      'Sí, eliminar'
    );
    if (!ok) return;

    this.paginaService
      .deleteById(c)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.menusResource.update(menus =>
            (menus ?? []).map(menu =>
              menu.coMenu === c.coMenu
                ? {
                    ...menu,
                    paginaLst: (menu.paginaLst ?? []).filter(p => p.coPagina !== c.coPagina)
                  }
                : menu
            )
          );
          this.toastr.success('sub Menú eliminado', 'Éxito');
        }
      });
  }
}
