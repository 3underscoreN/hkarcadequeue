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

class ThemeDialog extends ConsumerWidget {
  const ThemeDialog({super.key});

  void _setTheme(BuildContext context, WidgetRef ref, AdaptiveThemeMode newTheme) {
    ref.read(adaptiveThemeProvider.notifier).setThemeMode(newTheme, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("主題"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text("淺色"),
            onTap: () {
              _setTheme(context, ref, AdaptiveThemeMode.light);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text("深色"),
            onTap: () {
              _setTheme(context, ref, AdaptiveThemeMode.dark);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text("跟返系統"),
            onTap: () {
              _setTheme(context, ref, AdaptiveThemeMode.system);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
