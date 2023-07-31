class Utilidades {
  String capitalizarPalabras(String texto) {
    List<String> palabras = texto.split(' ');
    for (int i = 0; i < palabras.length; i++) {
      String palabra = palabras[i];
      if (palabra.isNotEmpty) {
        palabras[i] =
            palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();
      }
    }
    return palabras.join(' ');
  }
   String definirTipoEnvio(int tipoMedioRespuesta) {
    switch (tipoMedioRespuesta) {
      case 1:
        return 'Enviar por correspondencia';
      case 2:
        return 'Enviar respuesta al correo electrónico';
      case 3:
        return 'Enviar respuesta al WhatsApp';
      default:
        return 'Reclamar en ventanilla';
    }
  }
}
