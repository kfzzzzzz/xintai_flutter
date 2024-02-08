import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xintai_flutter/AIPhotoPage/AIPhotoRequest.dart';
import 'package:xintai_flutter/AIPhotoPage/CivitaiModel.dart';

part 'ai_photo_page_event.dart';
part 'ai_photo_page_state.dart';

class AiPhotoPageBloc extends Bloc<AiPhotoPageEvent, AiPhotoPageState> {
  AiPhotoPageBloc() : super(AiPhotoPageInitial()) {
    CivitaiManager civitaiManager = CivitaiManager();
    int page = 1;
    List<CivitaiImageItem> imageItems = [];
    on<AiPhotoPageInitialEvent>((event, emit) async {
      await AIPhotoManager()
          .getCivitaiModel(page, civitaiManager.sort)
          .then((value) {
        page++;
        imageItems = value;
        emit(AiPhotoPageContent(
            imageItems, civitaiManager.NSFW, civitaiManager.sort));
      }).onError((error, stackTrace) {
        print(error);
        emit(AiPhotoPageLoadFail());
      });
    });
    on<AiPhotoPageLoadEvent>((event, emit) async {
      await AIPhotoManager()
          .getCivitaiModel(page, civitaiManager.sort)
          .then((value) {
        page++;
        imageItems = imageItems + value;
        emit(AiPhotoPageContent(
            imageItems, civitaiManager.NSFW, civitaiManager.sort));
      }).onError((error, stackTrace) {
        print(error);
        if (imageItems == []) {
          emit(AiPhotoPageLoadFail());
        } else {
          emit(AiPhotoPageContent(
              imageItems, civitaiManager.NSFW, civitaiManager.sort));
        }
      });
    });
    on<AiPhotoPageSettingEvent>((event, emit) {
      page = 1;
      imageItems = [];
      civitaiManager.NSFW = event.NSFW;
      civitaiManager.sort = event.sort;
    });
  }
}
