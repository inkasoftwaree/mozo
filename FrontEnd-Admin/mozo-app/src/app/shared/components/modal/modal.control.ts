import { ChangeDetectionStrategy, Component, computed, inject, input } from '@angular/core';
import { ModalControlModel, ModalPayload, ModalSize } from '@app/shared/models/controls/modal-control.model';
import { ModalService } from '@app/shared/services/modal.service';

const MODAL_SIZES: Record<ModalSize, string> = {
  xs: 'max-w-xs', sm: 'max-w-sm', md: 'max-w-md', lg: 'max-w-lg', xl: 'max-w-xl',
  xl2: 'max-w-2xl', xl3: 'max-w-3xl', xl4: 'max-w-4xl', xl5: 'max-w-5xl',
  xl6: 'max-w-6xl', xl7: 'max-w-7xl', full: 'max-w-full'
};

@Component({
  selector: 'mz-modal-control',
  standalone: true,
  imports: [],
  templateUrl: './modal.control.html',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class ModalControl<T = any> {
  name = input.required<string>();

  private readonly modalService = inject(ModalService);

  private readonly activeModal = computed<ModalControlModel | null>(() => {
    const modal = this.modalService.state();
    return modal?.modalName === this.name() ? modal : null;
  });

  protected readonly isOpen = computed(() => this.activeModal() !== null);
  protected readonly title$ = computed(() => this.activeModal()?.title ?? 'Ventana');
  protected readonly modalWidthClass = computed(() =>
    MODAL_SIZES[(this.activeModal()?.size ?? 'md') as ModalSize]
  );
  protected readonly closeOnBackdropClick = computed(
    () => this.activeModal()?.closeOnBackdropClick === true
  );

  public readonly data$ = computed<ModalPayload<T> | null>(() =>
    (this.activeModal()?.data as ModalPayload<T>) ?? null
  );

  close(): void {
    this.modalService.close();
  }

  onBackdropClick(): void {
    if (this.closeOnBackdropClick()) {
      this.close();
    }
  }
}
