import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../authentication_repository.dart';

class SignupWithEmailAndPasswordFailure implements Exception{
  final String code;
  const SignupWithEmailAndPasswordFailure(this.code);
}
class SigninWithEmailAndPasswordFailure implements Exception{
  final String code;
  const SigninWithEmailAndPasswordFailure(this.code);
}
class ForgotPasswordFailure implements Exception{
  final String code;
  const ForgotPasswordFailure(this.code);
}
class SignupWithGoogleFailure implements Exception{
  final String code;
  const SignupWithGoogleFailure(this.code);
}
class SigninWithGoogleFailure implements Exception{
  final String code;
  const SigninWithGoogleFailure(this.code);
}
class SignOutFailure implements Exception{
  final String code;
  const SignOutFailure(this.code);
}

class AuthenticationRepository{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: "1091898634193-3orjrcvutqc14j0d1sipdlonrenchpch.apps.googleusercontent.com"
  );
  Stream<AuthUser> get user{
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      return firebaseUser == null ?AuthUser.empty:AuthUser(
          id: firebaseUser.uid,
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          isEmailVerified: firebaseUser.emailVerified
      );
    });
  }

  Future<String> signupWithEmailAndPassword({
    required String email,
    required String password
  })async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch(error){
      throw SignupWithEmailAndPasswordFailure(error.code);
    }
  }
  Future<String> signinWithEmailAndPassword({
    required String email,
    required String password
  })async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch(error){
      throw SigninWithEmailAndPasswordFailure(error.code);
    }
  }

  Future<void> forgotPassword({
    required String email
  })async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(error){
      throw ForgotPasswordFailure(error.code);
    }
  }
  Future<void> signOut()async{
    try{
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut()
      ]);
    } on FirebaseAuthException catch(error){
      throw ForgotPasswordFailure(error.code);
    }
  }

  Future<String?> signInWithGoogle()async{
    try{
      final googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount == null){
        throw SigninWithGoogleFailure('');
      }
      final googleSignInAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken
      );
      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user!.uid;

    }on FirebaseAuthException catch(error){
      throw SigninWithGoogleFailure(error.code);
    }
  }

}