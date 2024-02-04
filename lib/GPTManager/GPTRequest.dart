import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/services.dart';

class OpenAIManager {
  late final String apiKey;
  late final bool inited;
  static const platform = MethodChannel('xinTai/MethodChannel');

  Future<void> getGPTAPIKey() async {
    try {
      final String result = await platform.invokeMethod('getGPTKey');
      apiKey = result;
      OpenAI.apiKey = apiKey;
      inited = true;
    } on PlatformException catch (e) {
      apiKey = "Failed to getGPTKey: '${e.message}'.";
    }
  }

  Future<void> chatGPTStream(String input,
      Function(OpenAIStreamChatCompletionModel) onChatStreamEvent) async {
    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: input,
          role: OpenAIChatMessageRole.user,
        )
      ],
    );

    chatStream.listen((chatStreamEvent) {
      onChatStreamEvent(chatStreamEvent); // 调用回调函数处理输出
    });
  }

  Future<String> chatGPTCompletion(String input) async {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        const OpenAIChatCompletionChoiceMessageModel(
          content: '你是一个中国的女孩，你的回答风格偏向日常亲密，可以有表情符号',
          role: OpenAIChatMessageRole.system,
        ),
        OpenAIChatCompletionChoiceMessageModel(
          content: input,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    return chatCompletion.choices.first.message.content;
  }
}
