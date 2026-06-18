import { ChangeDetectionStrategy, Component, DestroyRef, computed, effect, inject, input, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { takeUntilDestroyed, toSignal } from '@angular/core/rxjs-interop';
import { MenuControlTypeEnum } from '@app/shared/enum/menu-control-type.enum';
import { RedSocialService } from '@moduleMaestro/services/red-social.service';
import { RedSocialModel } from '@app/shared/models/maestro/red-social.model';
import { PersonaModel } from '@app/shared/models/maestro/persona.model';
import { ConfirmService } from '@app/shared/services/confirm.service';
import { ToastrService } from 'ngx-toastr';
import { ButtonControl } from "@app/shared/components/button/button.control";
import { TipoGeneralService } from '@moduleMaestro/services/tipo-general.service';
import { TIPO_MAESTRO } from '@app/core/global/tipo.constants';
import { EmpresaModel } from '@app/shared/models/seguridad/empresa.model';

type RedSocialRow = RedSocialModel & { _tempId?: number };
type Seccion = { coTipo: number; noTipo: string };

@Component({
  selector: 'mz-red-social-form-page',
  standalone: true,
  imports: [FormsModule, ButtonControl],
  templateUrl: './red-social-form.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class RedSocialFormPage {

  private readonly redSocialService = inject(RedSocialService);
  private readonly tipoGeneralService = inject(TipoGeneralService);
  private readonly confirmService = inject(ConfirmService);
  private readonly toastr = inject(ToastrService);
  private readonly destroyRef = inject(DestroyRef);

  protected readonly TIPO_MAESTRO = TIPO_MAESTRO;
  protected readonly MenuControlTypeEnum = MenuControlTypeEnum;

  readonly data = input<EmpresaModel | PersonaModel | null>(null);

  // Derivados reactivamente del input — eliminan writable signals y sets manuales en el effect
  readonly empresa = computed<EmpresaModel | null>(() => {
    const e = this.data();
    return e && this.isEmpresa(e) ? e : null;
  });
  readonly persona = computed<PersonaModel | null>(() => {
    const e = this.data();
    return e && this.isPersona(e) ? e : null;
  });

  readonly items = signal<RedSocialRow[]>([]);
  readonly editandoId = signal<number | null>(null);

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
    const map = new Map<number, RedSocialRow[]>();
    for (const item of this.items()) {
      const coTipo = item.coTipoRedSocial ?? 0;
      const list = map.get(coTipo) ?? [];
      list.push(item);
      map.set(coTipo, list);
    }
    return map;
  });

  readonly secciones: Seccion[] = [
    { coTipo: TIPO_MAESTRO.general.redSocial.items.telefonoMovil, noTipo: 'Teléfono móvil' },
    { coTipo: TIPO_MAESTRO.general.redSocial.items.telefonoFijo, noTipo: 'Teléfono fijo' },
    { coTipo: TIPO_MAESTRO.general.redSocial.items.correoElectronico, noTipo: 'Correo electrónico' },
    { coTipo: TIPO_MAESTRO.general.redSocial.items.redSocial, noTipo: 'Redes sociales' },
  ];

  private tempIdCounter = -1;

  constructor() {
    effect(() => {
      const entidad = this.data();
      this.items.set([]);
      this.editandoId.set(null);
      if (!entidad) return;
      this.selAll();
    });
  }

  isEditando(item: RedSocialRow): boolean {
    const id = this.editandoId();
    return id !== null && (id === item.coRedSocial || id === item._tempId);
  }

  private selAll(): void {
    const empresa = this.empresa();
    const persona = this.persona();

    const redSocial: RedSocialModel = empresa
      ? { flPersona: 0, coEmpresa: empresa.coEmpresa, flEmpresaNotKey: 1 }
      : { flPersona: 1, coPersona: persona!.coPersona, coEmpresa: persona!.coEmpresa, flEmpresaNotKey: 0 };

    this.redSocialService.selAll(redSocial)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(r => this.items.set(r));
  }

  agregarFila(coTipo: number): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();

    const tempId = this.tempIdCounter--;
    const empresa = this.empresa();
    const persona = this.persona();

    const nueva: RedSocialRow = {
      _tempId: tempId,
      coTipoRedSocial: coTipo,
      coEmpresa: empresa?.coEmpresa,
      coPersona: persona?.coPersona,
      flPersona: persona ? 1 : 0,
      flEmpresaNotKey: empresa ? 1 : 0,
      noRedSocial: '',
      flWhatsapp: 0,
    };

    this.items.update(list => [...list, nueva]);
    this.editandoId.set(tempId);
  }

  editarFila(item: RedSocialRow): void {
    if (this.editandoId() !== null) this.cancelarEdicionActual();
    this.editandoId.set(item.coRedSocial ?? item._tempId!);
  }

  guardarFila(item: RedSocialRow): void {
    if (!item.noRedSocial?.trim()) {
      this.toastr.warning('El valor es obligatorio', 'Atención');
      return;
    }

    const esNuevo = !item.coRedSocial;
    const request$ = esNuevo
      ? this.redSocialService.insert(item)
      : this.redSocialService.update(item);

    request$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (id) => {
          if (esNuevo) {
            this.items.update(list =>
              list.map(x => x._tempId === item._tempId
                ? { ...x, coRedSocial: id, _tempId: undefined }
                : x
              )
            );
          }
          this.editandoId.set(null);
          this.toastr.success('Guardado correctamente', 'Éxito');
        },
        error: () => this.toastr.error('Error al guardar', 'Error'),
      });
  }

  cancelarEdicion(item: RedSocialRow): void {
    if (!item.coRedSocial) {
      this.items.update(list => list.filter(x => x._tempId !== item._tempId));
    }
    this.editandoId.set(null);
  }

  async eliminarFila(item: RedSocialRow): Promise<void> {
    const ok = await this.confirmService.confirm('¿Eliminar registro?', '', 'Sí, eliminar');
    if (!ok) return;

    if (!item.coRedSocial) {
      this.items.update(list => list.filter(x => x._tempId !== item._tempId));
      return;
    }

    this.redSocialService.deleteById(item)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.items.update(list => list.filter(x => x.coRedSocial !== item.coRedSocial));
          this.toastr.success('Eliminado correctamente', 'Éxito');
        },
        error: () => this.toastr.error('Error al eliminar', 'Error'),
      });
  }

  private cancelarEdicionActual(): void {
    this.items.update(list => list.filter(x => x.coRedSocial != null));
    this.editandoId.set(null);
  }

  private isEmpresa(e: EmpresaModel | PersonaModel): e is EmpresaModel {
    return e.coEmpresa != null && (e as PersonaModel).coPersona == null;
  }

  private isPersona(e: EmpresaModel | PersonaModel): e is PersonaModel {
    return e.coEmpresa != null && (e as PersonaModel).coPersona != null;
  }
}
