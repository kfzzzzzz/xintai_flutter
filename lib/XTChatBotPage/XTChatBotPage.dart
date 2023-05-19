import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:xintai_flutter/utils/XTScreenAdaptation.dart';

import 'bloc/xt_chat_bot_page_bloc.dart';

class XTChatBotPage extends StatefulWidget {
  const XTChatBotPage({super.key});

  @override
  State<XTChatBotPage> createState() => _XTChatBotPageState();
}

class _XTChatBotPageState extends State<XTChatBotPage>
    with TickerProviderStateMixin {
  late final XtChatBotPageBloc _xtChatBotPageBloc;
  late AnimationController _clickAnimationController;
  Offset _clickPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _xtChatBotPageBloc = XtChatBotPageBloc();
    _clickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _xtChatBotPageBloc.close();
    _clickAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    XTScreenAdaptation.init(context);

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _xtChatBotPageBloc),
        ],
        child: BlocBuilder<XtChatBotPageBloc, XtChatBotPageState>(
          builder: (context, state) {
            return Listener(
              onPointerDown: (details) {
                setState(() {
                  _clickPosition = details.localPosition;
                });
                _clickAnimationController.reset();
                _clickAnimationController.forward().whenComplete(() {
                  _clickAnimationController.reset();
                });
                // 播放音效
              },
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Bgtest.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10.px,
                      top: MediaQuery.of(context).padding.top + 10.px,
                      child: IconButton(
                        iconSize: 40.px,
                        icon: Icon(Icons.switch_camera),
                        color: Colors.pink,
                        onPressed: () {
                          BlocProvider.of<XtChatBotPageBloc>(context).add(
                            const XtChatBotChangeSenceEvent(),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 10.px,
                      bottom: MediaQuery.of(context).padding.bottom + 10.px,
                      child: SizedBox(
                        height: 100.px,
                        width: screenWidth - 20.px,
                        child: CustomPaint(
                          painter: MyPainter(),
                          child: Text('哈哈哈哈哈哈'),
                        ),
                      ),
                    ),
                    Positioned(
                      left: _clickPosition.dx - 20.px,
                      top: _clickPosition.dy - 20.px,
                      child: IgnorePointer(
                        child: Lottie.asset(
                          "assets/dianji.json",
                          width: 60.px,
                          height: 60.px,
                          repeat: false,
                          controller: _clickAnimationController,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 232, 147, 169).withOpacity(0.5) // 浅灰色半透明
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          const Radius.circular(20),
        ),
      )
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2 - 55.px, size.height)
      ..cubicTo(
        size.width / 2 - 15.px, // 第一个控制点的x坐标
        size.height - 35.px, // 第一个控制点的y坐标
        size.width / 2 + 15.px, // 第二个控制点的x坐标
        size.height - 35.px, // 第二个控制点的y坐标
        size.width / 2 + 55.px, // 结束点的x坐标
        size.height, // 结束点的y坐标
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    final invertedPath = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      path,
    );

    // Draw border
    final borderPaint = Paint()
      ..color = Color.fromARGB(255, 247, 101, 140)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.px;

    canvas.drawPath(invertedPath, paint);
    canvas.drawPath(invertedPath, borderPaint); // 绘制边框
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
