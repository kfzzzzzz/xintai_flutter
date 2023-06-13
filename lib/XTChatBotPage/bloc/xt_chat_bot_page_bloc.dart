import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xintai_flutter/GPTManager/GPTRequest.dart';

part 'xt_chat_bot_page_event.dart';
part 'xt_chat_bot_page_state.dart';

enum XTChatBotBackGroundImage {
  sea,
  forest,
  city,
}

class XtChatBotPageBloc extends Bloc<XtChatBotPageEvent, XtChatBotPageState> {
  int selectedBackGoundImage = 0;
  String messageContent = '欢迎回来~';
  OpenAIManager gptManager = OpenAIManager();
  XtChatBotPageBloc() : super(XtChatBotPageInitial()) {
    on<XtChatBotInitialEvent>((event, emit) async {
      await gptManager.getGPTAPIKey().then((value) {
        emit(XtChatBotPageContent(selectedBackGoundImage, messageContent));
      }).onError((error, stackTrace) {
        emit(XtChatBotPageFaild(error.toString()));
      });
    });
    on<XtChatBotTapChatEvent>((event, emit) async {
      await gptManager.chatGPTCompletion(event.inputMessage).then((value) {
        messageContent = value;
        emit(XtChatBotPageContent(selectedBackGoundImage, messageContent));
      }).onError((error, stackTrace) {
        emit(XtChatBotPageFaild(error.toString()));
      });
    });
    on<XtChatBotChangeScenceEvent>((event, emit) {
      selectedBackGoundImage = selectedBackGoundImage++;
      if (selectedBackGoundImage > XTChatBotBackGroundImage.values.length) {
        selectedBackGoundImage = 0;
      }
      emit(XtChatBotPageContent(selectedBackGoundImage, messageContent));
    });
  }
}
