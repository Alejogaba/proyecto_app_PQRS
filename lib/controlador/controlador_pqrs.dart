import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../modelo/pqrs.dart';

class ControladorPQRS {
  Future<void> marcarPqrsFinalizada(int iDticket) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('id', isEqualTo: iDticket)
        .get();

    final List<DocumentSnapshot> documents = snapshot.docs;

    for (final DocumentSnapshot document in documents) {
      await document.reference.update({'estado': 3});
    }
  }

  Future<void> marcarPqrsEnProceso(int iDticket) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pqrs')
        .where('id', isEqualTo: iDticket)
        .get();

    final List<DocumentSnapshot> documents = snapshot.docs;

    for (final DocumentSnapshot document in documents) {
      await document.reference.update({'estado': 2});
    }
  }

  Future<String?> guardarPQR(Pqrs pqr) async {
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

  Future<void> actualizarPQR(Pqrs pqr) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('pqrs')
          .where('id', isEqualTo: pqr.id)
          .get();

      final documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        final document = documents.first;
        await document.reference.update(pqr.mapeo());
        print('PQR actualizada con éxito. ID: ${document.id}');
      } else {
        print('No se encontró ninguna PQR con el idToken proporcionado.');
      }
    } catch (error) {
      print('Error al actualizar la PQR: $error');
    }
  }

  Future<List<Pqrs>> cargarPQRS(
      {required bool esAnonima,
      int estadoPqr = 1,
      String tipoPqrs = 'Todas',
      required String textoBusqueda}) async {
    List<Pqrs> pqrsList = [];
    if (textoBusqueda.length < 1) {
      if (tipoPqrs == 'Todas') {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('pqrs')
            .where('esAnonimo', isEqualTo: esAnonima)
            .where('estado', isEqualTo: estadoPqr)
            .get();

        querySnapshot.docs.forEach((doc) {
          Pqrs pqr = Pqrs.fromMap(doc.data() as Map<String, dynamic>);
          pqrsList.add(pqr);
        });
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('pqrs')
            .where('esAnonimo', isEqualTo: esAnonima)
            .where('estado', isEqualTo: estadoPqr)
            .where('tipoPQRS', isEqualTo: tipoPqrs)
            .get();

        querySnapshot.docs.forEach((doc) {
          Pqrs pqr = Pqrs.fromMap(doc.data() as Map<String, dynamic>);
          pqrsList.add(pqr);
        });
      }
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pqrs')
          .where('esAnonimo', isEqualTo: esAnonima)
          .where('id', isEqualTo: int.parse(textoBusqueda))
          .get();

      querySnapshot.docs.forEach((doc) {
        Pqrs pqr = Pqrs.fromMap(doc.data() as Map<String, dynamic>);
        pqrsList.add(pqr);
      });
    }

    return pqrsList;
  }

  Future<List<Pqrs>> cargarTodasPQRS({required String textoBusqueda}) async {
    List<Pqrs> pqrsList = [];
    if (textoBusqueda.length > 0) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pqrs')
          .where('id', isEqualTo: int.parse(textoBusqueda))
          .get();

      querySnapshot.docs.forEach((doc) {
        Pqrs pqr = Pqrs.fromMap(doc.data() as Map<String, dynamic>);
        pqrsList.add(pqr);
      });
      return pqrsList;
    } else {
      return [];
    }
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
            isEqualTo: DateFormat('d - MMMM - y', 'es')
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
            isEqualTo: DateFormat('d - MMMM - y', 'es')
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
            isEqualTo: DateFormat('d - MMMM - y', 'es')
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
        .where('fechaInt', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
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
        .where('fechaInt', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
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
        .where('fechaInt', isGreaterThanOrEqualTo: lunes.millisecondsSinceEpoch)
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
