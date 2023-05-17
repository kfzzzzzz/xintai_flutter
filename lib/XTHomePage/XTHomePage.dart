import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class XTHomePage extends StatefulWidget {
  const XTHomePage({super.key});

  @override
  State<XTHomePage> createState() => _XTHomePageState();
}

class _XTHomePageState extends State<XTHomePage> {
  SMIInput<double>? _treeGrowNumber;
  late Timer timer;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _treeGrowNumber = controller.findInput<double>('input') as SMINumber;
  }

  void _hitTree() {
    _treeGrowNumber?.value++;
    if ((_treeGrowNumber?.value ?? 0) >= 100) {
      _treeGrowNumber?.value = 0;
    }
  }

  void _longPressStartHitTree(LongPressStartDetails details) {
    timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      _treeGrowNumber?.value++;
      if ((_treeGrowNumber?.value ?? 0) >= 100) {
        _treeGrowNumber?.value = 0;
      }
    });
  }

  void _longPressEndHitTree(LongPressEndDetails details) {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: _hitTree,
              onLongPressStart: _longPressStartHitTree,
              onLongPressEnd: _longPressEndHitTree,
              child: RiveAnimation.asset(
                'assets/homeTree.riv',
                onInit: _onRiveInit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
