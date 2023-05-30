class pqrs {
  String? id;
  String? nombreDependencia;
  String? primerNombreSolicitante;
  String? segundoNombreSolicitante;
  String? primerApellidoSolicitante;
  String? segundoApellidoSolicitante;
  String? tipoIdSolicitante;
  String? idSolicitante;
  String? tipoPQRS;
  int tipoMedioContacto;
  String? numTelefono;
  String? medioContacto;
  String? direccion;
  String? descripcion;
  String? respuesta;
  String? nombreArchivoAdjunto;

  pqrs({
    this.id,
    this.nombreDependencia,
    this.primerNombreSolicitante,
    this.segundoNombreSolicitante,
    this.primerApellidoSolicitante,
    this.segundoApellidoSolicitante,
    this.tipoIdSolicitante,
    this.idSolicitante,
    this.tipoPQRS,
    required this.tipoMedioContacto,
    this.numTelefono,
    this.medioContacto,
    this.direccion,
    this.descripcion,
    this.respuesta,
    this.nombreArchivoAdjunto,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombreDependencia': nombreDependencia,
      'primerNombreSolicitante': primerNombreSolicitante,
      'segundoNombreSolicitante': segundoNombreSolicitante,
      'primerApellidoSolicitante': primerApellidoSolicitante,
      'segundoApellidoSolicitante': segundoApellidoSolicitante,
      'tipoIdSolicitante': tipoIdSolicitante,
      'idSolicitante': idSolicitante,
      'tipoPQRS': tipoPQRS,
      'tipoMedioContacto': tipoMedioContacto,
      'numTelefono': numTelefono,
      'correo': medioContacto,
      'direccion': direccion,
      'descripcion': descripcion,
      'respuesta': respuesta,
      'nombreArchivoAdjunto': nombreArchivoAdjunto,
    };
  }
}
