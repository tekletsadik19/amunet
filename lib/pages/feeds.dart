import 'package:amunet/utils/app_theme/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive.dart';
import '../widgets/amunet_button_option.dart';


class Feeds extends ConsumerStatefulWidget {
  Feeds({Key? key}) : super(key: key);

  @override
  ConsumerState<Feeds> createState() => _FeedsState();
}

class _FeedsState extends ConsumerState<Feeds> with TickerProviderStateMixin{
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:ResponsiveWidget.responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ) ? AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        )
            : null,

        drawerEnableOpenDragGesture: true,
        body: Column(
          children: [
            FFButtonWidget(
              onPressed:  (){
                context.go('/finish_signing');
              },
              text: 'Finish Your Profile',
              options: FFButtonOptions(
                width: double.infinity,
                height: 150,
                color: const Color(0xffff518c),
                textStyle: AMUNETheme.bodyText1.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w400
                ),
                elevation: 0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        )
    );
  }
}


