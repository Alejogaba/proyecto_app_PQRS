import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelo/pqrs.dart';

class ControladorPQRS {
  Future<String?> guardarPQR(pqrs pqr) async {
    late String result;
    await FirebaseFirestore.instance
        .collection('pqrs') // Nombre de la colección en Firestore
        .add(pqr.toMap())
        .then((value) {
      print('PQR guardada con éxito. ID: ${value.id}');
      result = value.id;
    }).catchError((error) {
      print('Error al guardar la PQR: $error');
      result = '';
    });
    return result;
  }
}
