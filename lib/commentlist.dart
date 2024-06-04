import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:social_media_app/firestoreservice.dart';
import 'package:social_media_app/locator.dart';

class CommentList extends StatefulWidget {
  CommentList({super.key, required this.postId,required this.onCommentAdd});
  final String postId;
  final Function onCommentAdd;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final comment = TextEditingController();

  List<Map<String, dynamic>> comments = [];


  _getComment() async {
    comments = await locator<FirestoreService>().getComments(widget.postId);
    setState(() {});
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
