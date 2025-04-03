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

