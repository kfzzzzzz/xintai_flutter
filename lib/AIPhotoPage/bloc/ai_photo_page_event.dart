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

// class AiPhotoPageInitialEvent extends AiPhotoPageEvent {
//   const XtChatBotChangeScenceEvent() : super();
// }
