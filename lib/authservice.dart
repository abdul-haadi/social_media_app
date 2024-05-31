import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // isloggedin() {
  //   if (_auth.currentUser != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> logout() async {
    try{
    await _auth.signOut();
    }
    catch(e){
      print(e);
    }
  }
}
