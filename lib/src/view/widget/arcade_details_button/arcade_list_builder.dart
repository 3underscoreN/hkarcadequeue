import 'package:flutter/material.dart';

import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/view/screen/arcade_queue_status/arcade_details/arcade_details_screen.dart';
import 'package:hkarcadequeue/src/view/widget/crowdness_visualizer.dart';


class ArcadeListBuilder extends StatelessWidget {
  final Iterable<ArcadeStore> arcadeStores;

  const ArcadeListBuilder({super.key, required this.arcadeStores});

  @override
  Widget build(BuildContext context) {
    final ListView builder = ListView.builder(
      itemCount: arcadeStores.length,
      itemBuilder: (BuildContext context, int index) {
        final ArcadeStore arcadeStore = arcadeStores.elementAt(index);
        return Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ArcadeDetailsScreen(underlyingStore: arcadeStore),
                ),
              );
            },
            child: ListTile(
              title: Text(arcadeStore.chineseName),
              subtitle: Text(arcadeStore.abbreviation),
              trailing: PeopleCountShower(id: arcadeStore.id),
            ),
          ),
        );
      },
    );

    return builder;
  }
}