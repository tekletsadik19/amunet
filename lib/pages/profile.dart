import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../auth/signin/controller/signin_controller.dart';
import '../repository/profile/profile_provider.dart';
import '../utils/app_theme/constants.dart';
import '../utils/custom_animation.dart';
import '../utils/firebase.dart';
import '../../pages/edit_profile.dart';
import '../../widgets/animation/fenote_animation.dart';
import '../utils/progress_indicators.dart';
import '../utils/responsive.dart';
import '../widgets/amunet_button_option.dart';
import '../widgets/amunet_icon_button.dart';
import '../models/user_model.dart' as user_model;
import '../widgets/profile_widget.dart';
import '../widgets/toggle_theme.dart';
import 'error_page/connection_lost.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> with TickerProviderStateMixin {
  user_model.User? _user;
  @override
  Widget build(BuildContext context) {
    final signinController = ref.read(signinProvider.notifier);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      )
          ? AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Profile',
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
            child: FenoteIconButton(
              borderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              borderWidth: 1,
              buttonSize: 60,
              icon: const Icon(
                Icons.logout,
                size: 24,
              ),
              onPressed: ()=>signinController.signOut()
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              sliver: SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  toolbarHeight: 5.0,
                  collapsedHeight: 6.0,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _getUserDataStream(),
                  )
              ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                child: Text(
                  'Account',
                  style: AMUNETheme.subtitle1,
                ),
              ),
              const ToggleTheme(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  child: FFButtonWidget(
                    onPressed:(){
                      if(_user != null){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditUserProfile(user: _user!),
                            )
                        );
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.user,),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                    text:  'Edit Profile',
                    showLoadingIndicator: true,
                    options: FFButtonOptions(
                      width: ResponsiveWidget.isSmallScreen(context)
                          ?screenSize.width/1.5
                          :screenSize.width/3,
                      height: 60,
                      color: Theme.of(context).canvasColor,
                      textStyle: Theme.of(context).textTheme.headline3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius:BorderRadius.circular(12),
                    ),
                  ).animated([
                    animationsMap[
                    'buttonOnPageLoadAnimation1']!
                  ]),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                child: Text(
                  'General',
                  style: AMUNETheme.subtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x3416202A),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  child: FFButtonWidget(
                    onPressed:(){

                    },
                    icon: const Icon(Icons.ios_share,),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                    text:  'Invite Friends',
                    showLoadingIndicator: true,
                    options: FFButtonOptions(
                      width: ResponsiveWidget.isSmallScreen(context)
                          ?screenSize.width/1.5
                          :screenSize.width/3,
                      height: 60,
                      color: Theme.of(context).canvasColor,
                      textStyle: Theme.of(context).textTheme.headline3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius:BorderRadius.circular(12),
                    ),
                  ).animated([
                    animationsMap[
                    'buttonOnPageLoadAnimation1']!
                  ]),
                ),
              ),


            ]),
          ),
        ],
      ),
    );
  }
  Widget _getUserDataStream(){

    final userData = ref.watch(getUserDataStream(firebaseAuth.currentUser!.uid));
    return userData.when(
        data: (DocumentSnapshot snapshot){
          _user =  user_model.User.fromDocument(snapshot);
          return ListView(
            physics:  const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 10),
              CachedNetworkImage(
                placeholder: (context, url) => circularProgress(context),
                errorWidget: (context, url, error) =>  ProfileWidget(
                    imageProvider: Image.asset(
                      'assets/images/AMUNET Logo.png',
                      fit: BoxFit.cover,
                    ).image,
                    isEdit: false,
                    onClicked: (){}
                ),
                fit: BoxFit.cover,
                imageUrl: _user!.photoUrl!,
                imageBuilder: (context, imageProvider) {
                  return ProfileWidget(
                      imageProvider: imageProvider,
                      onClicked: (){
                      }
                  );
                },
              ),
              const SizedBox(height: 15),
              buildName(_user!),
              Text(
                _user?.bio ?? '',
                style:const TextStyle(
                    color: Colors.blue
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
        error: (value,stack)=>const ConnectionLostScreen(),
        loading: ()=>circularProgress(context));
  }

  Widget buildName(user_model.User user) =>
  Column(
    children: [
      Text(
        user.username!,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Raleway'
        ),
      ),
      const SizedBox(height: 4),
      Text(
        "department: ${user.department!}",
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

}

