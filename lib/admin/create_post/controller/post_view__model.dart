import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../models/user_model.dart' as user_model;
import '../../../utils/firebase.dart';
import '../../../models/post_model.dart';

final postViewProvider = StateNotifierProvider.autoDispose(
    (ref){
      return PostViewModel();
    }
);

final getUserPostStream = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>(
        (ref) => postRef.where('ownerId',isEqualTo: firebaseAuth.currentUser!.uid).snapshots()
);

class PostViewModel extends StateNotifier<PostModel>{
  PostViewModel():super( PostModel());
  String postId = Uuid().v4();
  File? imageFile;
  String? description;
  double? sizeInKbBefore;
  double? sizeInKbAfter;
  bool isUploading = false;


  Future<File> customCompressImage({
    required File imagePathToCompress,
    quality = 100,
    percentage = 10
  })async{
    var path = await FlutterNativeImage.compressImage(
        imagePathToCompress.absolute.path,
        quality: 100,
        percentage: 80
    );
    return path;
  }

  handleTakePhoto(source)async{
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 650,
        maxHeight: 920
    );
    imageFile = File(pickedFile!.path);
    sizeInKbBefore = imageFile!.lengthSync()/1024;
    print('before compressed $sizeInKbBefore');
    imageFile = await customCompressImage(imagePathToCompress: imageFile!);
    sizeInKbAfter = imageFile!.lengthSync()/1024;
    print('after being compressed $sizeInKbAfter');
  }


  createPostInFireStore({String? mediaUrl,String? description})async{
    isUploading = true;
    user_model.User user = await fetchUserInfo();
    await postRef.doc(postId).set({
      'postId':postId,
      'ownerId':user.id,
      'username':user.username,
      'mediaUrl':mediaUrl,
      'description':description,
      'timestamp':Timestamp.now(),
      'likes':{}
    });
    isUploading = false;
    imageFile = null;
  }

  resetPost(){

  }

  setDescription(String val) {
    description = val;
  }

  deletePost(String? postId,String ? mediaUrl) async {
    isUploading = true;
    try{
      await postRef.doc(postId).delete();
      await postsRef.child(mediaUrl!).delete();
    }catch(error){
      print(error.toString());
      isUploading = false;
    }
    isUploading = false;
  }

  Future<user_model.User> fetchUserInfo()async{
    var snapshot = await usersRef.doc(currentUserId()).get();
    user_model.User user = user_model.User.fromDocument(snapshot);
    return user;
  }
}