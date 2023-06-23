import 'package:dart_openai/dart_openai.dart';

class ChatGPT{

  
  Future<String> message(String message) async {
    
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
      //アシスタント調整用メッセージ
      await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          const OpenAIChatCompletionChoiceMessageModel(
            content:'''
                      - 日本語で答えてください
                      - 「」の中のメッセージのみ言ってください
                    '''
            ,
            role: OpenAIChatMessageRole.system,
          )
        ]
      );


      //アシスタントメッセージ
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
      return "やっほ〜";
    }
  }
}