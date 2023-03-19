import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/animation/fenote_animation.dart';
import '../../utils/app_theme/constants.dart';
import '../../utils/custom_animation.dart';
import '../../utils/responsive.dart';
import '../../widgets/amunet_button_option.dart';
import '../../widgets/amunet_icon_button.dart';
import '../signin/controller/signin_controller.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String routeName = 'forgot_password';

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> with TickerProviderStateMixin {
  TextEditingController? emailAddressController;
  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    emailAddressController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    final signinState = ref.watch(signinProvider);
    final signinController = ref.read(signinProvider.notifier);
    String? email;
    return Scaffold(
      appBar: ResponsiveWidget.isWeb
          ? ResponsiveWidget.responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      )
          ? AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        automaticallyImplyLeading: false,
        leading: FenoteIconButton(
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Forgot Password',
          style: AMUNETheme.title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      )
          : null
          : null,
      backgroundColor: Theme.of(context).canvasColor,
      body: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 600,
              constraints: const BoxConstraints(
                maxWidth: 570,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (ResponsiveWidget.responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                              child: FenoteIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                borderWidth: 1,
                                buttonSize: 44,
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Text(
                              'Forgot Password',
                              style:  AMUNETheme.title3,
                            ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                            child: Text(
                              'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
                              style: AMUNETheme.bodyText2,
                            ).animated(
                                [animationsMap['textOnPageLoadAnimation']!]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: TextFormField(
                        controller: emailAddressController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Your email',
                          labelStyle: AMUNETheme.bodyText2,
                          hintText: 'Enter your email to receive a link...',
                          hintStyle: AMUNETheme.bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).canvasColor,
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: AMUNETheme.bodyText1.override(
                          color: const Color(0xFF0F1113),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (emailAddressController!.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Email required!',
                                ),
                              ),
                            );
                            return;
                          }
                          signinController.forgotPassword(emailAddressController!.value.text, context);
                        },
                        text: 'Send Reset Link',
                        options: FFButtonOptions(
                          width: 230,
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          textStyle: AMUNETheme.subtitle2
                              .override(
                            color: Colors.white,
                          ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
