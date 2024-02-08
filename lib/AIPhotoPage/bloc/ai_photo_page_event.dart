part of 'ai_photo_page_bloc.dart';

abstract class AiPhotoPageEvent extends Equatable {
  const AiPhotoPageEvent();

  @override
  List<Object> get props => [];
}

class AiPhotoPageInitialEvent extends AiPhotoPageEvent {
  const AiPhotoPageInitialEvent() : super();
}

class AiPhotoPageLoadEvent extends AiPhotoPageEvent {
  const AiPhotoPageLoadEvent() : super();
}

class AiPhotoPageSettingEvent extends AiPhotoPageEvent {
  final String sort;
  final List<int> NSFW;
  const AiPhotoPageSettingEvent(this.sort, this.NSFW) : super();
}

// class AiPhotoPageInitialEvent extends AiPhotoPageEvent {
//   const XtChatBotChangeScenceEvent() : super();
// }
