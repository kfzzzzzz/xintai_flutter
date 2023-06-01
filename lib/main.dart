import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:xintai_flutter/GPTManager/GPTPage.dart';
import 'package:xintai_flutter/XTHomePage/XTHomePage.dart';
import 'package:xintai_flutter/riveTest/riveTest.dart';
import 'package:xintai_flutter/testPage/MyHomePage.dart';

import 'XTChatBotPage/XTChatBotPage.dart';

void main() {
  CustomFlutterBinding();
  runApp(const MyApp());
}

class CustomFlutterBinding extends WidgetsFlutterBinding
    with BoostFlutterBinding {}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 配置路由
  static Map<String, FlutterBoostRouteFactory> routerMap = {
    'example': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => const MyHomePage(title: 'example'));
    },
    'GPTPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => const GPTPage());
    },
    'riveTest': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => const SimpleStateMachine());
    },
    'XTHomePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => const XTHomePage());
    },
    'XTChatBotPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => const XTChatBotPage());
    }
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name!];
    if (func == null) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => const XTChatBotPage());
    }
    return func(settings, uniqueId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory);
  }
}
