import { ChangeDetectionStrategy, Component, DestroyRef, computed, effect, inject, input, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { takeUntilDestroyed, toSignal } from '@angular/core/rxjs-interop';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { PersonaRedSocialService } from '@app/modules/maestro/services/persona-red-social.service';
import { PersonaRedSocialModel } from '@app/shared/models/maestro/persona-red-social.model';
import { PersonaModel } from '@app/shared/models/maestro/persona.model';
import { ConfirmService } from '@app/shared/services/confirm.service';
import { ToastrService } from 'ngx-toastr';
import { ButtonControl } from "@app/shared/components/button/button.control";
import { TipoGeneralService } from '@moduleMaestro/services/tipo-general.service';
import { TIPO_MAESTRO } from '@app/core/global/tipo.constants';
import { FormFieldControl } from "@app/shared/components/form-field/form-field.control";
import { NgIconComponent } from '@ng-icons/core';

type PersonaRedSocialRow = PersonaRedSocialModel & { _tempId?: number };
type Seccion = { coTipo: number; noTipo: string };
type RowField = 'noRedSocial';
type RowFieldErrors = Partial<Record<RowField, string>>;
@Component({
  selector: 'mz-red-social-form-page',
  standalone: true,
  imports: [FormsModule, ButtonControl, FormFieldControl, NgIconComponent],
  templateUrl: './persona-red-social-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PersonaRedSocialFormPage {

  private readonly personaRedSocialService = inject(PersonaRedSocialService);
  private readonly tipoGeneralService = inject(TipoGeneralService);
  private readonly confirmService = inject(ConfirmService);
  private readonly toastr = inject(ToastrService);
  private readonly destroyRef = inject(DestroyRef);

  protected readonly TIPO_MAESTRO = TIPO_MAESTRO;
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  readonly data = input<PersonaModel | null>(null);


  readonly items = signal<PersonaRedSocialRow[]>([]);
  readonly editandoId = signal<number | null>(null);
  private readonly rowFieldErrors = signal<Map<number, RowFieldErrors>>(new Map());
  readonly etiquetas = toSignal(
    this.tipoGeneralService.selAllActive({ coGrupo: TIPO_MAESTRO.general.etiquetaRedSocial.grupo }),
    { initialValue: [] }
  );
  readonly tiposUrl = toSignal(
    this.tipoGeneralService.selAllActive({ coGrupo: TIPO_MAESTRO.general.urlRedSocial.grupo }),
    { initialValue: [] }
  );

  // Agrupa items por coTipoRedSocial una sola vez cuando items() cambia
  readonly itemsPorTipo = computed(() => {
    const map = new Map<number, PersonaRedSocialRow[]>();
    for (const item of this.items()) {
      const coTipo = item.coTipoRedSocial ?? 0;
      const list = map.get(coTipo) ?? [];
      list.push(item);
      map.set(coTipo, list);
    }
    return map;
  });

  readonly secciones: Seccion[] = [
    { coTipo: TIPO_MAESTRO.general.personaRedSocial.items.telefonoMovil, noTipo: 'Teléfono móvil' },
    { coTipo: TIPO_MAESTRO.general.personaRedSocial.items.telefonoFijo, noTipo: 'Teléfono fijo' },
    { coTipo: TIPO_MAESTRO.general.personaRedSocial.items.correoElectronico, noTipo: 'Correo electrónico' },
    { coTipo: TIPO_MAESTRO.general.personaRedSocial.items.redSocial, noTipo: 'Redes sociales' },
  ];

  private tempIdCounter = -1;

  constructor() {
    effect(() => {
      const entidad = this.data();
      this.items.set([]);
      this.editandoId.set(null);
      this.rowFieldErrors.set(new Map());
      if (!entidad) return;
      this.selAll();
    });  }

  isEditando(item: PersonaRedSocialRow): boolean {
    const id = this.editandoId();
    return id !== null && (id === item.coPersonaRedSocial || id === item._tempId);
  }

  getRowError(item: PersonaRedSocialRow, field: RowField): string | null {
    return this.rowFieldErrors().get(this.rowKey(item))?.[field] ?? null;
  }

  hasRowErrors(item: PersonaRedSocialRow): boolean {
    const errors = this.rowFieldErrors().get(this.rowKey(item));
    return !!errors && Object.keys(errors).length > 0;
  }

  clearRowError(item: PersonaRedSocialRow, field: RowField): void {
    const key = this.rowKey(item);
    const current = this.rowFieldErrors().get(key);
    if (!current?.[field]) return;

    const nextErrors = { ...current };
    delete nextErrors[field];
    this.setRowErrors(item, nextErrors);
  }
  private selAll(): void {  
    const persona = this.data();
    const personaRedSocial: PersonaRedSocialModel = {  coPersona: persona!.coPersona};
      //? { flPersona: 0, coEmpresa: empresa.coEmpresa, flEmpresaNotKey: 1 }
      //: { flPersona: 1, coPersona: persona!.coPersona, coEmpresa: persona!.coEmpresa, flEmpresaNotKey: 0 };

    this.personaRedSocialService.selAll(personaRedSocial)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(r => this.items.set(r));
  }

  agregarFila(coTipo: number): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();

    const tempId = this.tempIdCounter--;    
    const persona = this.data();

    const nueva: PersonaRedSocialRow = {
      _tempId: tempId,
      coTipoRedSocial: coTipo,      
      coPersona: persona?.coPersona,      
      flEmpresaNotKey: 0,
      noRedSocial: '',
      flWhatsapp: 0,
    };

    this.items.update(list => [...list, nueva]);
    this.editandoId.set(tempId);
  }

  editarFila(item: PersonaRedSocialRow): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();
    this.clearRowErrors(item);
    this.editandoId.set(item.coPersonaRedSocial ?? item._tempId!);
  }

  guardarFila(item: PersonaRedSocialRow): void {
    const current = this.findRow(item);
    if (!current) return;

    const errors = this.validateRow(current);
    if (Object.keys(errors).length > 0) {
      this.setRowErrors(current, errors);
      return;
    }
    this.clearRowErrors(current);

    const esNuevo = !current.coPersonaRedSocial;
    const request$ = esNuevo
      ? this.personaRedSocialService.insert(current)
      : this.personaRedSocialService.update(current);

    request$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (id) => {
          if (esNuevo) {
            this.items.update(list =>
              list.map(x => x._tempId === current._tempId
                ? { ...x, coRedSocial: id, _tempId: undefined }
                : x
              )
            );
          }
          this.editandoId.set(null);
          this.clearRowErrors(current);
          this.toastr.success('Guardado correctamente', 'Éxito');
        },
        error: () => this.toastr.error('Error al guardar', 'Error'),
      });
  }

  cancelarEdicion(item: PersonaRedSocialRow): void {
    if (!item.coPersonaRedSocial) {
      this.items.update(list => list.filter(x => x._tempId !== item._tempId));
    }
    this.clearRowErrors(item);
    this.editandoId.set(null);
  }
  async eliminarFila(item: PersonaRedSocialRow): Promise<void> {
    const ok = await this.confirmService.confirm('¿Eliminar registro?', '', 'Sí, eliminar');
    if (!ok) return;

    if (!item.coPersonaRedSocial) {
      this.items.update(list => list.filter(x => x._tempId !== item._tempId));
      return;
    }

    this.personaRedSocialService.deleteById(item)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.items.update(list => list.filter((x: PersonaRedSocialModel) => x.coPersonaRedSocial !== item.coPersonaRedSocial));
          this.toastr.success('Eliminado correctamente', 'Éxito');
        },
        error: () => this.toastr.error('Error al eliminar', 'Error'),
      });
  }

  private cancelarEdicionActual(): void {
    const editingId = this.editandoId();
    if (editingId != null) {
      const editing = this.items().find(
        (x) => x.coPersonaRedSocial === editingId || x._tempId === editingId
      );
      if (editing) this.clearRowErrors(editing);
    }
    this.items.update(list => list.filter((x: PersonaRedSocialModel) => x.coPersonaRedSocial != null));
    this.editandoId.set(null);
  }

  private findRow(item: PersonaRedSocialRow): PersonaRedSocialRow | undefined {
    return this.items().find(
      (x) =>
        (item._tempId != null && x._tempId === item._tempId) ||
        (item.coPersonaRedSocial != null && x.coPersonaRedSocial === item.coPersonaRedSocial)
    );
  }

  private rowKey(item: PersonaRedSocialRow): number {
    return item.coPersonaRedSocial ?? item._tempId!;
  }

  private validateRow(item: PersonaRedSocialRow): RowFieldErrors {
    const errors: RowFieldErrors = {};
    if (!item.noRedSocial?.trim()) {
      errors.noRedSocial = 'El valor es obligatorio';
    }
    return errors;
  }

  private setRowErrors(item: PersonaRedSocialRow, errors: RowFieldErrors): void {
    const key = this.rowKey(item);
    this.rowFieldErrors.update((map) => {
      const next = new Map(map);
      if (Object.keys(errors).length === 0) next.delete(key);
      else next.set(key, errors);
      return next;
    });
  }

  private clearRowErrors(item: PersonaRedSocialRow): void {
    this.setRowErrors(item, {});
  }

}
