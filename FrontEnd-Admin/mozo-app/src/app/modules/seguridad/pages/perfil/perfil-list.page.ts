import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
import { rxResource, toSignal } from '@angular/core/rxjs-interop';
import { of } from 'rxjs';
import { ButtonControl } from "@app/shared/components/button/button.control";
import { FormFieldControl } from "@app/shared/components/form-field/form-field.control";
import { ModuloService } from '@moduleSeguridad/services/modulo.service';
import { MSG_FIELD_FORM } from '@app/core/global/constants';
import { ModalControl } from "@app/shared/components/modal/modal.control";
import { PerfilFormPage } from "./perfil-form.page";
import { StateControl } from "@app/shared/components/state/state.control";
import { MenuControl } from "@app/shared/components/menu/menu.control";
import { PerfilService } from '@moduleSeguridad/services/perfil.service';
import { ModalService } from '@app/shared/services/modal.service';
import { PerfilModel } from '@app/shared/models/seguridad/perfil.model';
import { MenuControlModel } from '@app/shared/models/controls/menu-control.model';
import { FormsModule } from '@angular/forms';
import { DefaultControl } from "@app/shared/components/state/default.control";
import { ModuloModel } from '@app/shared/models/seguridad/modulo.model';
import { ModalPayload } from '@app/shared/models/controls/modal-control.model';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { PerfilPaginaFormPage } from "../perfil-pagina/perfil-pagina-form.page";
import { CrudListPageBase } from '@app/shared/components/list/crud-list-page-base';
import { GenericGridCControl } from "@app/shared/components/grid/grid.control";

@Component({
  selector: 'mz-perfil-list-page',
  standalone: true,
  imports: [FormsModule, ButtonControl, FormFieldControl, ModalControl, PerfilFormPage, StateControl, MenuControl, PerfilPaginaFormPage, GenericGridCControl],
  templateUrl: './perfil-list.page.html',
  styleUrl: './perfil-list.page.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PerfilListPage extends CrudListPageBase<PerfilModel> {
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;
  protected readonly MSG_FIELD_FORM = MSG_FIELD_FORM;

  private readonly moduloService = inject(ModuloService);
  private readonly modalService = inject(ModalService);

  protected override readonly crudService = inject(PerfilService);

  readonly modulos = toSignal(this.moduloService.selAllActive(), { initialValue: [] });
  readonly selectedModulo = signal<number | null>(null);

  private readonly perfilesResource = rxResource({
    defaultValue: [] as PerfilModel[],
    params: () => this.selectedModulo(),
    stream: ({ params: coModulo }) =>
      coModulo !== null
        ? this.crudService.selAll({ coModulo } as PerfilModel)
        : of([])
  });

  protected override readonly listResource = this.perfilesResource;
  protected override readonly entityLabel = 'Perfil';

  readonly perfiles = computed(() => this.perfilesResource.value() ?? []);
  readonly isLoading = computed(() => this.perfilesResource.isLoading());

  onModuloChange(coModulo: number): void {
    this.selectedModulo.set(coModulo);
  }

  readonly menuItems: MenuControlModel[] = [
    { type: MenuControlTypeEnum.Edit, action: 'edit' },
    { type: MenuControlTypeEnum.Delete, action: 'deleteById' },
    { type: MenuControlTypeEnum.State, action: 'updateState' },
    {
      type: MenuControlTypeEnum.ToggleOn,
      action: 'updatePerfilPagina',
      label: 'Asignar Menus y sub Menus'
    }
  ];

  override onMenuAction(action: string, c: PerfilModel | null): void {
    if (action === 'updatePerfilPagina') {
      this.openModalPerfilPagina(c!);
      return;
    }
    super.onMenuAction(action, c);
  }

  protected override matchesId(a: PerfilModel, b: PerfilModel): boolean {
    return a.coPerfil === b.coPerfil;
  }

  protected override getDeleteDescription(c: PerfilModel): string {
    return `Se eliminará ${c.noPerfil}`;
  }

  protected override async openModal(c: PerfilModel | null): Promise<void> {
    if (this.selectedModulo() === null) {
      await this.confirmService.error('Crear perfil', 'Falta seleccionar el Módulo');
      return;
    }
    const modulo: ModuloModel = this.modulos().find(m => m.coModulo === this.selectedModulo())!;
    const payload: ModalPayload<PerfilModel> = {
      model: c,
      relations: { modulo },
      metaData: { action: c ? 'update' : 'insert' }
    };
    this.modalService.open<PerfilModel>({
      modalName: 'perfil-form-page-modal',
      title: (c ? 'Editar' : 'Nuevo') + ' Perfil',
      size: 'sm',
      data: payload
    });
  }

  private openModalPerfilPagina(c: PerfilModel): void {
    const modulo = this.modulos().find(m => m.coModulo === this.selectedModulo())!;
    const payload: ModalPayload<PerfilModel> = {
      model: c,
      relations: { modulo }
    };
    this.modalService.open<PerfilModel>({
      modalName: 'perfil-pagina-form-page-modal',
      title: 'Actualizar Menus y sub Menus',
      size: 'lg',
      data: payload
    });
  }
}
