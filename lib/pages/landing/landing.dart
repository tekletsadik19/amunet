import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/app_theme/constants.dart';
import '../../utils/custom_animation.dart';
import '../../utils/responsive.dart';
import '../../widgets/animation/fenote_animation.dart';
import '../../widgets/amunet_button_option.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin{
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<AnimationController> _controllers;
  @override
  void initState() {
    super.initState();
     _controllers = startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }
  @override
  void dispose() {
    pageViewController!.dispose();
    for (var controller in _controllers) {controller.dispose();}
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              PageView(
                controller: pageViewController ??= PageController(initialPage: 0),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      alignment: const AlignmentDirectional(0, 0),
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40, 0, 40, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/images/AMUNET Logo.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ).animated([
                                    animationsMap[
                                    'imageOnPageLoadAnimation1']!
                                  ]),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Text(
                                      'AMUNET',
                                      style: AMUNETheme.title1,
                                    ).animated([
                                      animationsMap[
                                      'textOnPageLoadAnimation1']!
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40, 0, 40, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'SENG G13',
                                          style:
                                          AMUNETheme.title2,
                                        ).animated([
                                          animationsMap[
                                          'textOnPageLoadAnimation2']!
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40, 0, 40, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        child: FFButtonWidget(
                                          onPressed: (){
                                            context.go('/auth',extra: false);
                                          },
                                          text: 'Sign up',
                                          options: FFButtonOptions(
                                            width: ResponsiveWidget.isSmallScreen(context)
                                                ?screenSize.width/1.5
                                                :screenSize.width/3,
                                            height: 50,
                                            color: Theme.of(context).accentColor,
                                            textStyle: AMUNETheme.bodyText1,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:BorderRadius.circular(50),
                                          ),
                                        ).animated([
                                          animationsMap[
                                          'buttonOnPageLoadAnimation1']!
                                        ]),

                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Already have account?',
                                            style:AMUNETheme.bodyText1
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 0, 0, 0),
                                          child: TextButton(
                                            onPressed: ()=>context.push('/auth',extra: true),
                                            child: Text(
                                                'Log in',
                                                style:AMUNETheme.bodyText1
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).animated([
                                      animationsMap[
                                      'rowOnPageLoadAnimation1']!
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
