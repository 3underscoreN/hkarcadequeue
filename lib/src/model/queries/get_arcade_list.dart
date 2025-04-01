import 'package:cloud_firestore/cloud_firestore.dart';

/// Fetches the arcade list from the backend.
/// Throws an [Exception] if there's no data.
Future<Map<dynamic, dynamic>> getArcadeListFromCloud() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("arcadelist")
      .orderBy("id")
      .get();

  if (snapshot.docs.isEmpty) {
    throw Exception("No data found");
  }

  Map<dynamic, dynamic> loadedJson = {};
  for (var doc in snapshot.docs) {
    loadedJson[doc.id] = doc.data();
  }
  return loadedJson;
}