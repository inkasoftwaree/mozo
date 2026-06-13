import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'mz-forbidden-page',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './forbidden.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ForbiddenPage {}
