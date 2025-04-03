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

import 'package:flutter/material.dart';

import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/view/widget/arcade_details_button/arcade_list_builder.dart';

class ArcadeSearchDelegate extends SearchDelegate<Null> {
  ArcadeSearchDelegate({required this.stores});

  final List<ArcadeStore> stores;

  bool _matcher(ArcadeStore store, String query) {
    final List<String> candidates = [
      store.chineseName,
      store.englishName,
      store.abbreviation,
    ];
    return candidates.any(
      (candidate) => candidate.toLowerCase().contains(query.toLowerCase()),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for clearing the field
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Back button
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ArcadeStore> suggestions =
        stores.where((store) => _matcher(store, query)).toList();
    return ArcadeListBuilder(arcadeStores: suggestions,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ArcadeStore> suggestions =
        stores.where((store) => _matcher(store, query)).toList();
    return ArcadeListBuilder(arcadeStores: suggestions,);
  }
}
