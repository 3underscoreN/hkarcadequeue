import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class AdaptiveThemeNotifier extends AsyncNotifier<AdaptiveThemeMode?> {

  /// Fetches the current theme by calling [AdaptiveTheme.getThemeMode()].
  /// 
  /// Returns an [AdaptiveThemeMode] or `null`.
  Future<AdaptiveThemeMode?> _fetch() async {
    final AdaptiveThemeMode? themeMode = await AdaptiveTheme.getThemeMode();
    return themeMode;
  }

  @override
  Future<AdaptiveThemeMode?> build() {
    return _fetch();
  }

  /// Sets the new theme mode by updating [AdaptiveTheme].
  /// 
  /// Seperate call of [setThemeMode] is not required as it is done in this function.
  Future<void> setThemeMode(AdaptiveThemeMode themeMode, BuildContext context) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      AdaptiveTheme.of(context).setThemeMode(themeMode);
      return _fetch();
    });  
  }
}

final adaptiveThemeProvider = AsyncNotifierProvider<AdaptiveThemeNotifier, AdaptiveThemeMode?>(
  () => AdaptiveThemeNotifier(),
);

