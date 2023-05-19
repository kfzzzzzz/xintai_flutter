import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:xintai_flutter/utils/XTScreenAdaptation.dart';

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
    XTScreenAdaptation.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: GestureDetector(
          onTap: _hitTree,
          onLongPressStart: _longPressStartHitTree,
          onLongPressEnd: _longPressEndHitTree,
          child: Column(
            children: [
              SizedBox(
                height: 100.px,
              ),
              SizedBox(
                height: 400.px,
                child: RiveAnimation.asset(
                  'assets/homeTree.riv',
                  onInit: _onRiveInit,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 20.px),
              Text(
                '暂无更多气人内容，请帮助小树成长～',
                style: TextStyle(
                    color: const Color.fromARGB(255, 242, 46, 98),
                    fontSize: 18.sp,
                    fontFamily: 'PingFang_semibold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
