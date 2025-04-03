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

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hkarcadequeue/src/view/theme/light_theme.dart';
import 'package:hkarcadequeue/src/view/theme/dark_theme.dart';

import 'package:hkarcadequeue/src/view/screen/landing_screen/landing_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider("6LdhegQrAAAAAEI0LN8HIBKJK8Bj5OcDMhkuKPc4"),
    androidProvider: AndroidProvider.playIntegrity
  );
  final AdaptiveThemeMode? savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MainApp(savedThemeMode: savedThemeMode));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (theme, darkTheme) => MaterialApp(
          title: '音G資訊站',
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const LandingScreen(),
        ),
      ),
    );
  }
}
