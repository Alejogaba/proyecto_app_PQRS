import 'package:cloud_firestore/cloud_firestore.dart';

class Counter {
  final String collectionName;
  final String documentId;
  int count = 0;

  Counter({this.collectionName='counter', this.documentId='',count=0});

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(count: map['count'] ?? 0);
  }

  Future<int> generateAutoIncrementedId() async {
    // Obtiene la referencia al documento del contador
    DocumentReference counterRef =
        FirebaseFirestore.instance.collection(collectionName).doc(documentId);

    // Incrementa el contador en una transacción atómica
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counterRef);

      int currentCount = snapshot.exists ? Counter.fromMap(snapshot.data() as Map<String, dynamic>).count : 0;
      int newCount = currentCount + 1;

      // Actualiza el contador en Firestore
      transaction.update(counterRef, {'count': newCount});

      // Genera el ID utilizando el nuevo contador
      return newCount;
    });
  }
}
