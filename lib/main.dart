import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:xintai_flutter/AIPhotoPage/page/AIFullPhotoPage.dart';
import 'package:xintai_flutter/AIPhotoPage/page/AIPhotoPage.dart';
import 'package:xintai_flutter/GPTManager/GPTPage.dart';
import 'package:xintai_flutter/XTHomePage/XTHomePage.dart';
import 'package:xintai_flutter/riveTest/riveTest.dart';
import 'package:xintai_flutter/testPage/MyHomePage.dart';

//import 'XTChatBotPage/XTChatBotPage.dart';

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
          settings: settings, pageBuilder: (_, __, ___) => riveTest());
    },
    'XTHomePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => const XTHomePage());
    },
    // 'XTChatBotPage': (settings, uniqueId) {
    //   return PageRouteBuilder<dynamic>(
    //       settings: settings,
    //       pageBuilder: (_, __, ___) => const XTChatBotPage());
    // },
    'AIPhotoPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => const AIPhotoPage());
    },
    'AIFullPhotoPage': (settings, uniqueId) {
      Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
      String? imageUrl = args?['ImageUrl'];
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => AIFullPhotoPage(ImageUrl: imageUrl));
    },
  };

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name!];
    if (func == null) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => const AIPhotoPage());
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
