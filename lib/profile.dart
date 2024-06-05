import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/homepage.dart';
import 'package:social_media_app/locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});
  final userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override

  // getUserId() async {
  //   final user = await locator<AuthService>().CurrentUser();
  //   userId = user.uid;
  //   print(userId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.all(25.0),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white, size: 30, semanticLabel: 'Back'),
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        title: const Center(child: Text("Profile")),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border_outlined),
            iconSize: 30,
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      body: Center(
          child: FutureBuilder(
        future: locator<FirestoreService>().getUser(widget.userId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
               Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(snapshot.data!['image']),
                ),
              ),
               Text(
                snapshot.data!['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                snapshot.data!['username'],
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFBEBEBE),
                      child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF6F6F6),
                          width: 10,
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFBEBEBE),
                      child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF6F6F6),
                          width: 10,
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFBEBEBE),
                      child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF6F6F6),
                          width: 10,
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFBEBEBE),
                      child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF6F6F6),
                          width: 10,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.message_outlined),
                      label: const Text("Message"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      "Follow",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "6.3k",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 90,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "572",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Posts",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 90,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2.5k",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
              ),
              FutureBuilder(
                future: locator<FirestoreService>().getUserPosts(widget.userId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          
                          children: [
                            SizedBox(
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(snapshot.data[index]['image']),
                              )),
                           ],
                           
                        );
                      },
                    ),
                  );
                },
              )
            ],
          );
        },
      )
      ),
    );
  }
}
