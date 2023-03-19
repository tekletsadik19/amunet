import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/custom_animation.dart';
import '../widgets/animation/fenote_animation.dart';

class Events extends ConsumerStatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  ConsumerState<Events> createState() => _Events();
}

class _Events extends ConsumerState<Events> with TickerProviderStateMixin {
  TextEditingController? gebiGubaeIdController;
  int currentStep = 0;
  late List<AnimationController> _controllers;
  @override
  void initState() {
    super.initState();
    _controllers= startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    gebiGubaeIdController = TextEditingController();
  }
  @override
  void dispose() {
    for (var controller in _controllers) {controller.dispose();}
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(),
    );
  }
}