class soporte {
  String? primerNombre;
  String? segundoNombre;
  String? medioContacto;
  String? detalleProblema;
  String? respuesta;
  String? nombreArchivoAdjuntoS;
  String? tipoSOPORTE;
  String fechaString;
  int fechaInt;

  soporte({
    this.primerNombre,
    this.segundoNombre,
    this.medioContacto,
    this.detalleProblema,
    this.respuesta,
    this.nombreArchivoAdjuntoS,
    this.tipoSOPORTE,
    this.fechaString = '',
    this.fechaInt = 0,
  });

  Map<String, dynamic> MapeoSoporte() {
    return {
      'primerNombre': primerNombre,
      'segundoNombre': segundoNombre,
      'medioContacto': medioContacto,
      'detalleProblema': detalleProblema,
      'respuesta': respuesta,
      'nombreArchivoAdjuntoS': nombreArchivoAdjuntoS,
      'tipoSOPORTE': tipoSOPORTE,
      'fechaString': fechaString,
      'fechaInt': fechaInt,
    };
  }
}
