import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

final Uuid uuid = Uuid();

final  usersRef = fireStore.collection('users');
final  postRef = fireStore.collection('posts');
final  eventsRef = fireStore.collection('events');
final  bookRef = fireStore.collection('books');

Reference profilePic =storage.ref().child('profilePic');
Reference postsRef =storage.ref().child('posts');
Reference bookCoverRef =storage.ref().child('books');

currentUserId() {
  return firebaseAuth.currentUser!.uid;
}