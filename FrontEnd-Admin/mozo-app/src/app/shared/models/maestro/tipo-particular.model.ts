import { BaseModel } from "@sharedModels/base.model";

export interface TipoParticularModel extends BaseModel {
  coGrupo?: number;
  coGrupoPadre?: number;
  coTipoPadre?: number;
  coTipo?: number;
  coEmpresa?: number;
  coModulo?: number;
  nuOrden?: number;
  noTipo?: string;  
  txDescripcion?: string;
  noSigla?: string;
  flDefault?: number;
  
  noComando?: string;
  noValor?: string;
}

//export interface EmpresaModel extends BaseModel {