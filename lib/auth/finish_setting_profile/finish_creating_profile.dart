import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/custom_form_field.dart';
import '../../utils/app_theme/constants.dart';
import '../../utils/progress_indicators.dart';
import '../../utils/responsive.dart';
import '../../../models/user_model.dart' as user_model;
import '../../widgets/amunet_button_option.dart';
import '../../widgets/amunet_dropdown.dart';
import '../../widgets/amunet_icon_button.dart';
import '../../widgets/profile_widget.dart';
import 'controller/finish_setup_provider.dart';

class FinishUpProfile extends ConsumerStatefulWidget {
  const FinishUpProfile({Key? key}) : super(key: key);
  static String routeName = '/finish_signing';
  @override
  ConsumerState<FinishUpProfile> createState() => _FinishUpProfileState();
}




class _FinishUpProfileState extends ConsumerState<FinishUpProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _usernameFocus = FocusNode();
  final _christianNameFocus = FocusNode();
  final _departmentFocus = FocusNode();
  final _biosFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  TextEditingController? christianNameController;
  TextEditingController? yourNameController;
  TextEditingController? myBioController;
  TextEditingController? myPhoneNumberController;
  String uploadedFileUrl = '';
  String? departmentValue;

  var _userInfo = user_model.User(
      username: "",
      department: "",
      phoneNumber: "",
      sect: "",
      bio: "",
      email: "",
      photoUrl:""
  );
  @override
  void initState() {
    super.initState();
    christianNameController = TextEditingController(text: _userInfo.sect);
    yourNameController = TextEditingController(text: _userInfo.username);
    myBioController = TextEditingController(text: _userInfo.bio);
    myPhoneNumberController = TextEditingController(text: _userInfo.phoneNumber);
  }
  @override
  void dispose() {
    christianNameController!.dispose();
    yourNameController!.dispose();
    myBioController!.dispose();
    _usernameFocus.dispose();
    _christianNameFocus.dispose();
    _departmentFocus.dispose();
    _biosFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final profileViewModel = ref.read(finishSettingUpProfileProvider(_userInfo).notifier);
    return Scaffold(
      key: scaffoldKey,
      appBar: ResponsiveWidget.isWeb
          ? ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      )
          ? AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Finish Setting Profile',
          style: AMUNETheme.title3,
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      )
          : null
          : null,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
                key: profileViewModel.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).accentColor,
                            const Color(0xFF2B318A)
                          ],
                          stops: const [0, 1],
                          begin: const AlignmentDirectional(0.17, -1),
                          end: const AlignmentDirectional(-0.17, 1),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 100, 20, 0),
                        child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                            child: Consumer(
                              builder: (context, ref, child) {
                                final state = ref.watch(finishSettingUpProfileProvider(_userInfo));
                                final editProfileView = ref.read(finishSettingUpProfileProvider(_userInfo).notifier);
                                return state.when(
                                  data: (user){
                                    return editProfileView.isImagePicked
                                        ?(
                                        kIsWeb
                                            ?ProfileWidget(
                                            imageProvider: Image.memory(editProfileView.webImage).image,
                                            onClicked: ()=> showImageChoices(context, editProfileView),
                                            isEdit:true
                                        )
                                            :ProfileWidget(
                                            imageProvider: Image.file(editProfileView.imageFile!).image,
                                            onClicked: ()=> showImageChoices(context, editProfileView),
                                            isEdit:true
                                        )
                                    )
                                        : CachedNetworkImage(
                                      placeholder: (context, url) => circularProgress(context),
                                      errorWidget: (context, url, error) =>  ProfileWidget(
                                          imageProvider: Image.asset(
                                            'assets/images/AMUNET Logo.png',
                                            fit: BoxFit.cover,
                                          ).image,
                                          isEdit:true,
                                          onClicked: ()=> showImageChoices(context, editProfileView)
                                      ),
                                      fit: BoxFit.cover,
                                      imageUrl:_userInfo.photoUrl!,
                                      imageBuilder: (context, imageProvider) {
                                        return ProfileWidget(
                                            imageProvider: imageProvider,
                                            isEdit:true,
                                            onClicked: ()=> showImageChoices(context, editProfileView)
                                        );
                                      },
                                    );
                                  },
                                  loading:()=> const Center(child: CircularProgressIndicator()),
                                  error: (e, stk) => Center(
                                    child: Column(
                                      children: const [
                                        Icon(Icons.info),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Something Went Wrong!",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      child: CustomTextFormField(
                        controller: yourNameController,
                        labelText: 'Your Name',
                        focusNode: _usernameFocus,
                        validator: (value){
                          if(value.isEmpty){
                            return "username is required";
                          }
                          if(value.length < 5){
                            return "username is invalid";
                          }
                          return null;
                        },
                        onSaved: (String val) {
                          profileViewModel.setUsername(yourNameController!.value.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      child: CustomTextFormField(
                        controller: myPhoneNumberController,
                        labelText: 'phone number',
                        focusNode: _phoneNumberFocus,
                        validator: (value){
                          if(value.isEmpty){
                            return "phone number is required";
                          }
                          if(double.tryParse(value.substring(1)) == null || value.length !=10){
                            return "invalid phone number";
                          }
                          return null;
                        },
                        onSaved: (String? val) {
                          profileViewModel.setphoneNumber(myPhoneNumberController!.value.text!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                      child: FenoteDropDown(
                        initialOption: departmentValue ??= 'Software Engineering',
                        options: const [
                          'Software Engineering',
                          'Computer Science',
                          'Architecture and Urban Planning'
                          'Electrical and Computer Engineering',
                          'Information Technology',
                          'Hydraulic and Water Resources Engineering',
                          'Civil Engineering',
                          'Mechanical Engineering',
                          'Water Resource and Irrig Engineering',
                          'Water Supply and Environmental Engineering',
                          'Meteorology and Hydrology',
                        ],
                        onChanged: (val){
                          setState(() => departmentValue = val);
                          profileViewModel.setDepartment(departmentValue!);
                        },

                        width: double.infinity,
                        height: 56,
                        textStyle: AMUNETheme.bodyText1,
                        hintText: 'Select Department',
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 15,
                        ),
                        fillColor:
                        Theme.of(context).canvasColor,
                        elevation: 2,
                        borderColor:
                        Theme.of(context).primaryColor,
                        borderWidth: 2,
                        borderRadius: 50,
                        margin: const EdgeInsetsDirectional.fromSTEB(20, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                      child: TextFormField(
                        controller: myBioController,
                        obscureText: false,
                        focusNode: _biosFocus,
                        decoration: InputDecoration(
                          labelText: 'bios',
                          labelStyle: AMUNETheme.bodyText2,
                          hintText: 'Your bio',
                          hintStyle: AMUNETheme.bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).canvasColor,
                          contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                        ),
                        style: AMUNETheme.bodyText1,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        validator: (value){
                          if(value!.length>60){
                            return "too long description";
                          }
                          return null;
                        },
                        onSaved: (String? val) {
                          profileViewModel.setBio(myBioController!.value.text!);
                        },

                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 0.05),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _userInfo = await profileViewModel.finishProfile(context,_userInfo);
                          },
                          text: 'Save Changes',
                          options: FFButtonOptions(
                            width: 270,
                            height: 50,
                            color: Theme.of(context).accentColor,
                            textStyle: AMUNETheme.subtitle1,
                            elevation: 2,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }


  showImageChoices(context,viewModel) {
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
                leading:const Icon(FontAwesomeIcons.camera),
                title:const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await viewModel.setProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:const Icon(FontAwesomeIcons.image),
                title:const Text('Gallery'),
                onTap: ()async {
                  Navigator.pop(context);
                  await viewModel.setProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
