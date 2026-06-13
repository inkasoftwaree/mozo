import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '@app/core/services/auth.service';

@Component({
  selector: 'mz-logout-page',
  standalone: true,
  imports: [],
  templateUrl: './logout.page.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class LogoutPage {
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  constructor() {
    this.auth.clearSession();
  }

  goToHome(): void {
    this.router.navigate(['/home']);
  }
}
