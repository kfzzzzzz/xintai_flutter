part of 'xt_chat_bot_page_bloc.dart';

abstract class XtChatBotPageState {}

class XtChatBotPageInitial extends XtChatBotPageState {}

class XtChatBotPageContent extends XtChatBotPageState {
  final int selectedBackGoundImage;
  final String messageContent;

  XtChatBotPageContent(this.selectedBackGoundImage, this.messageContent)
      : super();
}

class XtChatBotPageFaild extends XtChatBotPageState {
  XtChatBotPageFaild() : super();
}
