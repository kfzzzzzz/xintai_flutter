part of 'xt_chat_bot_page_bloc.dart';

abstract class XtChatBotPageEvent extends Equatable {
  const XtChatBotPageEvent();

  @override
  List<Object> get props => [];
}

class XtChatBotChangeSenceEvent extends XtChatBotPageEvent {
  const XtChatBotChangeSenceEvent() : super();
}
