

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepository{
  Future<UserCredential> login(String email, String password){
     return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signup(String email, String password){
     return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }
  User? getLoggedInUser(){
    return FirebaseAuth.instance.currentUser;
  }
  Future<void> resetPassword(String email){
     return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  bool isEmailVerified(){
    User? user=getLoggedInUser();
    if (user==null) return false;
    return user.emailVerified;
  }
  Future<void> sendVerificationEmail(){
    User? user=getLoggedInUser();
    if (user==null) return Future.value();
    return user.sendEmailVerification();
  }
  Future<void> changeName (String name)
  {
    User? user=getLoggedInUser();
    if(user==null) return Future.value();
    return user.updateDisplayName(name);
  }
  void logout()
  {
    FirebaseAuth.instance.signOut();
  }

}

