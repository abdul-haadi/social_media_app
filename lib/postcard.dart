import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/commentlist.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/locator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/profile.dart';
import 'package:social_media_app/showpost.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.user_id,
      required this.postId,
      required this.likes_Count,
      required this.comment_Count,
      required this.getData});
  final String title;
  final String description;
  final String image;
  final String user_id;
  final String postId;
  final int likes_Count;
  final int comment_Count;
  final Function() getData;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isFollowing = false;
  bool _isFavorite = false;
  int _favoriteCount = 0;
  int commentCount = 0;
  int followers_count = 0;
  int following_count = 0;

  isFollowerCheck() async {
    await locator<FirestoreService>()
        .checkIfFollowing(widget.user_id)
        .then((value) {
      setState(() {
        _isFollowing = value;
      });
    });
  }

  getLikeCount() async {
    setState(() {
      _favoriteCount = widget.likes_Count;
    });

    await locator<FirestoreService>()
        .checkIfLiked(widget.postId)
        .then((value) => _isFavorite = value);

    // final List likedUsers = await locator<FirestoreService>().getLikedUsers(widget.postId);

    // likedUsers.map((e) => e['email']).contains(FirebaseAuth.instance.currentUser!.email) ? _isFavorite = true : _isFavorite = false;

    // log((await locator<FirestoreService>().getLikedUsers(widget.postId)).toString());
    setState(() {
      _favoriteCount = widget.likes_Count;
    });
  }

  getCommentCount() {
    setState(() {
      commentCount = widget.comment_Count;
    });
  }

  List<Map<String, dynamic>> follows = [];

  @override
  void initState() {
    super.initState();
    isFollowerCheck();
    getLikeCount();
    getCommentCount();
  }

  @override
  Widget build(BuildContext context) {
    // log(currentUserId +" " + widget.user_id);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: <Widget>[
          Row(children: [
            FutureBuilder(
              future: locator<FirestoreService>().getUser(widget.user_id),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                    userId: widget.user_id,
                                  )));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!['image']),
                      radius: 25,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  FutureBuilder(
                    future: locator<FirestoreService>().getUser(widget.user_id),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          userId: widget.user_id,
                                        )));
                          },
                          child: Text(
                            snapshot.data!['username'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: 100,
                          height: 20,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const Text(
                "2 hours ago",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ]),
            const Expanded(child: SizedBox()),
            widget.user_id == FirebaseAuth.instance.currentUser!.uid
                ? Text("")
                : ElevatedButton(
                    onPressed: () {
                      if (!_isFollowing) {
                        setState(() {
                          _isFollowing = true;
                          followers_count++;
                        });
                        locator<FirestoreService>().followUser(widget.user_id);
                      } else {
                        setState(() {
                          _isFollowing = false;
                          followers_count--;
                        });
                        locator<FirestoreService>()
                            .unFollowUser(widget.user_id);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isFollowing ? Colors.white : Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      _isFollowing ? "Following" : "Follow",
                      style: _isFollowing
                          ? const TextStyle(color: Colors.black)
                          : const TextStyle(color: Colors.white),
                    ),
                  )
          ]),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowPost(
                          postId: widget.postId,
                          userId: widget.user_id,
                          getData: widget.getData,
                          commentCount: widget.comment_Count,
                          likeCount: widget.likes_Count)));
            },
            child: SizedBox(
                width: 320,
                height: 271,
                child: Image.network(widget.image, fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
              const Text("36",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () async {
                  if (!_isFavorite) {
                    await locator<FirestoreService>().likePosts(widget.postId);
                    setState(() {
                      _favoriteCount++;
                      _isFavorite = true;
                      widget.getData();
                    });
                  } else {
                    await locator<FirestoreService>()
                        .dislikePosts(widget.postId);
                    setState(() {
                      _favoriteCount--;
                      _isFavorite = false;
                      widget.getData();
                    });
                  }
                },
                icon: _isFavorite
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: locator<FirestoreService>()
                                    .getLikedUsers(widget.postId),
                                builder: (context, AsyncSnapshot snapshot) {
                                  log(snapshot.data.toString());
                                  if (snapshot.hasData) {
                                    return ListView(
                                        shrinkWrap: true,
                                        children: snapshot.data
                                            .map<Widget>((e) => ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            e['image']),
                                                  ),
                                                  title: Text(e['username']),
                                                ))
                                            .toList());
                                  } else {
                                    return SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text(_favoriteCount.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Row(
                    children: [
                      const Icon(Icons.comment),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(commentCount.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CommentList(
                              onCommentAdd: () {
                                setState(() {
                                  commentCount++;
                                  widget.getData();
                                });
                              },
                              onCommentDelete: () {
                                setState(() {
                                  commentCount--;
                                  widget.getData();
                                });
                              },
                              postId: widget.postId);
                        });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
