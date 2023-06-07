class Pqrs {
  int? id;
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

  Pqrs(
      {this.id=0,
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
      'id':id,
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

  factory Pqrs.fromMap(Map<String, dynamic> map) {
    return Pqrs(
      nombreDependencia: map['nombreDependencia'] ?? '',
      primerNombreSolicitante: map['primerNombreSolicitante'] ?? '',
      segundoNombreSolicitante: map['segundoNombreSolicitante'] ?? '',
      primerApellidoSolicitante: map['primerApellidoSolicitante'] ?? '',
      segundoApellidoSolicitante: map['segundoApellidoSolicitante'] ?? '',
      tipoIdSolicitante: map['tipoIdSolicitante'] ?? '',
      idSolicitante: map['idSolicitante'] ?? '',
      tipoPQRS: map['tipoPQRS'] ?? '',
      tipoMedioContacto: map['tipoMedioContacto'] ?? '',
      numTelefono: map['numTelefono'] ?? '',
      medioContacto: map['correo'] ?? '',
      direccion: map['direccion'] ?? '',
      descripcion: map['descripcion'] ?? '',
      respuesta: map['respuesta'] ?? '',
      nombreArchivoAdjunto: map['nombreArchivoAdjunto'] ?? '',
      estado: map['estado'] ?? 0,
      fechaInt: map['fechaInt'] ?? 0,
      fechaString: map['fechaString'] ?? '',
      esAnonimo: map['esAnonimo'] ?? false,
      id: map['id'] ?? 0
    );
  }
}
