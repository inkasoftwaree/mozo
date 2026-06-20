import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, Observable } from 'rxjs';
import { cleanParams } from '@app/core/global/params.helper';
import { UrlApiService } from '@app/core/services/url-api.service';
import { API_ROUTES } from '@app/core/global/constants';
import { TipoParticularModel } from '@app/shared/models/maestro/tipo-particular.model';
import { PagedResult } from '@app/shared/models/base.model';


@Injectable({
  providedIn: 'root'
})
export class TipoParticularService {
  private http = inject(HttpClient);
  private api = inject(UrlApiService);
  private baseUrl = this.api.buildUrl(API_ROUTES.maestro.tipoParticular);

  insert(c: TipoParticularModel): Observable<number> {
    return this.http.post<number>(this.baseUrl, c);
  }

  update(c: TipoParticularModel): Observable<number> {
    return this.http.put<number>(this.baseUrl, c);
  }

  updateState(c: TipoParticularModel): Observable<number> {
    return this.http.patch<number>(`${this.baseUrl}/state`, c);
  }

  updateCommand(c: TipoParticularModel): Observable<number> {
    return this.http.patch<number>(`${this.baseUrl}/command`, c);
  }

  updateDefault(c: TipoParticularModel): Observable<number> {
    return this.http.patch<number>(`${this.baseUrl}/default`, c);
  }

  deleteById(c: TipoParticularModel): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}`, { params: cleanParams(c) });
  }

  selById(c: TipoParticularModel): Observable<TipoParticularModel> {
    return this.http.get<TipoParticularModel>(`${this.baseUrl}`, { params: cleanParams(c) });
  }

  selAll(c: TipoParticularModel): Observable<PagedResult<TipoParticularModel>> {
    return this.http.get<TipoParticularModel[]>(`${this.baseUrl}/all`, { params: cleanParams(c) })
      .pipe(
        map(r => {
          return {
            rowsCount: r[0]?.rowsCount ?? 0,
            data: r
          } as PagedResult<TipoParticularModel>;
        })
      );
  }


  selAllChildren(c: TipoParticularModel): Observable<PagedResult<TipoParticularModel>> {
    return this.http.get<TipoParticularModel[]>(`${this.baseUrl}/children`, { params: cleanParams(c) })
      .pipe(
        map(r => {
          return {
            rowsCount: r[0]?.rowsCount ?? 0,
            data: r
          } as PagedResult<TipoParticularModel>;
        })
      );
  }


  selAllPatherAndChildren(c: TipoParticularModel): Observable<PagedResult<TipoParticularModel>> {
    return this.http.get<TipoParticularModel[]>(`${this.baseUrl}/father-children/active`, { params: cleanParams(c) })
      .pipe(
        map(r => {
          return {
            rowsCount: r[0]?.rowsCount ?? 0,
            data: r
          } as PagedResult<TipoParticularModel>;
        })
      );
  }


  selAllGroupsByModule(c: TipoParticularModel): Observable<TipoParticularModel[]> {
    return this.http.get<TipoParticularModel[]>(`${this.baseUrl}/modules/groups`, { params: cleanParams(c) });
  }

  selNextOrder(c: TipoParticularModel): Observable<TipoParticularModel> {
    return this.http.get<TipoParticularModel>(`${this.baseUrl}/next-order`, { params: cleanParams(c) });
  }

  selGroup(c: TipoParticularModel): Observable<TipoParticularModel> {
    return this.http.get<TipoParticularModel>(`${this.baseUrl}/group`, { params: cleanParams(c) });
  }

}
