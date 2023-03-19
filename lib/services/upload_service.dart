import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

import '../utils/amunet_utils.dart';
import '../utils/firebase.dart';
import '../models/user_model.dart' as user_model;


class UploadService{
  Future<user_model.User> fetchUserInfo()async{
    var snapshot = await usersRef.doc(currentUserId()).get();
    user_model.User user = user_model.User.fromDocument(snapshot);
    return user;
  }

  Future<String> uploadImage({required Reference ref,File? file,Uint8List? webImage})async{
    Reference storageReference;
    if(kIsWeb){
      final imgName = lookupMimeType('', headerBytes: webImage);
      storageReference = ref.child("${uuid.v4()}.$imgName");
      UploadTask uploadTask = storageReference.putData(webImage!,);
      await uploadTask.whenComplete(() => null);
    }else{
      String ext = FenoteAbewUtils.getFileExtension(file!);
      storageReference = ref.child("${uuid.v4()}.$ext");
      UploadTask uploadTask = storageReference.putFile(file,SettableMetadata(contentType: 'image/$file.$ext'),);
      await uploadTask.whenComplete(() => null);
    }
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }

  updateProfile({
    File? image,
    Uint8List? webImage,
    String? username,
    String? imageUrl,
    String? bio,
    String? department,
    String? phoneNumber,
    String? christianName,
  }) async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    user_model.User users;
    if(doc.exists){
      users = user_model.User.fromDocument(doc);
      users.username = username;
      users.bio = bio;
      users.phoneNumber = phoneNumber ?? '';
      users.department = department;
      users.sect = christianName;
      if(!kIsWeb){
        if (image != null && imageUrl == null) users.photoUrl = await uploadImage(ref:profilePic, file: image);
      }else{
        if (webImage != null && imageUrl==null) users.photoUrl = await uploadImage(ref:profilePic, webImage: webImage);
      }
      await usersRef.doc(currentUserId()).update({
        'username': username,
        'bio': bio,
        'department': department,
        "photoUrl": users.photoUrl ?? '',
        'phoneNumber':users.phoneNumber,
        'christianName':users.sect
      });
    }else{
      users = user_model.User(
          username: "",
          department: "",
          phoneNumber: "",
          sect: "",
          bio: "",
          email: "",
          photoUrl:""
      );
      final User? user = FirebaseAuth.instance.currentUser;
      users.username = username;
      users.bio = bio;
      users.phoneNumber = phoneNumber;
      users.department = department;
      users.sect = christianName;
      users.photoUrl = user!.photoURL ?? '';
      if(!kIsWeb){
        if (image != null && imageUrl == null) users.photoUrl = await uploadImage(ref:profilePic, file: image);
      }else{
        print(webImage.toString());
        if (webImage != null && imageUrl==null) users.photoUrl = await uploadImage(ref:profilePic, webImage: webImage);
      }
      await usersRef.doc(firebaseAuth.currentUser!.uid).set(
          {
            "id": firebaseAuth.currentUser!.uid,
            "username": users.username,
            "email": user.email,
            "department": users.department,
            "photoUrl": users.photoUrl??'',
            "signedUpAt": DateTime.now(),
            "lastSeen": DateTime.now(),
            "bio": users.bio,
            "christianName": users.sect,
            "phoneNumber": users.phoneNumber,
          }
      );
    }
    return true;
  }


}