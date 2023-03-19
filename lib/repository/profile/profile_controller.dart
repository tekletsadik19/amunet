import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/profile/edit_profile_state.dart';
import '../../models/user_model.dart' as user_model;
import '../../services/upload_service.dart';

class EditProfileController extends StateNotifier<EditProfileState>{
  EditProfileController({required this.user}):super( EditProfileState.data(user));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UploadService service = UploadService();
  bool isImagePicked = false;
  File? imageFile;
  Uint8List webImage = Uint8List(8);
  final user_model.User user;
  bool isLoading = false;
  bool validate = false;
  String? department;
  String? username;
  String? bio;
  String? christianName;


  setDepartment(String val) {
    department = val;
  }

  setBio(String val) {
    bio = val;
  }

  setUsername(String val) {
    username = val;
  }
  setChristianName(String val) {
    christianName = val;
  }

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
    try{
      state = const EditProfileState.loading();
      final ImagePicker _picker = ImagePicker();
      XFile? pickedImage = await _picker.pickImage(
          source: source,
          maxWidth: 650,
          maxHeight: 920
      );
      if(!kIsWeb){
        if (pickedImage == null) return;
        isImagePicked = true;
        imageFile = File(pickedImage.path);
        imageFile = await customCompressImage(imagePathToCompress: imageFile!);
        state = EditProfileState.data(isImagePicked);
        isLoading = false;
      }else{
        if (pickedImage == null) return;
        isImagePicked = true;
        webImage = await pickedImage.readAsBytes();
        state = EditProfileState.data(isImagePicked);
        isLoading = false;
      }
    }catch(e,stx){
      state = EditProfileState.error(e,stx);
    }
  }

  setProfileImage(ImageSource source) async {
    try {
      isLoading = true;
      await handleTakePhoto(source);
    } catch (e) {
      print(e.toString());
    }
  }

  editProfile(BuildContext context,user_model.User user) async {
    final _isValid = formKey.currentState!.validate();
    if(!_isValid){
      return;
    }
    formKey.currentState!.save();
    try {
      isLoading = true;
      state = EditProfileState.data(isLoading);
      bool success = kIsWeb
          ? await service.updateProfile(
            imageUrl: isImagePicked?null:user.photoUrl,
            webImage: webImage,
            username: username,
            bio: bio,
            department: department,
            christianName: christianName
          )
          : await service.updateProfile(
            imageUrl: isImagePicked?null:user.photoUrl,
            image: imageFile,
            username: username,
            bio: bio,
            department: department,
            christianName: christianName
          );
      if (success) {
        clear();
        Navigator.pop(context);
      }
    } catch (e) {
      isLoading = false;
      state = EditProfileState.data(isLoading);
    }
    isLoading = false;
    state = EditProfileState.data(isLoading);
  }

  clear() {
    imageFile = null;
  }

  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}