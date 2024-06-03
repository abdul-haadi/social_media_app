import 'package:cloud_firestore/cloud_firestore.dart';
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

  getPosts() async {
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final data = snapshot.docs.map((e) => e.data()).toList();
    return data;
  }

  getUser(String uid) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.data();
  }

  
  //  followUser(String uid) async {
  //   final user = _auth.currentUser;
  //   final following = FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('following');
  //   final followers = FirebaseFirestore.instance.collection('users').doc(uid).collection('followers');
  //   final followingData = await following.doc(uid).get();
  //   final followersData = await followers.doc(user.uid).get();
  //   if(followingData.exists && followersData.exists) {
  //     await following.doc(uid).delete();
  //     await followers.doc(user.uid).delete();
  //     return false;
  //   } else {
  //     await following.doc(uid).set({});
  //     await followers.doc(user.uid).set({});
  //     return true;
  //   }
  //  }
}