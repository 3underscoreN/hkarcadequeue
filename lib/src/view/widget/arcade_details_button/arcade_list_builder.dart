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