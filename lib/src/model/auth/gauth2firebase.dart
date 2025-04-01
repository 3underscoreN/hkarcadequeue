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
