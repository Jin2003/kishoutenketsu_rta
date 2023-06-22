import 'package:dart_openai/dart_openai.dart';

class ChatGPT{

  
  message(String message) async {
    
  //アシスタント調整用メッセージ
  // await OpenAI.instance.chat.create(
  //   model: "gpt-3.5-turbo",
  //   messages: [
  //     const OpenAIChatCompletionChoiceMessageModel(
  //       content:'''
  //                 あなたは質問文を繰り返すだけのアシスタントです。

  //                 考慮事項
  //                 - 日本語で答えてください
  //               '''
  //       ,
  //       role: OpenAIChatMessageRole.system,
  //     )
  //   ]
  // );

  //ユーザーメッセージ
  // await OpenAI.instance.chat.create(
  //     model: "gpt-3.5-turbo",
  //     messages: [
  //       OpenAIChatCompletionChoiceMessageModel(
  //         content: message1,
  //         role: OpenAIChatMessageRole.user,
  //       )
  //     ]
  //   );

try {
      final response = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: message,
            role: OpenAIChatMessageRole.assistant,
          )
        ],
      );
      return response.choices.first.message.content;
    } catch (e) {
      // エラーメッセージを表示するなどの適切な処理を行う
      print("An error occurred: $e");
      return "やっほー";
    }
  }
}