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
  String fechaString;
  int fechaInt;
  bool esAnonimo;

  int estado = 1;

  pqrs(
      {this.id,
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
      this.estado = 1,
      this.fechaString = '',
      this.fechaInt = 0,
      this.esAnonimo = false});

  Map<String, dynamic> mapeo() {
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
      'estado': estado,
      'fechaInt': fechaInt,
      'fechaString': fechaString,
      'esAnonimo': esAnonimo,
    };
  }
}
