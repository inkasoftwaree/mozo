export type ModalSize = 'xs' | 'sm' | 'md' | 'lg' | 'xl' | 'xl2' | 'xl3' | 'xl4' | 'xl5' | 'xl6' | 'xl7' | 'full';

export type ModalMetaData = {
  action?: 'update' | 'insert' | 'view';
  [key: string]: unknown;
};

/**
 * Payload genérico para cualquier modal.
 * T = entidad principal.
 */
export interface ModalPayload<T = unknown> {
  model: T | null;
  relations?: Record<string, unknown>;
  metaData?: ModalMetaData;
}

export interface ModalControlModel<T = unknown> {
  modalName: string;
  title: string;
  size?: ModalSize;
  /** Si es true, cierra al hacer clic fuera del contenido. Por defecto false (formularios). */
  closeOnBackdropClick?: boolean;
  data: ModalPayload<T>;
}

