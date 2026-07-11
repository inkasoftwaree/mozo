import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { cleanParams } from '@app/core/global/params.helper';
import { UrlApiService } from '@app/core/services/url-api.service';
import { API_ROUTES } from '@app/core/global/constants';
import { PersonaRedSocialModel } from '@app/shared/models/maestro/persona-red-social.model';


@Injectable({
  providedIn: 'root'
})
export class PersonaRedSocialService {
  private http = inject(HttpClient);
  private api = inject(UrlApiService);
  private baseUrl = this.api.buildUrl(API_ROUTES.maestro.personaRedSocial);

  selAll(c: PersonaRedSocialModel): Observable<PersonaRedSocialModel[]> {
    return this.http.get<PersonaRedSocialModel[]>(`${this.baseUrl}/all`, { params: cleanParams(c) });
  }

  selById(c: PersonaRedSocialModel): Observable<PersonaRedSocialModel> {
    return this.http.get<PersonaRedSocialModel>(`${this.baseUrl}`, { params: cleanParams(c) });
  }

  insert(c: PersonaRedSocialModel): Observable<number> {
    return this.http.post<number>(this.baseUrl, c);
  }

  update(c: PersonaRedSocialModel): Observable<number> {
    return this.http.put<number>(this.baseUrl, c);
  }

  deleteById(c: PersonaRedSocialModel): Observable<void> {
    return this.http.delete<void>(this.baseUrl, { params: cleanParams(c) });
  }

}
