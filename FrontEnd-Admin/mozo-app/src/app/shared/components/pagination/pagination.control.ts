import { ChangeDetectionStrategy, Component, computed, input, output } from '@angular/core';

@Component({
  selector: 'mz-pagination-control',
  standalone: true,
  imports: [],
  templateUrl: './pagination.control.html',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class PaginationControl {

  page = input(1);
  totalPages = input(1);

  change = output<number>();

  readonly pages = computed(() => {
    const total = this.totalPages();
    const current = this.page();
    const start = Math.max(1, current - 2);
    const end = Math.min(total, current + 2);
    return Array.from({ length: end - start + 1 }, (_, i) => start + i);
  });

  goTo(p: number): void {
    if (p < 1 || p > this.totalPages()) return;
    this.change.emit(p);
  }

  prev(): void { this.goTo(this.page() - 1); }
  next(): void { this.goTo(this.page() + 1); }
}
