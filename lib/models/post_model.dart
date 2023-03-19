import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/firebase.dart';

class PostModel extends Equatable{
  String? id;
  String? postId;
  String? username;
  String? description;
  String? ownerId;
  String? mediaUrl;
  Timestamp? timestamp;
  PostModel({
    this.id,
    this.postId,
    this.ownerId,
    this.description = '',
    this.mediaUrl = '',
    this.username,
    this.timestamp,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    username= json['username'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
  }

  PostModel copyWith(
      {String? id, String? postId,
        String? ownerId,
        String? username, String? description,
        Timestamp? timeStamp}){
    return PostModel(
      id: id??uuid.v4(),
      username: username??'anonymous',
      postId: postId??uuid.v4(),
      ownerId: ownerId??'',
      mediaUrl: mediaUrl??this.mediaUrl,
      description: description??this.description,
      timestamp: timestamp??Timestamp.now(),
    );
  }
  factory PostModel.fromDocument(DocumentSnapshot snapshot){
    return PostModel(
        id: snapshot.data().toString().contains('id') ?snapshot['id']:'',
        username:snapshot.data().toString().contains('username') ? snapshot['username']:'',
        mediaUrl:snapshot.data().toString().contains('mediaUrl') ? snapshot['mediaUrl']:'',
        timestamp:snapshot.data().toString().contains('timestamp') ? snapshot['timestamp']:'',
        description:snapshot.data().toString().contains('description') ? snapshot["description"]:'',
        postId:snapshot.data().toString().contains('postId') ? snapshot["postId"]:'',
        ownerId:snapshot.data().toString().contains('ownerId') ? snapshot['ownerId']:''
    );
  }

  @override
  List<Object?> get props => [
    id,
    postId,
    username,
    description,
    mediaUrl,
    timestamp
  ];

}