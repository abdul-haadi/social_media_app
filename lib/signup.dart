import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/authservice.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/homepage.dart';
import 'package:social_media_app/locator.dart';
import 'package:social_media_app/login.dart';
import 'package:path/path.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final collectionRef = FirebaseFirestore.instance.collection("users");
  FirebaseStorage storage = FirebaseStorage.instance;

  // final _auth = AuthService();
  File? selectedImage;
  bool clicked = false;

  Future<void> createUser(
      {required String name,
      required String username,
      required String email,
      required String imageUrl}) async {
    try {
      await collectionRef.add({
        "name": name,
        "username": username,
        "email": email,
        "image": imageUrl
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Future<String?> uploadFile() async {
    if (selectedImage == null) return null;
    final fileName = basename(selectedImage!.path);
    final destination = 'files/$fileName';
    print(fileName);

    try {
      final ref = storage.ref(destination);
      final uploadTask = await ref.putFile(selectedImage!);
      log(uploadTask.toString());
      log('File Uploaded');
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('error occured');
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Sign Up",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                const Text("Let's set up your account!!",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal)),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  clicked = !clicked;
                                });
                              },
                              child: const Icon(Icons.add_a_photo)),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: clicked
                                  ? [
                                      ElevatedButton(
                                          onPressed: getImageFromCamera,
                                          child:
                                              const Icon(Icons.camera_alt)),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                          onPressed: getImageFromGallery,
                                          child:
                                              const Icon(Icons.image_search))
                                    ]
                                  : [],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _name,
                            validator: (value) => value!.isEmpty
                                ? "Please enter your name"
                                : null,
                            decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your name",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _username,
                            validator: (value) => value!.isEmpty
                                ? "Please enter your username"
                                : null,
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your Username",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) => value!.isEmpty
                                ? "Please enter your email"
                                : null,
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your Email",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 6) {
                                return "Password must be atleast 6 characters";
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.grey),
                              hintText: "Enter your Password",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  print("Validate");
                                }
                                _signup(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account? "),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ]),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signup(BuildContext context) async {
    final user = await locator<AuthService>()
        .createUserWithEmailAndPassword(_email.text, _password.text)
        .then((value) async {
      if (value != null) {
        final imageUrl = await uploadFile();
        createUser(
            name: _name.text,
            username: _username.text,
            email: _email.text,
            imageUrl: imageUrl!);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }
}
