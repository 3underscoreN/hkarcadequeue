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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkarcadequeue/src/controller/delegate/arcade_search_delegate/arcade_search_delegate.dart';
import 'package:hkarcadequeue/src/controller/provider/arcade_provider/all_arcade_provider.dart';
import 'package:hkarcadequeue/src/controller/provider/arcade_provider/preferred_arcade_provider.dart';

import 'package:hkarcadequeue/src/view/widget/app_bar.dart';

import 'package:hkarcadequeue/src/view/screen/settings_screen/settings_page.dart';

import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/view/widget/arcade_details_button/arcade_list_builder.dart';

class ArcadeQueueScreen extends ConsumerStatefulWidget {
  const ArcadeQueueScreen({super.key});

  @override
  ConsumerState<ArcadeQueueScreen> createState() => _ArcadeQueueScreenState();
}

class _ArcadeQueueScreenState extends ConsumerState<ArcadeQueueScreen> {
  late bool isInArcade;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          title: const Text("機舖資訊"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ArcadeSearchDelegate(
                    stores:
                        ref.read(arcadeStoreProvider).value!.values.toList(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[Tab(text: '全部機舖'), Tab(text: '常駐機舖')],
          ),
        ),
        body: const TabBarView(
          children: [AllArcadeBuilder(), PreferredArcadeBuilder()],
        ),
      ),
    );
  }
}

class AllArcadeBuilder extends ConsumerStatefulWidget {
  const AllArcadeBuilder({super.key});

  @override
  ConsumerState<AllArcadeBuilder> createState() => _AllArcadeBuilderState();
}

class _AllArcadeBuilderState extends ConsumerState<AllArcadeBuilder> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<Map<int, ArcadeStore>> listArcade = ref.watch(
      arcadeStoreProvider,
    );
    return switch (listArcade) {
      AsyncData(:final value) => ArcadeListBuilder(
        arcadeStores: value.values,
      ),
      AsyncError(:final error) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Load跟嘅時候出錯！", textAlign: TextAlign.center),
            const Text("係咪上唔到網？", textAlign: TextAlign.center),
            const Text(
              "如果上到網都係咁，請聯絡developer，睇下佢哋幫唔幫到你。",
              textAlign: TextAlign.center,
            ),
            Text(
              "錯誤訊息：$error",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
      _ => Center(
        child: const CircularProgressIndicator(
          color: Colors.white54,
          strokeWidth: 2.0,
        ),
      ),
    };
  }
}

class PreferredArcadeBuilder extends ConsumerStatefulWidget {
  const PreferredArcadeBuilder({super.key});

  @override
  ConsumerState<PreferredArcadeBuilder> createState() =>
      _PreferredArcadeState();
}

class _PreferredArcadeState extends ConsumerState<PreferredArcadeBuilder> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<int>> preferredArcade = ref.watch(
      preferredArcadeNotifierProvider,
    );
    final Map<int, ArcadeStore> allArcade = {};
    final Map<int, ArcadeStore> preferredArcadeMap = {};
    ref.read(arcadeStoreProvider).whenData((value) {
      allArcade.addAll(value);
    });
    switch (preferredArcade) {
      case AsyncData(:final value):
        for (final int v in value) {
          preferredArcadeMap.addAll({v: allArcade[v]!});
        }
        if (preferredArcadeMap.isEmpty) {
          return const Center(child: Text("你仲未add任何常駐機舖！"));
        } else {
          return ArcadeListBuilder(
            arcadeStores: preferredArcadeMap.values,
          );
        }
      case AsyncError(:final error):
        return Column(
          children: [
            const Text("Load跟嘅時候出錯！"),
            Text("錯誤訊息：$error", overflow: TextOverflow.clip),
          ],
        );
      default:
        return Center(
          child: const CircularProgressIndicator(
            color: Colors.white54,
            strokeWidth: 2.0,
          ),
        );
    }
  }
}
