import { BaseModel } from "@sharedModels/base.model";

export interface PersonaRedSocialModel extends BaseModel {
  coPersona?: number;
  coPersonaRedSocial?: number;
  coEtiqueta?: number;
  coTipoUrl?: number;
  coTipoRedSocial?: number;
  noRedSocial?: string;  
  flWhatsapp?: number;  

  noIconoTipoUrl?: string;
  noEtiqueta?: string;
  noTipoRedSocial?: string;
  noTipoUrl?: string;

}
