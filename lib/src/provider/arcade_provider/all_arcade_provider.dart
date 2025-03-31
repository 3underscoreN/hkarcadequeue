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
        ArcadeStore.fromJSON(int.parse(k), v);
      } catch (e) {
        logger.e("Error parsing JSON with id $k", error: e);
      }
    }
  );
  return ArcadeStore.getArcadeList();
});

/// Fetches the arcade list from the backend.
/// Throws an [Exception] if the data cannot be fetched.
Future<Map<dynamic, dynamic>> getArcadeListFromCloud() async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("arcadelist").doc("arcadestorelist").get();
  Object? data = snapshot.data();
  if (data != null) {
    return data as Map<dynamic, dynamic>;
  } else {
    throw Exception("Unable to fetch data from the cloud.");
  }
}
