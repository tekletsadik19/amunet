import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../widgets/timeline_post.dart';



class PostsListView extends StatelessWidget {
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets padding;
  final Query? query;
  final List<PostModel> posts;

  const PostsListView({
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.query,
    this.physics = const ClampingScrollPhysics(),
    this.padding = const EdgeInsets.only(bottom: 2.0, left: 2.0),
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? const Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: SizedBox(
        height: 60.0,
        width: 100.0,
        child: Center(
          child: Text('No Posts'),
        ),
      ),
    )
        : ListView.builder(
      padding: padding,
      scrollDirection: scrollDirection,
      itemCount: posts.length,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: TimelinePostView(post:posts[index],));
      },
    );
  }
}
