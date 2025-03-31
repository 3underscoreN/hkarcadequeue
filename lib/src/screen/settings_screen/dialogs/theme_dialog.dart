import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hkarcadequeue/src/provider/theme_provider/adaptive_theme_state_provider.dart';

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
