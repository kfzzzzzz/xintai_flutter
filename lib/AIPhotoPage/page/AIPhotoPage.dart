import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';
import 'package:xintai_flutter/utils/XTScreenAdaptation.dart';
import 'package:transparent_image/transparent_image.dart';

import '../bloc/ai_photo_page_bloc.dart';

class AIPhotoPage extends StatefulWidget {
  const AIPhotoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AIPhotoPage> createState() => _AIPhotoPage();
}

class _AIPhotoPage extends State<AIPhotoPage> with TickerProviderStateMixin {
  late final AiPhotoPageBloc _AiPhotoPageBloc;
  late ScrollController _scrollController;
  late AnimationController _clickAnimationController;
  Offset _clickPosition = Offset.zero;
  Offset? _downPosition;

  @override
  void initState() {
    super.initState();
    _AiPhotoPageBloc = AiPhotoPageBloc();
    _AiPhotoPageBloc.add(const AiPhotoPageInitialEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _clickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _AiPhotoPageBloc.close();
    _scrollController.dispose();
    _clickAnimationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _AiPhotoPageBloc.add(const AiPhotoPageLoadEvent());
    }
    if (_scrollController.offset <= 0) {
      // 将滚动位置设置为0，禁止继续向上滑动
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    XTScreenAdaptation.init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    late List<CivitaiImageItem> imageItems;
    return Listener(
      onPointerDown: (details) {
        // 记录按下的位置
        _downPosition = details.localPosition;
      },
      onPointerMove: (details) {
        // 如果按下后移动了，则不执行后续操作
        if (_downPosition != null && _downPosition != details.localPosition) {
          _downPosition = null;
        }
      },
      onPointerUp: (details) {
        // 如果是点击操作，则执行后续操作
        if (_downPosition != null) {
          setState(() {
            _clickPosition = details.localPosition;
          });
          _clickAnimationController.reset();
          _clickAnimationController.forward().whenComplete(() {
            _clickAnimationController.reset();
          });
          // 播放音效
        }
        // 重置按下位置
        _downPosition = null;
      },
      child: BlocProvider(
        create: (context) => _AiPhotoPageBloc,
        child: BlocBuilder<AiPhotoPageBloc, AiPhotoPageState>(
          builder: (context, state) {
            if (state is AiPhotoPageContent) {
              imageItems = state.imageItems;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: imageItems.length + 1,
                          itemBuilder: (context, index) {
                            if (index < imageItems.length) {
                              return FadeInImage.memoryNetwork(
                                width: screenWidth,
                                image: imageItems[index].url,
                                fit: BoxFit.contain,
                                placeholder: kTransparentImage,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const SizedBox(
                                    child: Placeholder(),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(), // 加载指示器
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10.px,
                    top: MediaQuery.of(context).padding.top + 10.px,
                    child: IconButton(
                      iconSize: 40.px,
                      icon: const Icon(Icons.brightness_high_rounded),
                      color: Colors.pink.shade400,
                      onPressed: () {
                        print("KFZTEST:press");
                      },
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
              );
            } else {
              return const Scaffold(
                backgroundColor: Colors.blue,
              );
            }
          },
        ),
      ),
    );
  }
}
