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

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

/// This function is used to sign in to Firebase as user signs in with Google.
/// It is designed to be used with a listener on the GoogleSignIn instance.
/// If the user cannot be signed in, an [Exception] will be thrown.
/// More details about the exception can be checked at the [signInWithCredential] method.
Future<void> google2firebase(GoogleSignInAccount? account) async {
  if (account != null) {
    // User is signed in
    GoogleSignInAuthentication googleAuth = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    await FirebaseAuth.instance.signOut();
  }
}
