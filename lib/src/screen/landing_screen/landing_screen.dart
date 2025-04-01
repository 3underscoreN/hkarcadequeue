import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:hkarcadequeue/src/screen/arcade_queue_status/arcade_queue_screen.dart';
import 'package:hkarcadequeue/src/screen/settings_screen/settings_page.dart';

import 'package:hkarcadequeue/src/widget/landing_page_button/landing_page_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('音G資訊站')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LandingPageButton(
                  text: "機舖資訊",
                  icon: Icons.store_mall_directory_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArcadeQueueScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LandingPageButton(
                  text: "maimai DX NET",
                  icon: Icons.circle,
                  onPressed: () async {
                    final Uri url = Uri.parse(
                      'https://maimaidx-eng.com/maimai-mobile/',
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
                LandingPageButton(
                  text: "CHUNITHM NET",
                  icon: Icons.pending,
                  onPressed: () async {
                    final Uri url = Uri.parse(
                      'https://chunithm-net-eng.com/mobile/',
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LandingPageButton(
                  text: "快速入門",
                  icon: Icons.assistant,
                  onPressed: () async {
                    final Uri url = Uri.parse(
                      'https://music-g-doc.gitbook.io/music-game-docs/getting-started/quickstart',
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LandingPageButton(
                  text: "設定",
                  icon: Icons.settings,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                LandingPageButton(
                  text: "私隱聲明",
                  icon: Icons.feed,
                  onPressed: () async {
                    final Uri url = Uri.parse(
                      'https://hkarcadequeue.web.app/privacy.html',
                    );
                    await launchUrl(url, mode: LaunchMode.inAppBrowserView);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "本應用程式仍在開發階段，可能會有bug或不穩定的情況發生。\n如發現問題，請透過設定入面嘅資料聯絡我哋。",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              "本應用程式與SEGA Corporation並無關聯。資料僅供參考之用。",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            FutureBuilder( // Version number
              future: PackageInfo.fromPlatform(), 
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(
                    "v${snapshot.data.version} (${snapshot.data.buildNumber})",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  );
                }
                return const SizedBox.shrink(); // Show nothing while loading / no data
              },
            ),
          ],
        ),
      ),
    );
  }
}
