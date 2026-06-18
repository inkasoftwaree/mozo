import { ChangeDetectionStrategy, Component, computed, inject } from '@angular/core';
import { rxResource } from '@angular/core/rxjs-interop';
import { ModuloService } from '@moduleSeguridad/services/modulo.service';
import { ModuloModel } from '@app/shared/models/seguridad/modulo.model';
import { MenuControlModel } from '@app/shared/models/controls/menu-control.model';
import { MenuControl } from "@app/shared/components/menu/menu.control";
import { StateControl } from "@app/shared/components/state/state.control";
import { ModalService } from '@app/shared/services/modal.service';
import { ModuloFormPage } from "./modulo-form.page";
import { ModalControl } from "@app/shared/components/modal/modal.control";
import { ButtonControl } from "@app/shared/components/button/button.control";
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { CrudListPageBase, WritableListResource } from '@app/shared/components/list/crud-list-page-base';
import { GenericGridCControl } from '@app/shared/components/grid/grid.control';

@Component({
  selector: 'mz-modulo-list-page',
  standalone: true,
  templateUrl: './modulo-list.page.html',
  styleUrl: './modulo-list.page.css',
  imports: [ModuloFormPage, MenuControl, ModalControl, StateControl, ButtonControl, GenericGridCControl],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ModuloListPage extends CrudListPageBase<ModuloModel> {
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  private readonly modalService = inject(ModalService);

  protected override readonly crudService = inject(ModuloService);
  protected override readonly entityLabel = 'Módulo';

  private readonly modulosResource = rxResource({
    stream: () => this.crudService.selAll()
  });

  /** Adaptador explícito: traduce rxResource<ModuloModel[]> → WritableListResource<ModuloModel> */
  protected override readonly listResource: WritableListResource<ModuloModel> = {
    update: (updater) => this.modulosResource.update(items => items ? updater(items) : items),
    reload: () => this.modulosResource.reload()
  };

  readonly modulos   = computed(() => this.modulosResource.value() ?? []);
  readonly isLoading = computed(() => this.modulosResource.isLoading());

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit,        action: 'edit'        },
    { type: MenuControlTypeEnum.Delete,      action: 'deleteById'  },
    { type: MenuControlTypeEnum.State,       action: 'updateState' },
  ];

  protected override matchesId(a: ModuloModel, b: ModuloModel): boolean {
    return a.coModulo === b.coModulo;
  }

  protected override getDeleteDescription(c: ModuloModel): string {
    return `Se eliminará ${c.noModulo}`;
  }

  protected override openModal(c: ModuloModel | null): void {
    const payload: ModalPayload<ModuloModel> = {
      model: c,
      metaData: { action: c ? 'update' : 'insert' }
    };
    this.modalService.open<ModuloModel>({
      modalName: 'modulo-form-page',
      title: (c ? 'Editar' : 'Nuevo') + ' Módulo',
      size: 'lg',
      data: payload
    });
  }
}
