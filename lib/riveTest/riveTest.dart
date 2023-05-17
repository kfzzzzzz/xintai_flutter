import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({Key? key}) : super(key: key);

  @override
  _SimpleStateMachineState createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  SMITrigger? _boolExampleInput;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _boolExampleInput = controller.findInput<bool>('hitBall') as SMITrigger;
  }

  void _hitBump() {
    _boolExampleInput?.fire();
    // if (_boolExampleInput?.value == false) {
    //   _boolExampleInput?.value = true;
    // } else {
    //   _boolExampleInput?.value = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: Center(
        child: GestureDetector(
          child: RiveAnimation.asset(
            'assets/test.riv',
            //'https://cdn.rive.app/animations/vehicles.riv',
            //fit: BoxFit.cover,
            onInit: _onRiveInit,
          ),
          onTap: _hitBump,
        ),
      ),
    );
  }
}
