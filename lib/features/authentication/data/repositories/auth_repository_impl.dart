import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/authentication/data/repositories/failures.dart';
import 'package:caramelseed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  AuthRepositoryImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._facebookLogin,
  );

  @override
  Future<Either<Failure, FirebaseUser>> getuser() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser == null) {
        return Left(EmptyCurrentUserFailure());
      }
      return Right(firebaseUser);
    } catch (e) {
      return Left(GettingCurrentUserFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser == null) {
        return Left(EmptyCurrentUserFailure());
      }
      return const Right(true);
    } catch (e) {
      return Left(GettingCurrentUserFailure()); 
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> signInWithCredentials(Params params) async {
    try {
      final AuthResult authResult =
          await _firebaseAuth.signInWithEmailAndPassword(email: params.email, password: params.password);
      if (!authResult.user.isEmailVerified) {
        return Left(NoVerifiedUserFailure());
      }
      return Right(authResult.user);
    } catch (e) {
      return Left(UnexpectedSignInFailure()); 
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> signInWithFacebook() async {
    try {
      final result = await _facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
        await _firebaseAuth.signInWithCredential(credential);
        final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
        if (firebaseUser != null) {
          Right(firebaseUser);
        }
      }
      return Left(SignInFailure());
    } catch (e) {
      //https://stackoverflow.com/questions/44015751/firebase-js-api-auth-account-exists-with-different-credential
      return Left(UnexpectedSignInFailure()); 
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential =
          GoogleAuthProvider.getCredential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser != null) {
        Right(firebaseUser);
      }
      return Left(SignInFailure());
    } catch (e) {
      return Left(UnexpectedSignInFailure()); 
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut(), _facebookLogin.logOut()]);
      final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
      if (firebaseUser != null) {
        return Left(SignOutFailure());
      }
      return const Right(true);
    } catch (e) {
      return Left(UnexpectedSignOutFailure()); 
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> signup(Params params) async {
    try {
      final AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: params.email, password: params.password);
      await authResult.user.sendEmailVerification();
      if (authResult.user == null){
        return Left(SignUpFailure());
      }
      return Right(authResult.user);
    } catch (e) {
      return Left(UnexpectedSignUpFailure());
    }
  }
}
