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

import 'package:shared_preferences/shared_preferences.dart';

/// A provider that stores the preferred arcade list
class PreferredArcadeNotifier extends AsyncNotifier<List<int>> {
  @override
  Future<List<int>> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<int> preferredArcadeList = prefs
            .getStringList("preferred_arcade_list")
            ?.map((e) => int.parse(e))
            .toList() ??
        [];
    return preferredArcadeList;
  }

  /// Add an arcade to the preferred list
  /// Requires the [id] of the arcade to be added
  Future<void> addPreferred(int id) {
    for (final ids in state.value ?? []) {
      if (ids == id) {
        return Future.value();
      }
    }
    state = AsyncValue.data([...state.value ?? [], id]); 
    _saveToPrefs(state.value ?? []);
    return Future.value();
  }

  /// Remove an arcade from the preferred list
  /// Requires the [id] of the arcade to be removed
  Future<void> removePreferred(int id) {
    final List<int> newList = state.value ?? [];
    newList.remove(id);
    state = AsyncValue.data(newList);
    _saveToPrefs(state.value ?? []);
    return Future.value();
  }
  
  /// Check if an arcade is in the preferred list
  /// Requires the [id] of the arcade to be checked
  Future<bool> isInPreferred(int id) async {
    for (final ids in state.value ?? []) {
      if (ids == id) {
        return true;
      }
    }
    return false;
  }

  Future<void> _saveToPrefs(List<int> preferredArcadeList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("preferred_arcade_list",
        preferredArcadeList.map((e) => e.toString()).toList());
  }
}

final preferredArcadeNotifierProvider =
    AsyncNotifierProvider<PreferredArcadeNotifier, List<int>>(
  () => PreferredArcadeNotifier(),
);
