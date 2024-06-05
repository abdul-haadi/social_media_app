import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/createpost.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/locator.dart';
import 'package:social_media_app/login.dart';
import 'package:social_media_app/postcard.dart';
import 'package:social_media_app/profile.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  
  @override

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> posts = [];
  @override
  void initState() {
    super.initState();
    getPost();
  }
  getPost() async{
    posts = await locator<FirestoreService>().getPosts();
    setState(() {

    });
    log(posts.toString());
  }
 var userId;

  getUserId() async {
    final user = await locator<AuthService>().CurrentUser();
    userId = user.uid;
    print(userId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 100,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePost()));
          },
          icon: const Icon(Icons.photo_camera_outlined, size: 30,),
        ),
        bottom: const PreferredSize(preferredSize: Size(0, 0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text("Timeline", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(onPressed:() {
              
            },icon: const Icon(Icons.search, size: 30,), color: Colors.black,),
            
          ),
          IconButton(onPressed: (){
            getUserId();
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId:userId)));

          }, icon: const Icon(Icons.person), color: Colors.black, iconSize: 30,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Create Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
            
          ),
          
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePost()));
          }
          if (index == 2) {
            _signOut(context);
          }
        },
        
      ),
      body: Center(
        child: ListView.builder(
          cacheExtent: 500,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    getData: (){
                      getPost();
                    },
                    
                    postId: post['id'],
                    description: post['description'],
                    title: post['title'],
                    image: post['image'],
                    user_id: post['created_by'],
                    likes_Count: post['likes_count'], 
                    comment_Count: post['comment_count']??0,
                  );
                },
              )));
            }
  }
  void _signOut(BuildContext context) {
    locator<AuthService>().logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }