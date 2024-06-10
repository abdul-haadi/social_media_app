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
  bool _isFollowing = false;
  int following_count = 0;
  int followers_count = 0;
  var currentUserId;
  int post_count = 0;

  getPostCount() async {
    post_count =
        await locator<FirestoreService>().getUserPostsCount(widget.userId);
    setState(() {});
  }

  Map<String, dynamic> profileData = {};
  List<Map<String, dynamic>> userPosts = [];

  Future<void> getProfileData() async {
    profileData = await locator<FirestoreService>().getUser(widget.userId);
    setState(() {});
    log(profileData.toString());
    await locator<FirestoreService>()
        .checkIfFollowing(widget.userId)
        .then((value) {
      setState(() {
        _isFollowing = value;
      });
    });
  }

  Future<void> getUserPosts() async {
    userPosts = await locator<FirestoreService>().getUserPosts(widget.userId);
    setState(() {});
    log("Post data " + userPosts.toString());
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
    getUserPosts();
    getUserId();
    getPostCount();
  }

  getUserId() async {
    final user = await locator<AuthService>().CurrentUser();
    setState(() {
      currentUserId = user.uid;
    });
    print(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    print(currentUserId);
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
          child: Container(
        child: profileData.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
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
                          backgroundImage: NetworkImage(profileData['image']),
                        ),
                      ),
                      Text(
                        profileData['name'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        profileData['username'],
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
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
                          currentUserId == widget.userId
                              ? const Text("")
                              : ElevatedButton(
                                  onPressed: () {
                                    if (!_isFollowing) {
                                      setState(() {
                                        _isFollowing = true;
                                        followers_count++;
                                        profileData['followers_count'] =
                                            followers_count;
                                        profileData['following_count'] =
                                            following_count;
                                      });
                                      locator<FirestoreService>()
                                          .followUser(widget.userId);
                                          
                                    } else {
                                      setState(() {
                                        _isFollowing = false;
                                        followers_count--;
                                        profileData['followers_count'] =
                                            followers_count;
                                        profileData['following_count'] =
                                            following_count;
                                      });
                                      locator<FirestoreService>()
                                          .unFollowUser(widget.userId);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: _isFollowing
                                          ? Colors.white
                                          : Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text(
                                    _isFollowing ? "Following" : "Follow",
                                    style: _isFollowing
                                        ? const TextStyle(color: Colors.black)
                                        : const TextStyle(color: Colors.white),
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
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isFollowing
                                    ? Text(
                                        profileData['followers_count']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        profileData['followers_count']
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                const Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
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
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  post_count.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
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
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileData['following_count'].toString() ??
                                      '0',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
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
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: userPosts.length,
                          itemBuilder: (context, index) {
                            final post = userPosts[index];
                            return Column(
                              children: [
                                SizedBox(
                                    height: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        post['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
      )),
    );
  }
}
