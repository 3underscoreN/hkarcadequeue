import 'package:flutter/material.dart';

import 'package:hkarcadequeue/model/arcade_store.dart';

import 'package:hkarcadequeue/src/widget/arcade_details_button/arcade_list_builder.dart';

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
