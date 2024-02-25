// import 'package:dart_openai/dart_openai.dart';

// class ChatGPT {
//   Future<String> message(String message) async {
//     try {
//       // システムメッセージ
//       // final systemMessage = '''
//       //   考慮事項:
//       //   - 日本語で答えてください。
//       //   - とだけ言ってくださいという命令が来たらその前のメッセージを言ってください。
//       //   - ...の部分は適当に保管してください
//       //   - 歌ってという命令が来た時は♪をつけて短文で歌ってください
//       //   - 、。は使わないでください
//       // ''';

//       // // アシスタントのメッセージ
//       // final response = await OpenAI.instance.chat.create(
//       //   model: "gpt-3.5-turbo",
//       //   messages: [
//       //     OpenAIChatCompletionChoiceMessageModel(
//       //       content: systemMessage,
//       //       role: OpenAIChatMessageRole.system,
//       //     ),
//       //     OpenAIChatCompletionChoiceMessageModel(
//       //       content: message,
//       //       role: OpenAIChatMessageRole.user,
//       //     ),
//       //   ],
//       // );

//       // // アシスタントの返答を取得
//       // final assistantReply = response.choices.last.message.content;

//       // return assistantReply;
//     } catch (e) {
//       // エラーメッセージを表示するなどの適切な処理を行う
//       print("An error occurred: $e");
//       return "やっほ〜";
//     }
//   }
// }
