import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Counter {
  final String collectionName;
  final String documentId;
  int count = 5;

  Counter({this.collectionName = 'counters', this.documentId = '', count = 6});

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(count: map['count']);
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
    };
  }

// Incrementa el contador en Firestore
  Future<int?> incrementCounter(DocumentReference<Map<String, dynamic>> counterRef) async {
     return FirebaseFirestore.instance.runTransaction((transaction) async {
      final counterSnapshot = await transaction.get(counterRef);
      if (counterSnapshot.exists) {
        final currentValue = counterSnapshot.data()!['count'];
         print('current counter:' + currentValue.toString());
        final newValue = currentValue + 1;
        transaction.update(counterRef, {'count': newValue});
        return newValue;
      } else {
        return null;
      }
    });
  }

  Future<int> generateCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('counters')
        .doc('contadorPqrs')
        .get();

    Counter contador = Counter.fromMap(querySnapshot.data()!);
    print('current counter:' + contador.count.toString());
    contador.count = contador.count + 1;
    print('new count: ' + contador.count.toString());
    FirebaseFirestore.instance
        .collection('counters')
        .doc('contadorPqrs')
        .set(contador.toMap());
    return contador.count;
  }

  Future<int> generateAutoIncrementedId() async {
    // Obtiene la referencia al documento del contador
    DocumentReference counterRef =
        FirebaseFirestore.instance.collection(collectionName).doc(documentId);

    // Incrementa el contador en una transacción atómica
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counterRef);

      Counter conter = Counter.fromMap(snapshot.data() as Map<String, dynamic>);
      print('current counter:' + conter.count.toString());
      int newCount = conter.count + 1;
      print('new count: ' + newCount.toString());

      // Actualiza el contador en Firestore
      transaction.update(counterRef, {'count': newCount});

      // Genera el ID utilizando el nuevo contador
      return newCount;
    });
  }
}
