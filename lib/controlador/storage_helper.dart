import 'dart:convert';
import 'dart:html';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../flutter_flow/flutter_flow_util.dart';

class StorageHelper {

  Future<void> subirArchivoBase64(String base64Data, String nombreArchivo,{String carpeta='1'}) async {
  int dataIndex = base64Data.indexOf(',') + 1;
  String base64String = base64Data.substring(dataIndex);
  Uint8List bytes = base64.decode(base64String);
  // Crear una referencia al archivo en Firebase Storage
  final storageRef = FirebaseStorage.instance.ref().child('pqrs/$carpeta/$nombreArchivo');
  await storageRef.putData(bytes).whenComplete(() => print('Archivo subido correctamente'));
  }

Future<void> guardarImagenEnFirebaseStorage(Uint8List imagenBytes, String idFuncionario) async {
  try {
    final int limiteTamanio = 1024 * 1024; // 1 MB

    // Comprimir la imagen si supera el límite de tamaño
    if (imagenBytes.length > limiteTamanio) {
      final compressedBytes = await FlutterImageCompress.compressWithList(
        imagenBytes,
        minHeight: 400,
        minWidth: 400,
        quality: 85,
      );
      imagenBytes = Uint8List.fromList(compressedBytes);
    }

    // Crear una referencia al archivo en Firebase Storage
    final ref = FirebaseStorage.instance.ref().child('funcionarios/$idFuncionario.jpg');

    // Subir los bytes de la imagen a Firebase Storage
    final uploadTask = ref.putData(imagenBytes);

    // Esperar a que se complete la carga del archivo
    final snapshot = await uploadTask.whenComplete(() {});

    // Obtener la URL de descarga del archivo
    final downloadURL = await snapshot.ref.getDownloadURL();

    print('Imagen guardada en Firebase Storage: $downloadURL');
  } catch (error) {
    print('Error al guardar la imagen en Firebase Storage: $error');
  }
}

void descargarArchivo(String id,String nombreArchivo) {
  AnchorElement anchorElement = AnchorElement(href: 'https://firebasestorage.googleapis.com/v0/b/bdpqrs-2623b.appspot.com/o/pqrs%2F$id?alt=media&token=2c8d22c5-9e07-4e57-b83d-7485432a3741');
  anchorElement.download = nombreArchivo;
  anchorElement.click();
}
  
}