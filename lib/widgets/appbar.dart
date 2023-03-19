import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/signin/controller/signin_controller.dart';
import '../utils/app_theme/theme_notifier.dart';


AppBar buildAppBar(BuildContext context,{required WidgetRef ref,isAppTitle = false}) {
  final signinController = ref.read(signinProvider.notifier);
  final themeNotifier = ref.watch(themeNotifierProvider);
  final modeIcon =themeNotifier.themeMode == ThemeMode.light? CupertinoIcons.light_min:CupertinoIcons.moon_stars;

  return AppBar(
    title: isAppTitle?const Text("Fenote Abew",style: TextStyle(
      fontSize: 45,
      color: Colors.black87,
      fontFamily: "Signatra"
    ),):Container(),
    centerTitle: true,
    elevation: 0,
    actions:isAppTitle?[]: [
      IconButton(
          icon: Icon(modeIcon),
          onPressed:(){
            themeNotifier.toggleTheme();
          }
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
        icon:const Icon(Icons.logout),
        onPressed:()=>signinController.signOut()
      ),
    ],
  );
}