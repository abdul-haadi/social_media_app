import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/commentlist.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/locator.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({
    super.key,
    required this.postId,
    required this.userId,
    required this.getData,
    required this.commentCount,
    required this.likeCount,
  });
  final String postId;
  final String userId;
  final Function() getData;
  final int commentCount;
  final int likeCount;

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  bool _isFavorite = false;
  int _favoriteCount = 0;
  int _commentCount = 0;

  checkLiked() async {
    await locator<FirestoreService>()
        .checkIfLiked(widget.postId)
        .then((value) => _isFavorite = value);
    _favoriteCount = widget.likeCount;
    _commentCount = widget.commentCount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLiked();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FutureBuilder(
              future: locator<FirestoreService>().getPost(widget.postId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Column(
                  children: [
                    Stack(
                      children: [
                        snapshot.data['image'] != null
                            ? Image.network(snapshot.data['image'])
                            : const CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 500,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 450,
                                  bottom: 0,
                                  left: 250,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          if (!_isFavorite) {
                                            await locator<FirestoreService>()
                                                .likePosts(widget.postId);
                                            setState(() {
                                              _isFavorite = true;
                                              widget.getData();
                                              _favoriteCount++;
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
                                            ? const Icon(Icons.favorite,
                                                color: Colors.red)
                                            : const Icon(Icons.favorite_border),
                                      ),
                                      Text(_favoriteCount.toString()),
                                      IconButton(
                                        icon: Icon(Icons.comment),
                                        onPressed: () {},
                                      ),
                                      Text(_commentCount.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommentList(
                      postId: widget.postId,
                      onCommentAdd: () {
                        widget.getData();
                      },
                      onCommentDelete: () {
                        widget.getData();
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
