import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkarcadequeue/model/arcade_store.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();

final arcadeStoreProvider = FutureProvider<Map<int, ArcadeStore>>((ref) async {
  final Map<dynamic, dynamic> loadedJson = await getArcadeListFromCloud();
  // final Map loadedJson = await jsonDecode(await rootBundle.loadString("lib/model/arcade_list.json"));
  loadedJson.forEach(
    (k, v) {
      try {
        final int id = v.remove("id");
        ArcadeStore.fromJSON(id, v);
      } catch (e) {
        logger.e("Error parsing JSON with doc-id $k", error: e);
      }
    }
  );
  return ArcadeStore.getArcadeList();
});

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

    
    if (doc.id == "arcadestorelist") { // TODO: remove
      continue;
    }
    
    loadedJson[doc.id] = doc.data();
  }
  return loadedJson;
}
