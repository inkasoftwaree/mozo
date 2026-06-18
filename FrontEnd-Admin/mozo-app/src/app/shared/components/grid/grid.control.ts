import { ChangeDetectionStrategy, Component, TemplateRef, computed, contentChild, input } from '@angular/core';
import { NgTemplateOutlet } from '@angular/common';

@Component({
  selector: 'mz-generic-grid',
  standalone: true,
  imports: [NgTemplateOutlet],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    @if (loading()) {

      <!-- Skeleton de carga -->
      <div [class]="gridClasses()">
        @for (sk of skeletonItems(); track $index) {
          <div [class]="skeletonItemClasses()">
            <div class="p-4 space-y-3 animate-pulse">
              <div class="flex items-center gap-2">
                <div class="h-4 rounded bg-base-300 w-16"></div>
                <div class="h-4 rounded bg-base-300 w-28"></div>
              </div>
              <div class="h-3 rounded bg-base-300 w-full"></div>
              <div class="h-3 rounded bg-base-300 w-4/5"></div>
              <div class="h-px bg-base-300 w-full my-2"></div>
              <div class="flex justify-between">
                <div class="h-3 rounded bg-base-300 w-1/3"></div>
                <div class="h-3 rounded bg-base-300 w-1/4"></div>
              </div>
            </div>
          </div>
        }
      </div>

    } @else if (items().length === 0) {

      <!-- Estado vacío -->
      <div class="flex flex-col items-center justify-center py-16 text-center gap-3">
        <div class="w-14 h-14 rounded-full bg-base-200 flex items-center justify-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-base-content/30"
               fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2
                     M9 5a2 2 0 002 2h2a2 2 0 002-2
                     M9 5a2 2 0 012-2h2a2 2 0 012 2" />
          </svg>
        </div>
        <p class="text-sm font-medium text-base-content/50">{{ emptyMessage() }}</p>
      </div>

    } @else {

      <!-- Grid con datos -->
      <div [class]="gridClasses()">
        @for (item of items(); track $index) {
          <div [class]="itemClasses()">
            <ng-container
              [ngTemplateOutlet]="itemTemplate() ?? null"
              [ngTemplateOutletContext]="{ $implicit: item, index: $index }">
            </ng-container>
          </div>
        }
      </div>

    }
  `,
  styles: [`:host { display: block; width: 100%; }`]
})
export class GenericGridCControl<T> {

  // ── Datos ─────────────────────────────────────────────────────────────────
  items         = input<T[]>([]);

  // ── Layout ────────────────────────────────────────────────────────────────
  /** Columnas en desktop. Mobile/tablet se calculan automáticamente. */
  columnas      = input<1 | 2 | 3 | 4 | 5 | 6>(3);
  espaciado     = input<2 | 3 | 4 | 6 | 8>(4);

  // ── Estilo de cards ───────────────────────────────────────────────────────
  mostrarBordes = input<boolean>(true);
  bordeGrosor   = input<1 | 2>(1);
  bordeColor    = input<string>('border-base-200');
  redondeado    = input<'sm' | 'md' | 'lg' | 'xl' | '2xl'>('xl');
  sombra        = input<boolean>(true);
  hover         = input<boolean>(true);
  bgColor       = input<string>('bg-base-100');

  // ── Estado de carga ───────────────────────────────────────────────────────
  loading       = input<boolean>(false);
  /** Cantidad de tarjetas skeleton a mostrar durante la carga. */
  skeletonCount = input<number>(6);

  // ── Estado vacío ──────────────────────────────────────────────────────────
  emptyMessage  = input<string>('No hay registros para mostrar');

  readonly itemTemplate = contentChild<TemplateRef<{ $implicit: T; index: number }>>('itemTemplate');

  protected readonly skeletonItems = computed(() => Array(this.skeletonCount()).fill(null));

  // ── Clases del grid ───────────────────────────────────────────────────────
  protected readonly gridClasses = computed(() => {
    // Progresión responsive automática según columnas en desktop
    const responsiveMap: Record<number, string> = {
      1: 'grid-cols-1',
      2: 'grid-cols-1 sm:grid-cols-2',
      3: 'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3',
      4: 'grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4',
      5: 'grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-5',
      6: 'grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6',
    };
    const gapMap: Record<number, string> = {
      2: 'gap-2', 3: 'gap-3', 4: 'gap-4', 6: 'gap-6', 8: 'gap-8',
    };
    return `grid ${responsiveMap[this.columnas()] ?? responsiveMap[3]} ${gapMap[this.espaciado()]}`;
  });

  // ── Clases de cada card ───────────────────────────────────────────────────
  protected readonly itemClasses = computed(() => {
    const classes: string[] = [this.bgColor()];

    if (this.mostrarBordes()) {
      const bordeMap: Record<number, string> = { 1: 'border', 2: 'border-2' };
      classes.push(bordeMap[this.bordeGrosor()], this.bordeColor());
    }

    classes.push(`rounded-${this.redondeado()}`);

    if (this.sombra()) {
      classes.push('shadow-sm');
    }

    if (this.hover()) {
      classes.push(
        'hover:shadow-md',
        'hover:border-primary/30',
        'hover:scale-[1.01]',
        'transition-all',
        'duration-200',
        'cursor-default'
      );
    }

    return classes.join(' ');
  });

  // Skeleton usa las mismas clases de card pero sin hover
  protected readonly skeletonItemClasses = computed(() => {
    const classes: string[] = [this.bgColor()];
    if (this.mostrarBordes()) {
      const bordeMap: Record<number, string> = { 1: 'border', 2: 'border-2' };
      classes.push(bordeMap[this.bordeGrosor()], this.bordeColor());
    }
    classes.push(`rounded-${this.redondeado()}`);
    return classes.join(' ');
  });
}
