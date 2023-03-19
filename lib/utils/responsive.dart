import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

int smallScreenWidth = 852;
int largeScreenWidth = 1200;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isiOS => !kIsWeb && Platform.isIOS;


  const ResponsiveWidget(
      { Key? key,
        required this.largeScreen,
        this.mediumScreen,
        this.smallScreen
      }) : super(key: key);
  static bool isSmallScreen(BuildContext context){
    return MediaQuery.of(context).size.width < smallScreenWidth;
  }
  static bool isMediumScreen(BuildContext context){
    return (MediaQuery.of(context).size.width >= smallScreenWidth &&
        MediaQuery.of(context).size.width < largeScreenWidth);
  }
  static bool isLargeScreen(BuildContext context){
    return MediaQuery.of(context).size.width > largeScreenWidth;
  }

  static bool responsiveVisibility({
    required BuildContext context,
    bool phone = true,
    bool tablet = true,
    bool tabletLandscape = true,
    bool desktop = true,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 479) {
      return phone;
    } else if (width < 767) {
      return tablet;
    } else if (width < 991) {
      return tabletLandscape;
    } else {
      return desktop;
    }
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      double maxWidth = constraints.maxWidth;
      if(maxWidth >largeScreenWidth){
        return largeScreen;
      }else if(maxWidth>=smallScreenWidth && maxWidth<largeScreenWidth){
        return mediumScreen ?? largeScreen;
      } else{
        return smallScreen ?? largeScreen;
      }
    });
  }
}
