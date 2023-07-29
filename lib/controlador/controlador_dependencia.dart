import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_p_q_r_s/controlador/utilidades.dart';

import '../modelo/dependencia.dart';

class ControladorDependencia {
  Utilidades util = Utilidades();
  Stream<List<Dependencia?>> obtenerDependenciasStream(String valorBusqueda) {
    if (valorBusqueda.isEmpty) {
      log('Retornando todas las dependencias');
      return FirebaseFirestore.instance
          .collection('dependencias')
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        List<Dependencia> dependencias = [];
        querySnapshot.docs.forEach((doc) => dependencias
            .add(Dependencia.fromMap(doc.data() as Map<String, dynamic>)));
        return dependencias;
      });
    } else {
      log('Retornando dependencias - valorBusqueda: $valorBusqueda');
      return FirebaseFirestore.instance
          .collection('dependencias')
          .where('nombre',
              isGreaterThanOrEqualTo: util.capitalizarPalabras(valorBusqueda))
          .where('nombre',
              isLessThanOrEqualTo:
                  util.capitalizarPalabras(valorBusqueda) + '\uf8ff')
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        List<Dependencia> dependencias = [];
        querySnapshot.docs.forEach((doc) => dependencias
            .add(Dependencia.fromMap(doc.data() as Map<String, dynamic>)));
        log('lista dependencias: ' + dependencias[0].nombre.toString());
        return dependencias;
      });
    }
  }

  Future<String?> guardarDependencia(Dependencia dependencia) async {
    late String result;
    await FirebaseFirestore.instance
        .collection('dependencias') // Nombre de la colección en Firestore
        .add(dependencia.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('dependencias')
          .doc(value.id)
          .update(({'uid': value.id}));
      print('Dependencia guardada con éxito. ID: ${value.id}');
      result = value.id;
    }).catchError((error) {
      print('Error al guardar la Dependencia: $error');
      result = '';
    });
    return result;
  }

  Future<Dependencia?> buscarDepedenciaPorNombre(String nombreDependencia) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('dependencias')
          .where('nombre', isEqualTo: nombreDependencia)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        final docSnapshot = querySnapshot.docs[0];
        final caso = Dependencia.fromMap(docSnapshot.data());
        return caso;
      } else {
        return null;
      }
    } catch (e) {
      print('Error al buscar dependencia individual por nombre: $e');
      return null;
    }
  }
}
