import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../modelo/pqrs.dart';

class ControladorPQRS {
  Future<String?> guardarPQR(pqrs pqr) async {
    late String result;
    await FirebaseFirestore.instance
        .collection('pqrs') // Nombre de la colección en Firestore
        .add(pqr.mapeo())
        .then((value) {
      print('PQR guardada con éxito. ID: ${value.id}');
      result = value.id;
    }).catchError((error) {
      print('Error al guardar la PQR: $error');
      result = '';
    });
    return result;
  }

  Future<List<pqrs>> cargarPQRS() async {
  List<pqrs> pqrsList = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pqrs').get();

  querySnapshot.docs.forEach((doc) {
    pqrs pqr = pqrs.fromMap(doc.data() as Map<String, dynamic>);
    pqrsList.add(pqr);
  });

  return pqrsList;
}

  Future<int> getTotalPqrsCount() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('pqrs').get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsCountHoy() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('fechaString',
            isEqualTo: DateFormat('d "de" MMMM "de" y', 'es')
                .format(DateTime.now())
                .toString())
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsAnonimoCountHoy() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('esAnonimo', isEqualTo: true)
        .where('fechaString',
            isEqualTo: DateFormat('d "de" MMMM "de" y', 'es')
                .format(DateTime.now())
                .toString())
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsIdentificacionCountHoy() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('esAnonimo', isEqualTo: false)
        .where('fechaString',
            isEqualTo: DateFormat('d "de" MMMM "de" y', 'es')
                .format(DateTime.now())
                .toString())
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsCountSemana() async {
    DateTime nowtemp = DateTime.now();
    DateTime now = DateTime(nowtemp.year, nowtemp.month, nowtemp.day, 0, 0, 0);
    DateTime lunes = (now.weekday != 1)
        ? now.subtract(Duration(days: now.weekday - (now.weekday - 1)))
        : now;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('fecha', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsIdentificacionCountSemana() async {
    DateTime nowtemp = DateTime.now();
    DateTime now = DateTime(nowtemp.year, nowtemp.month, nowtemp.day, 0, 0, 0);
    DateTime lunes = (now.weekday != 1)
        ? now.subtract(Duration(days: now.weekday - (now.weekday - 1)))
        : now;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('esAnonimo', isEqualTo: false)
        .where('fecha', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsAnonimoCountSemana() async {
    DateTime nowtemp = DateTime.now();
    DateTime now = DateTime(nowtemp.year, nowtemp.month, nowtemp.day, 0, 0, 0);
    DateTime lunes = (now.weekday != 1)
        ? now.subtract(Duration(days: now.weekday - (now.weekday - 1)))
        : now;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('esAnonimo', isEqualTo: true)
        .where('fecha', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsPendiente() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('estado', isEqualTo: 1)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsEnProceso() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('estado', isEqualTo: 2)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsFinalizado() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('estado', isEqualTo: 3)
        .get();

    return querySnapshot.size;
  }

  Future<int> getTotalPqrsCountAnonima() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('primerNombreSolicitante', isEqualTo: '')
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsPendienteAnonima() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where(
          'primerNombreSolicitante',
          isEqualTo: '',
        )
        .where('estado', isEqualTo: 1)
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsEnProcesoAnonima() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where(
          'primerNombreSolicitante',
          isEqualTo: '',
        )
        .where('estado', isEqualTo: 2)
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsFinalizadoAnonima() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where(
          'primerNombreSolicitante',
          isEqualTo: '',
        )
        .where('estado', isEqualTo: 3)
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsCountIdentificacion() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('primerNombreSolicitante', isNotEqualTo: '')
        .get();
    print('Se ha cargado el total pqrs identificaion');
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsPendienteIdentificacion() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where(
          'primerNombreSolicitante',
          isNotEqualTo: '',
        )
        .where('estado', isEqualTo: 1)
        .get();
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsEnProcesoIdentificaion() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('estado', isEqualTo: 2)
        .where(
          'primerNombreSolicitante',
          isNotEqualTo: '',
        )
        .get();
    print('total identificacion proceso: ' + querySnapshot.size.toString());
    return querySnapshot.size;
  }

  Future<int> getTotalPqrsFinalizadoIdentificaion() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where(
          'primerNombreSolicitante',
          isNotEqualTo: '',
        )
        .where('estado', isEqualTo: 3)
        .get();
    return querySnapshot.size;
  }
}
