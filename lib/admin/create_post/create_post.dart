import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/profile/profile_provider.dart';
import '../../services/upload_service.dart';
import '../../utils/firebase.dart';
import '../../models/user_model.dart' as user_model;
import '../../utils/progress_indicators.dart';
import '../../utils/responsive.dart';
import 'controller/post_view__model.dart';


class CreatePostPage extends ConsumerStatefulWidget {

  const CreatePostPage({Key? key,}) : super(key: key);
  static String routeName = '/create_post';
  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  File? file;
  user_model.User? user;
  String? message;
  UploadService service = UploadService();


  handlePostSubmit(image,postViewModel)async{

    String? mediaUrl;
    try{
      setState((){
        postViewModel.isLoading = true;
      });
      if(image ==null || postViewModel.description ==null){
        return null;
      }
      if(image != null){
        mediaUrl = await service.uploadImage(ref:postsRef,file:image!);
      }
      postViewModel.createPostInFireStore(
          mediaUrl: mediaUrl,
          description: postViewModel.description
      );
      message = 'successfully uploaded';
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:const Text('successfully uploaded your post'),
          content: const Text('you have successfully posted'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
      setState((){
        postViewModel.isLoading = false;
      });
    }catch(e){
      message = 'unable to upload try again';
    }
  }


  @override
  Widget build(BuildContext context) {
    final postViewModel = ref.watch(postViewProvider.notifier);
    final getUserData = ref.watch(getUserDataStream(firebaseAuth.currentUser!.uid));
    return WillPopScope(
      onWillPop: () async {
        await postViewModel.resetPost();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(Icons.clear),
            onPressed: (){
              postViewModel.description = '';
              Navigator.pop(context);
            },
          ),
          title: const Text("CREATE POST",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontFamily: "Montserrat"
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: postViewModel.isUploading?null:()=>handlePostSubmit(file,postViewModel),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text("POST"),
              ),
            )
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              postViewModel.isUploading?linearProgress(context):Container(),
              getUserData.when(
                  data: (DocumentSnapshot snapshot){
                    user_model.User user =  user_model.User.fromDocument(snapshot);
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage:(user.photoUrl==null)?
                        const NetworkImage(''): NetworkImage(user.photoUrl!),
                      ),
                      title: Text(
                        user.username!,
                        style:  const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'
                        ),
                      ),
                      subtitle: Text(
                        user.email!,
                      ),
                    );
                  },
                  error: (value,stack)=>Text('error'),
                  loading: ()=>linearProgress(context)
              ),
              const SizedBox(height: 15.0),
              InkWell(
                onTap: () => showImageChoices(context, postViewModel),
                child: Container(
                  width:ResponsiveWidget.isLargeScreen(context)?500: MediaQuery.of(context).size.width * .60,
                  height:ResponsiveWidget.isLargeScreen(context)?500: MediaQuery.of(context).size.width * .60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                        child: file != null? (
                            kIsWeb ? Image(image: NetworkImage(file!.path),):
                            Image(image: FileImage(File(file!.path)))
                        ) :  const Center(
                          child: Text("Select Image"),
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'POST CAPTION',
              ),
              TextFormField(
                initialValue: postViewModel.description,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(),
                ),
                maxLines: null,
                onChanged: (val) => postViewModel.setDescription(val),
              ),

            ]
        ),
      ),
    );

  }
  showImageChoices(BuildContext context, PostViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading:const Icon(CupertinoIcons.camera),
                title:const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.handleTakePhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading:const Icon(CupertinoIcons.photo),
                title:const Text('Gallery'),
                onTap: ()async {
                  Navigator.pop(context);
                  await viewModel.handleTakePhoto(ImageSource.gallery);
                  if(viewModel.imageFile != null){
                    setState((){
                      file = viewModel.imageFile!;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
