import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';
import 'package:xintai_flutter/AIPhotoPage/page/AIFullPhotoPage.dart';
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
  final lottieAnimation = rootBundle.loadString('assets/Loading.json');
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
              return Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: MasonryGridView.count(
                          padding: const EdgeInsets.only(top: 5.0),
                          controller: _scrollController,
                          itemCount: imageItems.length + 1,
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            if (index == imageItems.length) {
                              // 判断在builder第几个，如果到达最后一个判断是否还需要请求数据
                              //加载时显示loading
                              return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Container(
                                      padding: EdgeInsets.only(top: 5.0.px),
                                      child: LottieBuilder.asset(
                                        'assets/Loading.json',
                                        repeat: true,
                                        width: screenWidth,
                                        height: 40.px,
                                        fit: BoxFit.contain,
                                      )));
                            }

                            return GestureDetector(
                              onTap: () {
                                print('KFZTEST:2222');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AIFullPhotoPage(
                                          ImageItem: imageItems[index])),
                                );
                              },
                              child: FadeInImage.memoryNetwork(
                                width: screenWidth / 2,
                                height: imageItems[index].height /
                                    imageItems[index].width *
                                    screenWidth /
                                    2,
                                image: imageItems[index].url,
                                fit: BoxFit.contain,
                                placeholder: kTransparentImage,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return SizedBox(
                                    height: imageItems[index].height /
                                        imageItems[index].width *
                                        screenWidth /
                                        2,
                                    width: screenWidth / 2,
                                    child: Image.asset(
                                        'assets/ImageDownloadFail.png'),
                                  );
                                },
                              ),
                            );
                          },
                        )),
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
                ),
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
