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
  String capitalizarParrafo(String texto) {
  // Capitalizar la primera letra de la primera palabra
  texto = texto.trim();
  if (texto.isNotEmpty) {
    texto = texto[0].toUpperCase() + texto.substring(1);
  }

  // Capitalizar la primera letra después de puntos seguidos o aparte
  texto = texto.replaceAllMapped(RegExp(r'(\.\s+|\.\n+|\n+)'), (match) {
    return match.group(0).toString().toUpperCase();
  });

  return texto;
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
