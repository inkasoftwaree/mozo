import { MenuModel } from "./menu.model";

export interface ModuloUsuarioModel {
  coModuloUsuario: number;
  coEmpresa: number;
  coModulo: number;
  coUsuario: number;
  coPerfil: number;
  nuOrden: number;
  noModulo: string;
  noPerfil: string;
  noIcono: string;
  noArea: string;
  noCarpetaVirtual: string;
  menuLst: MenuModel[];
}
