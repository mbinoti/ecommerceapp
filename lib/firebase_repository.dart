import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepository {
  final CollectionReference collection;
  final FirebaseStorage storage;

  FirebaseRepository({required this.collection, required this.storage});

  Stream<List<DocumentSnapshot>> getCollectionStream() {
    return collection.snapshots().map((query) => query.docs);
  }

  Future<String> getImageUrl(String path) async {
    return storage.ref(path).getDownloadURL();
  }
}
