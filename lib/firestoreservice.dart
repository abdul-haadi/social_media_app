import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  getPosts() async {
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final data = snapshot.docs.map((e) => {...e.data(), "id": e.id}).toList();
    return data;
  }

  getUserPosts(userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('created_by', isEqualTo: userId)
        .get();
    final data = snapshot.docs.map((e) => {...e.data(), "id": e.id}).toList();
    log(userId);
    return data;
  }

  getUser(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.data();
  }

  likePosts(postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference postRef =
        FirebaseFirestore.instance.collection('posts');

    await postRef.doc(postId).update({
      "likes_count": FieldValue.increment(1),
    });
    log('liked');

    await postRef.doc(postId).collection('likes').doc(userId).set({
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  dislikePosts(postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference postRef =
        FirebaseFirestore.instance.collection('posts');

    await postRef.doc(postId).update({
      "likes_count": FieldValue.increment(-1),
    });
    log('disliked');
    await postRef.doc(postId).collection('likes').doc(userId).delete();
  }

  checkIfLiked(postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userId)
        .get();
    return snapshot.exists;
  }

  getLikedUsers(postId) async {
    if (postId == null) {
      throw ArgumentError('postId cannot be null');
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get();
    final data = snapshot.docs.map((e) => e.id).toList();
    final List<Map<String, dynamic>> userdata = [];
    for (var i = 0; i < data.length; i++) {
      final user = await getUser(data[i]);
      userdata.add(user);
    }

    print(userdata);
    return userdata;
  }

  addComment(String postId, String comment) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference postRef =
        FirebaseFirestore.instance.collection('posts');

    await postRef.doc(postId).update({
      "comment_count": FieldValue.increment(1),
    });

    await postRef.doc(postId).collection('comments').doc().set({
      "comment": comment,
      "timestamp": FieldValue.serverTimestamp(),
      "user_id": userId,
    });
  }

  getComments(String postId) async {
    final snapshot = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    final data = await snapshot
        .then((value) => value.docs.map((e) => {...e.data(), 'id': e.id}).toList());
    print("this is data" + data.toString());

    final List<Map<String, dynamic>> userdata = [];

    for (var i = 0; i < data.length; i++) {
      final user = await getUser(data[i]['user_id'].toString());
      userdata.add({...user, ...data[i]});
    }
      print(userdata);
    return userdata;
  }

  deleteComment(String postId, String commentId) async {
    CollectionReference postRef =
        FirebaseFirestore.instance.collection('posts');

    await postRef.doc(postId).update({
      "comment_count": FieldValue.increment(-1),
    });
   await postRef
        .doc(postId)
        .collection('comments').doc(commentId)
        .delete();
        
        print("Deleted Comment");
  }
}
