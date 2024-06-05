import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final title = TextEditingController();
  final description = TextEditingController();

  final collectionref = FirebaseFirestore.instance.collection('posts');
  FirebaseStorage storage = FirebaseStorage.instance;

  File? postImage;


  Future<void> uploadPost() async {
    try {
      final ref = storage.ref().child('posts/${DateTime.now()}');
      await ref.putFile(postImage!);
      final url = await ref.getDownloadURL();
      await collectionref.add({
        'title': title.text,
        'description': description.text,
        'image': url,
        'timestamp': FieldValue.serverTimestamp(),
        'created_by': FirebaseAuth.instance.currentUser!.uid,
        'likes_count': 0,
        'comment_count': 0,
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      postImage = File(image!.path);
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      postImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(0, 0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text("Create Post",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                _posted();
              },
              icon: const Icon(
                Icons.send,
                size: 30,
              ),
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                maxLines: 5,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 30),
                    onPressed: () {
                      getImageFromCamera();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.image, size: 30),
                    onPressed: () {
                      getImageFromGallery();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.video_collection, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            if (postImage != null)
              SizedBox(
                child: postImage == null
                    ? const Center(child: Text("No Image"))
                    : Image.file(postImage!),
              )
          ],
        ),
      ),
    );
  }
  _posted(){
    uploadPost();
    Navigator.pop(context);
  }
}
