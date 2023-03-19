import 'dart:async';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/upload_service.dart';
import '../../../models/user_model.dart' as user_model;
import '../../../services/upload_service.dart';
import 'finish_setting_profile_state.dart';

class FinishProfileController extends StateNotifier<FinishProfileState>{
  FinishProfileController({required this.user}):super( FinishProfileState.data(null));
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
  String? phoneNumber;


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
  setphoneNumber(String val) {
    phoneNumber = val;
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
      state = const FinishProfileState.loading();
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
        state = FinishProfileState.data(isImagePicked);
        isLoading = false;
      }else{
        if (pickedImage == null) return;
        isImagePicked = true;
        webImage = await pickedImage.readAsBytes();
        state = FinishProfileState.data(isImagePicked);
        isLoading = false;
      }
    }catch(e,stx){
      state = FinishProfileState.error(e,stx);
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

  finishProfile(BuildContext context,user_model.User user) async {
    final _isValid = formKey.currentState!.validate();
    if(!_isValid){
      return;
    }
    formKey.currentState!.save();
    try {
      isLoading = true;

      bool success = kIsWeb
          ? await service.updateProfile(
            imageUrl: isImagePicked?null:user.photoUrl,
            webImage: webImage,
            username: username,
            bio: bio,
            department: department,
            christianName: christianName,
            phoneNumber: phoneNumber
          )
          : await service.updateProfile(
            imageUrl: isImagePicked?null:user.photoUrl,
            image: imageFile,
            username: username,
            bio: bio,
            department: department,
            christianName: christianName,
            phoneNumber: phoneNumber
          );
      if (success) {
        clear();
        Navigator.pop(context);
      }
    } catch (e) {
      isLoading = false;
    }
    isLoading = false;
  }

  clear() {
    imageFile = null;
  }

  void showInSnackBar(String value,context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}