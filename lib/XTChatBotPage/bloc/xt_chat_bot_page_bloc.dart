import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'xt_chat_bot_page_event.dart';
part 'xt_chat_bot_page_state.dart';

enum XTChatBotBackGroundImage {
  sea,
  forest,
  city,
}

class XtChatBotPageBloc extends Bloc<XtChatBotPageEvent, XtChatBotPageState> {
  int selectedBackGoundImage = 0;
  XtChatBotPageBloc() : super(XtChatBotPageInitial()) {
    on<XtChatBotChangeSenceEvent>((event, emit) {
      selectedBackGoundImage = selectedBackGoundImage++;
      if (selectedBackGoundImage > XTChatBotBackGroundImage.values.length) {
        selectedBackGoundImage = 0;
      }
      emit(XtChatBotPageContent(selectedBackGoundImage));
    });
  }
}
