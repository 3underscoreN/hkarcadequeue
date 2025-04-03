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

import 'package:hkarcadequeue/src/model/auth/gauth2firebase.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:flutter_signin_button/flutter_signin_button.dart'; // NOTE: This is for non-web
import 'package:google_sign_in_web/web_only.dart'; // NOTE: This is for web only

class GSignInButton extends StatefulWidget {
  const GSignInButton({super.key});

  @override
  State<GSignInButton> createState() => _GSignInButtonState();
}

class _GSignInButtonState extends State<GSignInButton> {
  final googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((
      GoogleSignInAccount? account,
    ) async {
      try {
        await google2firebase(account);
      } catch (e) {
        failedLoginHandler(e);
      }
    });
  }

  void failedLoginHandler(Object e) {
    if (mounted) {
      // mounted check to avoid context error
      if (e is FirebaseAuthException) {
        // FirebaseAuthException check
        if (e.code == "user-disabled") {
          // User is disabled
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("登入失敗 - 帳戶已被禁用"),
            ),
          );
          return;
        }
        if (e.code == "too-many-requests") {
          // Too many requests
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("登入失敗 - 太多人迫爆咗server"),
            ),
          );
          return;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        // Base handler
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("登入失敗 - 錯誤訊息: $e", overflow: TextOverflow.ellipsis),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Load緊嘅時候出錯！: ${snapshot.error}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          );
        } else if (snapshot.hasData) {
          // logged in
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: Text('已登入'),
                subtitle: Text('多謝${snapshot.data?.displayName}大佬！'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut();
                      } catch (e) {
                        if (mounted) {
                          // ignore: use_build_context_synchronously - mounted check implemented
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('登出帳戶失敗 - 再試吓？')),
                          );
                        }
                      }
                    },
                    child: const Text('登出帳戶'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.currentUser?.delete();
                        await googleSignIn.signOut();
                      } catch (e) {
                        if (mounted) {
                          // ignore: use_build_context_synchronously - mounted check implemented
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('刪除帳戶失敗 - 可以試下重新登入再刪除'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('刪除帳戶'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        } else {
          // Not logged in!!!
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('登入'),
                subtitle: const Text('登入後先至可以睇到同埋回報到機舖狀況'),
              ),
              renderButton(), // NOTE: This is for web
              // ClipRRect( // NOTE: This is for non-web
              //   borderRadius: BorderRadius.circular(8),
              //   child: SignInButton(
              //     Buttons.Google,
              //     onPressed: () async {
              //       await googleSignIn.signIn();
              //     },
              //     text: "使用 Google 登入",
              //   ),
              // ),
              const SizedBox(height: 8),
            ],
          );
        }
      },
    );
  }
}
