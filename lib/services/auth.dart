import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//SIGN IN FUNCTION

Future<User?> signInWithGoogle() async {
  //SIgn with Google
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  // Creating Credential for Firebase
  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  // SignIn with Credential and Getting User
  final userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  // Checking is on
  assert(user!.isAnonymous);
  assert(await user!.getIdToken() != null);

  final User? currentUser = await _auth.currentUser;

  assert(currentUser!.uid == user!.uid);


  print(user);

  return user;
}
