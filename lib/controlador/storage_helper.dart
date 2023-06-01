import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

import '../flutter_flow/flutter_flow_util.dart';

class StorageHelper {

  Future<void> subirArchivoBase64(String base64Data, String nombre) async {
  int dataIndex = base64Data.indexOf(',') + 1;
  String base64String = base64Data.substring(dataIndex);
  Uint8List bytes = base64.decode(base64String);
// Crear una referencia al archivo en Firebase Storage
final storageRef = FirebaseStorage.instance.ref().child('pqrs/$nombre');
await storageRef.putData(bytes).whenComplete(() => print('Archivo subido correctamente'));
  }
  
}