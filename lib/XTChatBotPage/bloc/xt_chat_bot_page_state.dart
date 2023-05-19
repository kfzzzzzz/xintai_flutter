part of 'xt_chat_bot_page_bloc.dart';

@immutable
abstract class XtChatBotPageState {}

class XtChatBotPageInitial extends XtChatBotPageState {}

class XtChatBotPageContent extends XtChatBotPageState {
  final int selectedBackGoundImage;

  XtChatBotPageContent(this.selectedBackGoundImage) : super();
}
