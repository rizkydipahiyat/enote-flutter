import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String staff, String status, String perihal) async {
    try {
      await firestore.collection("arsips").add({
        'name': name,
        'staff': staff,
        'status': status,
        'perihal': perihal,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("arsips").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
      await firestore.collection('arsips').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "staff": doc["staff"], "status": doc["status"], "perihal": doc["perihal"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String name, String staff, String status, String perihal) async {
    try {
      await firestore
          .collection("arsips")
          .doc(id)
          .update({'name': name, 'staff': staff, 'status': status, 'perihal': perihal});
    } catch (e) {
      print(e);
    }
  }
}