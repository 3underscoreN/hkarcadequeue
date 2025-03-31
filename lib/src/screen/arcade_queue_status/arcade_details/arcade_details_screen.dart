import 'package:flutter/material.dart';
import 'package:hkarcadequeue/src/widget/arcade_details_button/report_button.dart';

import 'package:hkarcadequeue/src/widget/arcade_details_button/star_button.dart';
import 'package:hkarcadequeue/src/widget/app_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:hkarcadequeue/model/arcade_store.dart';

import 'package:hkarcadequeue/src/utility/data2text.dart';

class ArcadeDetailsScreen extends ConsumerStatefulWidget {
  final ArcadeStore underlyingStore;
  const ArcadeDetailsScreen({super.key, required this.underlyingStore});

  @override
  ConsumerState<ArcadeDetailsScreen> createState() =>
      _ArcadeDetailsScreenState();
}

class _ArcadeDetailsScreenState extends ConsumerState<ArcadeDetailsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: const Text('機舖資料'),
        actions: [
          ReportButton(id: widget.underlyingStore.id),
          StarButton(id: widget.underlyingStore.id),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('機廳名'),
            subtitle: Text(
              '${widget.underlyingStore.chineseName}\n${widget.underlyingStore.englishName}',
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.no_accounts),
            title: const Text('牌照限制'),
            subtitle: Text(
              restrictionConverter(widget.underlyingStore.restriction),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.smoking_rooms),
            title: const Text('煙況'),
            subtitle: Text(
              '${smokeConverter(widget.underlyingStore.smokiness)}\n提示：根據香港法例第371章第3條，任何遊戲機中心均禁止吸煙。',
            ),
          ),
          const Divider(height: 0),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: const Center(
              child: Text(
                "筐體數量",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text("maimai でらっくす"),
                  Text(
                    amountConverter(widget.underlyingStore.maiAmount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("CHUNITHM"),
                  Text(
                    amountConverter(widget.underlyingStore.chuniAmount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 0),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                MapsLauncher.launchCoordinates(
                  widget.underlyingStore.location.latitude,
                  widget.underlyingStore.location.longitude,
                  widget.underlyingStore.chineseName,
                );
              },
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('地址'),
                subtitle: Text(
                  '${widget.underlyingStore.chineseAddress}\n${widget.underlyingStore.englishAddress}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
