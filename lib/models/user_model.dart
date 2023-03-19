import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? username;
  String? email;
  String? photoUrl;
  String? sect;
  String? bio;
  String? department;
  String? id;
  bool? isVerified;
  String? phoneNumber;
  Timestamp? signedUpAt;
  Timestamp? lastSeen;

  User({
    this.username,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.bio,
    this.id,
    this.lastSeen,
    this.signedUpAt,
    this.sect,
    this.department,
    this.isVerified = false
  });

  User.fromJson(Map<String, dynamic> json){
    username = json['username'];
    email = json['email'];
    department = json['department'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    lastSeen = json['lastSeen'];
    bio = json['bio'];
    id = json['id'];
    isVerified = json['isVerified'];
    photoUrl = json['photoUrl'];
    sect = json['sect'];
  }
  factory User.fromDocument(DocumentSnapshot snapshot){
    return User(
      id: snapshot.data().toString().contains('id') ?snapshot['id']:'',
      email:snapshot.data().toString().contains('email') ? snapshot['email']:'',
      username:snapshot.data().toString().contains('username') ? snapshot['username']:'',
      department:snapshot.data().toString().contains('department') ? snapshot['department']:'',
      phoneNumber:snapshot.data().toString().contains('phoneNumber') ? snapshot['phoneNumber']:'',
      photoUrl:snapshot.data().toString().contains('photoUrl') ? snapshot["photoUrl"]:'',
      sect:snapshot.data().toString().contains('sect') ? snapshot["sect"]:'',
      lastSeen:snapshot.data().toString().contains('lastSeen') ? Timestamp.now():Timestamp.now(),
      signedUpAt:snapshot.data().toString().contains('signedUpAt') ? snapshot['signedUpAt']:Timestamp.now(),
      bio:snapshot.data().toString().contains('bio') ? snapshot['bio']:'',
      isVerified:snapshot.data().toString().contains('isVerified')? snapshot['isVerified']:false
    );
  }
}