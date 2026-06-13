import { Directive, DestroyRef, inject } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { Observable } from 'rxjs';
import { ToastrService } from 'ngx-toastr';
import { ConfirmService } from '@app/shared/services/confirm.service';
import { BaseModel } from '@app/shared/models/base.model';

/** Minimal service interface required by the base — any service with these two methods qualifies. */
export interface CrudListService<T> {
  updateState(entity: T): Observable<number>;
  deleteById(entity: T): Observable<void>;
}

/** Minimal resource interface — matches the shape returned by rxResource with defaultValue. */
export interface WritableListResource<T> {
  update(updater: (items: T[]) => T[]): void;
  reload(): void;
}

/**
 * Abstract base for list pages that follow the standard CRUD pattern:
 *   insert / edit → openModal()
 *   updateState   → toggle flEstReg, optimistic update
 *   deleteById    → confirm dialog, optimistic update
 *   onSaved       → reload resource
 *
 * Subclasses must provide:
 *  - crudService  : service with updateState() + deleteById()
 *  - listResource : rxResource result (must have update() + reload())
 *  - entityLabel  : display name used in toasts ("Módulo", "Perfil", …)
 *  - matchesId()  : entity identity comparison
 *  - openModal()  : opens the create/edit modal
 */
@Directive()
export abstract class CrudListPageBase<T extends BaseModel> {
  protected readonly toastr         = inject(ToastrService);
  protected readonly destroyRef     = inject(DestroyRef);
  protected readonly confirmService = inject(ConfirmService);

  protected abstract readonly crudService: CrudListService<T>;
  protected abstract readonly listResource: WritableListResource<T>;
  protected abstract readonly entityLabel: string;

  /** Return true when both entities represent the same row (compare by PK). */
  protected abstract matchesId(a: T, b: T): boolean;

  /** Open the create/edit modal. Subclasses implement with their specific modal name and payload.
   *  May be async when a guard check (e.g. confirmService.error) is needed first. */
  protected abstract openModal(entity: T | null): void | Promise<void>;

  /** Optional: override to customise the confirm-delete body text. */
  protected getDeleteDescription(_entity: T): string {
    return 'Se eliminará el registro';
  }

  /** Dispatches toolbar/context-menu actions to the appropriate method. */
  onMenuAction(action: string, entity: T | null): void {
    const map: Record<string, () => void> = {
      insert:      () => this.openModal(null),
      edit:        () => this.openModal(entity),
      updateState: () => this.updateState(entity!),
      deleteById:  () => this.deleteById(entity!),
    };
    map[action]?.();
  }

  protected updateState(entity: T): void {
    const flEstReg = entity.flEstReg === 1 ? 0 : 1;

    this.crudService
      .updateState({ ...entity, flEstReg })
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.listResource.update(items =>
            items.map(x => this.matchesId(x, entity) ? { ...x, flEstReg } : x)
          );
          this.toastr.success(`${this.entityLabel} actualizado`, 'Éxito');
        }
      });
  }

  protected async deleteById(entity: T): Promise<void> {
    const ok = await this.confirmService.confirm(
      `¿Eliminar ${this.entityLabel}?`,
      this.getDeleteDescription(entity),
      'Sí, eliminar'
    );
    if (!ok) return;

    this.crudService
      .deleteById(entity)
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: () => {
          this.listResource.update(items => items.filter(x => !this.matchesId(x, entity)));
          this.toastr.success(`${this.entityLabel} eliminado`, 'Éxito');
        }
      });
  }

  // _payload is ignored but must be declared to accept the optional template argument
  // (e.g. modulo-list calls onSaved(modal.data$()))
  onSaved(_payload?: unknown): void {
    this.listResource.reload();
  }
}
