import 'package:flutter/services.dart';

class MessageManager {
  late MethodChannel _methodChannel;

  MessageManager._internal() {
    _methodChannel = const MethodChannel('xinTai/MethodChannel');
  }

  static MessageManager _manager = MessageManager._internal();

  factory MessageManager() {
    return _manager;
  }

  Future<void> popToNative() async {
    await _methodChannel.invokeMethod('popToNative');
  }
}
