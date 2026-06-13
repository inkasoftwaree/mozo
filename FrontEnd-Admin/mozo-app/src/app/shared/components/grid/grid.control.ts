import { ChangeDetectionStrategy, Component, TemplateRef, computed, contentChild, input } from '@angular/core';
import { NgTemplateOutlet } from '@angular/common';

@Component({
  selector: 'mz-generic-grid',
  standalone: true,
  imports: [NgTemplateOutlet],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
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
  `,
  styles: [`:host { display: block; width: 100%; }`]
})
export class GenericGridCControl<T> {
  items         = input<T[]>([]);
  columnas      = input<number>(3);
  mostrarBordes = input<boolean>(true);
  espaciado     = input<2 | 4 | 6 | 8>(4);
  bordeGrosor   = input<1 | 2 | 4>(2);
  bordeColor    = input<string>('border-base-300');
  redondeado    = input<'sm' | 'md' | 'lg' | 'xl' | '2xl'>('lg');
  sombra        = input<boolean>(true);
  hover         = input<boolean>(true);
  bgColor       = input<string>('bg-base-100');

  readonly itemTemplate = contentChild<TemplateRef<{ $implicit: T; index: number }>>('itemTemplate');

  protected readonly gridClasses = computed(() => {
    const colsMap: Record<number, string> = {
      1: 'lg:grid-cols-1', 2: 'lg:grid-cols-2', 3: 'lg:grid-cols-3',
      4: 'lg:grid-cols-4', 5: 'lg:grid-cols-5', 6: 'lg:grid-cols-6',
    };
    const gapMap: Record<number, string> = {
      2: 'gap-2', 4: 'gap-4', 6: 'gap-6', 8: 'gap-8',
    };
    return `grid grid-cols-1 ${colsMap[this.columnas()]} ${gapMap[this.espaciado()]}`;
  });

  protected readonly itemClasses = computed(() => {
    const classes = [this.bgColor()];
    if (this.mostrarBordes()) {
      const bordeMap: Record<number, string> = { 1: 'border', 2: 'border-2', 4: 'border-4' };
      classes.push(bordeMap[this.bordeGrosor()], this.bordeColor());
    }
    classes.push(`rounded-${this.redondeado()}`);
    if (this.sombra()) classes.push('shadow-lg');
    if (this.hover()) classes.push('hover:shadow-2xl hover:scale-102 transition-all duration-200');
    return classes.join(' ');
  });
}
