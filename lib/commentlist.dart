import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/locator.dart';

class CommentList extends StatefulWidget {
  CommentList({super.key, required this.postId,required this.onCommentAdd, required this.onCommentDelete});
  final String postId;
  final Function onCommentAdd;
  final Function onCommentDelete;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final comment = TextEditingController();

  List<Map<String, dynamic>> comments = [];


  _getComment() async {
    comments = await locator<FirestoreService>().getComments(widget.postId);
    setState(() {

    });
    print(comments.toString());
  }

  @override
  void initState() {
    super.initState();
    _getComment();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          TextField(
            controller: comment,
            decoration: const InputDecoration(
              hintText: "Add a comment",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 260.0),
            child: ElevatedButton(
              onPressed: () async {
               
                widget.onCommentAdd();
                log(comments.toString());
                await locator<FirestoreService>()
                    .addComment(widget.postId, comment.text);
                _getComment();
                comment.clear();
              },
              child: const Text("Comment"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final com = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(com['image']),
                  ),
                  title: Text(com['username']),
                  subtitle: Text(com['comment']),
                  trailing: IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Comment'),
                            content: const Text('Are you sure?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  widget.onCommentDelete();
                                  await locator<FirestoreService>().deleteComment(
                                      widget.postId, com['id'].toString());
                                  _getComment();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                      // widget.onCommentDelete();
                      // print("This is comment Id" + com.toString());
                      // await locator<FirestoreService>().deleteComment(
                      //     widget.postId, com['id'].toString());
                      // _getComment();
                    },
                    icon: const Icon(Icons.delete),
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
