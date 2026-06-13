import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { NgIcon, provideIcons } from '@ng-icons/core';
import { lucideSquare, lucideSquareCheck } from '@ng-icons/lucide';

@Component({
  selector: 'mz-state-control',
  standalone: true,
  templateUrl: './state.control.html',
  providers: [provideIcons({ lucideSquareCheck, lucideSquare })],
  imports: [NgIcon],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class StateControl {
  state = input<number | null>(null);
}
