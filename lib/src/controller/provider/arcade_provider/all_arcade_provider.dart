/*
 * hkarcadequeue - An app for providing HK arcade info.
 * Copyright (C) 2025 CHAN Chung Yuk
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/model/queries/get_arcade_list.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();

final arcadeStoreProvider = FutureProvider<Map<int, ArcadeStore>>((ref) async {
  final Map<dynamic, dynamic> loadedJson = await getArcadeListFromCloud();
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
