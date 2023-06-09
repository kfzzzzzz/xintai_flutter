import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
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
    _xtChatBotPageBloc.add(const XtChatBotInitialEvent());
    _clickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
  }

  @override
  void dispose() {
    _xtChatBotPageBloc.close();
    _clickAnimationController.dispose();
    super.dispose();
  }

  void _handleTapChat(String inputMessage) {
    _xtChatBotPageBloc.add(
      XtChatBotTapChatEvent(inputMessage: inputMessage),
    );
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
            String answerText = '';

            if (state is XtChatBotPageContent) {
              answerText = state.messageContent;
            } else if (state is XtChatBotPageFaild) {
              answerText = '出错啦:${state.errormessage}';
            } else {
              answerText = '抱歉出错啦';
            }
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
                      image: AssetImage('assets/background4.png'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -40.px,
                      child: SizedBox(
                        height: 650.px,
                        width: 500.px,
                        child: RiveAnimation.asset(
                          'assets/ChatBot.riv',
                          onInit: _onRiveInit,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10.px,
                      top: MediaQuery.of(context).padding.top + 10.px,
                      child: IconButton(
                        iconSize: 40.px,
                        icon: const Icon(Icons.brightness_high_rounded),
                        color: Colors.pink.shade400,
                        onPressed: () {
                          BlocProvider.of<XtChatBotPageBloc>(context).add(
                            const XtChatBotChangeScenceEvent(),
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
                          painter: BottomChatRect(),
                          child: Stack(children: [
                            Positioned(
                                left: 32.px,
                                bottom: 8.px,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            dialogBackgroundColor:
                                                const Color.fromARGB(
                                                        255, 244, 208, 218)
                                                    .withOpacity(
                                                        0.5), // 粉红色半透明底色
                                          ),
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: const Color.fromARGB(255,
                                                    247, 101, 140), // 深红色边框颜色
                                                width: 2.px, // 边框宽度
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8.px), // 边框圆角
                                            ),
                                            title: const Text(
                                              '我:',
                                            ),
                                            titleTextStyle: TextStyle(
                                              color: Colors.pink.shade600,
                                              fontSize: 16.sp,
                                              fontFamily: 'PingFang_semibold',
                                            ),
                                            content: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.px),
                                                color: const Color.fromARGB(
                                                        255, 244, 208, 218)
                                                    .withOpacity(0.5),
                                              ),
                                              child: TextField(
                                                cursorColor:
                                                    Colors.pink.shade600,
                                                style: TextStyle(
                                                  color: Colors.pink.shade600,
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      'PingFang_regular',
                                                ),
                                                onSubmitted: (value) {
                                                  Navigator.pop(context);
                                                  _handleTapChat(value);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Lottie.asset(
                                        "assets/chatBotNext.json",
                                        width: 20.px,
                                        height: 20.px,
                                        repeat: true,
                                        fit: BoxFit.fill,
                                      ),
                                      Text(
                                        '点击聊天...',
                                        style: TextStyle(
                                            color: Colors.pink.shade800,
                                            fontSize: 10.sp,
                                            fontFamily: 'PingFang_semibold'),
                                      )
                                    ],
                                  ),
                                )),
                            Positioned(
                                right: 30.px,
                                bottom: 8.px,
                                child: GestureDetector(
                                  onTap: () {
                                    print("KFZTEST:点击继续");
                                  },
                                  child: Row(
                                    children: [
                                      Lottie.asset(
                                        "assets/chatBotNext.json",
                                        width: 20.px,
                                        height: 20.px,
                                        repeat: true,
                                        fit: BoxFit.fill,
                                      ),
                                      Text(
                                        '点击继续...',
                                        style: TextStyle(
                                            color: Colors.pink.shade800,
                                            fontSize: 10.sp,
                                            fontFamily: 'PingFang_semibold'),
                                      )
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.all(10.px),
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '答:  ',
                                      style: TextStyle(
                                        color: Colors.pink.shade600,
                                        fontSize: 14.sp,
                                        fontFamily: 'PingFang_semibold',
                                      ),
                                    ),
                                    TextSpan(
                                      text: answerText,
                                      style: TextStyle(
                                        color: Colors.pink.shade600,
                                        fontSize: 14.sp,
                                        fontFamily: 'PingFang_regular',
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
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
                          fit: BoxFit.fill,
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

//底部的聊天框
class BottomChatRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 244, 208, 218).withOpacity(0.5) // 浅灰色半透明
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
