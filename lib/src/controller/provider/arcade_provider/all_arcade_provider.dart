import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/model/queries/get_arcade_list.dart';

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
