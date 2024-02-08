import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';
import 'package:xintai_flutter/AIPhotoPage/bloc/ai_photo_page_bloc.dart';
import 'package:xintai_flutter/utils/XTScreenAdaptation.dart';

void showTransparentOverlay(BuildContext context) {
  OverlayEntry? overlayEntry;
  double top = MediaQuery.of(context).padding.top + 10.px;
  final _AiPhotoPageBloc = BlocProvider.of<AiPhotoPageBloc>(context);
  final state = _AiPhotoPageBloc.state as AiPhotoPageContent;
  final SORTController = GroupButtonController(
    selectedIndex: CivitaiSortParm.indexOf(state.sort),
    onDisablePressed: (i) => print('Button #$i is disabled'),
  );
  final NSFWController = GroupButtonController(
    selectedIndexes: state.NSFW,
    onDisablePressed: (i) => print('Button #$i is disabled'),
  );

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: top, left: 10.px, right: 10.px),
              child: Container(
                  height: 250.px,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // 设置透明背景
                    borderRadius: BorderRadius.circular(20.0), // 设置圆角
                  ),
                  child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      itemExtent: 80.px,
                      padding: EdgeInsets.only(top: 30.px),
                      children: [
                        Column(
                          children: [
                            const Text(
                              'SORT',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GroupButton(
                              controller: SORTController,
                              buttons: const ['最新', '下载量', '最热', '随机'],
                              onSelected: (val, i, selected) => debugPrint(
                                  'Button: $val index: $i selected: $selected'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'NSFW',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GroupButton(
                              isRadio: false,
                              controller: NSFWController,
                              buttons: const ['None', 'Soft', 'Mature', 'X'],
                              onSelected: (val, i, selected) => debugPrint(
                                  'Button: $val index: $i selected: $selected'),
                            ),
                          ],
                        ),
                      ])),
            ),
            Positioned(
              top: top + 5.px,
              right: 15.px,
              child: GestureDetector(
                onTap: () {
                  overlayEntry?.remove();
                },
                child: Container(
                  height: 40.px,
                  width: 40.px,
                  decoration: BoxDecoration(
                    color: Colors.black, // 设置透明背景
                    borderRadius: BorderRadius.circular(20.0.px), // 设置圆角
                  ),
                  child: const Center(
                    child: Text(
                      'X',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20.0, // 距离底部的偏移量
              right: 20.0, // 距离右侧的偏移量
              child: ElevatedButton(
                onPressed: () {
                  _AiPhotoPageBloc.add(AiPhotoPageSettingEvent(
                      CivitaiSortParm[SORTController.selectedIndex ?? 3],
                      NSFWController.selectedIndexes.toList()));
                  _AiPhotoPageBloc.add(AiPhotoPageLoadEvent());
                  overlayEntry?.remove();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  '确定',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);
}
