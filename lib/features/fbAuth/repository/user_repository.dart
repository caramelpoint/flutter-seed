// Imports
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  // Constructor
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn, FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  // SignInWithGoogle
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential =
        GoogleAuthProvider.getCredential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await _firebaseAuth.signInWithCredential(credential);
    print("AuthResult");
    return _firebaseAuth.currentUser();
  }

  // SignInWithFacebook
  Future<FirebaseUser> signInWithFacebook() async {
    // final result = await _facebookLogin.logIn(['email']);
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      print('LogIn');
      final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      print("ALMOST IN");
      try {
        AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
      } catch (e) {
        //https://stackoverflow.com/questions/44015751/firebase-js-api-auth-account-exists-with-different-credential
        print(e);
      }
      print("AuthResult");
      // print(authResult.user);
      print("SIGNED IN");
      return _firebaseAuth.currentUser();
    }
    return null;
  }

  // SignInWithCredentials
  Future<String> signInWithCredentials(String email, String password) async {
    try {

    final AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    if (authResult.user.isEmailVerified) return authResult.user.uid;
    } catch (e) {
      print(e.message);
    }
    return null;
  }

  // SignUp - Registro
  Future<void> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    try {
      await authResult.user.sendEmailVerification();
      print(authResult.user.uid);
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }
  }

  // SignOut
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut(), _facebookLogin.logOut()]);
  }

  // Esta logueado?
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  // Obtener usuario
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
