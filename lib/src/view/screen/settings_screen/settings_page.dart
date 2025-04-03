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

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hkarcadequeue/src/controller/provider/theme_provider/adaptive_theme_state_provider.dart';
import 'package:hkarcadequeue/src/view/screen/settings_screen/dialogs/theme_dialog.dart';

import 'package:hkarcadequeue/src/view/widget/settings_sign_in_button/sign_in_button.dart';

import 'package:url_launcher/url_launcher.dart';

SnackBar notImplementedSnackBar(BuildContext context) {
  return SnackBar(
    content: const Text("唔好意思，呢個功能仲未搞掂！"),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );
}

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late String themeMode;

  @override
  Widget build(BuildContext context) {
    themeMode = ref
        .watch(adaptiveThemeProvider)
        .when(
          data: (AdaptiveThemeMode? data) {
            if (data == AdaptiveThemeMode.light) {
              return "淺色";
            } else if (data == AdaptiveThemeMode.dark) {
              return "深色";
            } else if (data == AdaptiveThemeMode.system) {
              return "跟返系統";
            }
            return "load唔到";
          },
          loading: () => "load緊...",
          error: (Object? error, StackTrace? stackTrace) => "load唔到",
        );

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        children: <Widget>[
          Card(child: GSignInButton()),
          const Divider(),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ThemeDialog();
                  },
                );
              },
              child: ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('顏色主題'),
                subtitle: Text('而家設定：$themeMode'),
              ),
            ),
          ),
          const Divider(),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(notImplementedSnackBar(context));
              },
              child: const ListTile(
                leading: Icon(Icons.outgoing_mail),
                title: Text('回報資料錯誤'),
                subtitle: Text('資料有問題？可以幫手填form回報！'),
              ),
            ),
          ),
          const Divider(),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () async {
                final Uri email = Uri.parse("mailto:hk.musicarcade.info@gmail.com");
                await launchUrl(
                  email,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: const ListTile(
                leading: Icon(Icons.contact_mail_rounded),
                title: Text('聯絡'),
                subtitle: Text('有咩bug/意見/私隱問題可以寫email嚟'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
