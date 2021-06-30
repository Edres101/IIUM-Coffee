import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign/models/user.dart';
import 'package:sign/pages/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebase

  UserId _userFromFirebaseUser(User user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<UserId> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sing in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User user = result.user;

      //create a new document for the user with the uid

      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new customer', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
