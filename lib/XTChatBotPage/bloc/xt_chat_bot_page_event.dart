part of 'xt_chat_bot_page_bloc.dart';

abstract class XtChatBotPageEvent extends Equatable {
  const XtChatBotPageEvent();

  @override
  List<Object> get props => [];
}

class XtChatBotInitialEvent extends XtChatBotPageEvent {
  const XtChatBotInitialEvent() : super();
}

class XtChatBotChangeScenceEvent extends XtChatBotPageEvent {
  const XtChatBotChangeScenceEvent() : super();
}

class XtChatBotTapChatEvent extends XtChatBotPageEvent {
  final String inputMessage;
  const XtChatBotTapChatEvent({required this.inputMessage}) : super();

  @override
  List<Object> get props => [inputMessage];
}
