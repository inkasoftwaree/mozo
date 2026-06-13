import { Injectable, signal } from '@angular/core';
import { ModalControlModel } from '@shared/models/controls/modal-control.model';

@Injectable({ providedIn: 'root' })
export class ModalService {

  readonly state = signal<ModalControlModel | null>(null);

  open<T = unknown>(config: ModalControlModel<T>): void {
    this.state.set(config as ModalControlModel);
  }

  close(): void {
    this.state.set(null);
  }
}
