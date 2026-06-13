import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { NgIcon, provideIcons } from '@ng-icons/core';
import { lucideCheckLine } from '@ng-icons/lucide';

@Component({
  selector: 'mz-default-control',
  standalone: true,
  templateUrl: './default.control.html',
  providers: [provideIcons({ lucideCheckLine })],
  imports: [NgIcon],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class DefaultControl {
  default = input<number | null>(null);
}
