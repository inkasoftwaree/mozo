import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { NgIcon } from '@ng-icons/core';
import { AuthService } from '@app/core/services/auth.service';

@Component({
  selector: 'mz-home-page',
  standalone: true,
  imports: [NgIcon],
  templateUrl: './home.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class HomePage {
  readonly user = inject(AuthService).user;
}
