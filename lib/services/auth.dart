import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUSer => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


  //LOGIN Email

  Future<void>loginwithEmailAndPassword(String email, String password) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  //Logout

  Future<void> logout()async{
    await _firebaseAuth.signOut();
  }

  //new user creation

  Future<void> createUserWithEmailAndPassword(String email, String password) async{

    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }




}