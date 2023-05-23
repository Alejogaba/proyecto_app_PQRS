class PQRS {
  String? id;
  String? nombreDependencia;
  String? nombreSolicitante;
  String? apellidoSolicitante;
  String? tipoIdSolicitante;
  String? idSolicitante;
  String? tipoPQRS;
  String? tipoMedioContacto;
  String? numTelefono;
  String? correo;
  String? direccion;
  String? descripcion;

  PQRS({
    this.id,
    this.nombreDependencia,
    this.nombreSolicitante,
    this.apellidoSolicitante,
    this.tipoIdSolicitante,
    this.idSolicitante,
    this.tipoPQRS,
    this.tipoMedioContacto,
    this.numTelefono,
    this.correo,
    this.direccion,
    this.descripcion,
  });

  PQRS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreDependencia = json['nombreDependencia'];
    nombreSolicitante = json['nombreSolicitante'];
    apellidoSolicitante = json['apellidoSolicitante'];
    tipoIdSolicitante = json['tipoIdSolicitante'];
    idSolicitante = json['idSolicitante'];
    tipoPQRS = json['tipoPQRS'];
    tipoMedioContacto = json['tipoMedioContacto'];
    numTelefono = json['numTelefono'];
    correo = json['correo'];
    direccion = json['direccion'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreDependencia': nombreDependencia,
      'nombreSolicitante': nombreSolicitante,
      'apellidoSolicitante': apellidoSolicitante,
      'tipoIdSolicitante': tipoIdSolicitante,
      'idSolicitante': idSolicitante,
      'tipoPQRS': tipoPQRS,
      'tipoMedioContacto': tipoMedioContacto,
      'numTelefono': numTelefono,
      'correo': correo,
      'direccion': direccion,
      'descripcion': descripcion,
    };
  }
}
