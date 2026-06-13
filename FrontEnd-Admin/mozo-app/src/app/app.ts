import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { MainComponent } from './layout/main/main.component';
import { LoadingService } from './core/services/loading.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [MainComponent],
  templateUrl: './app.html',
  styleUrl: './app.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class App {
  protected readonly loadingService = inject(LoadingService);
}
