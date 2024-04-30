import 'package:http/http.dart' as http;
import 'package:space_pod/utils/constants.dart';

Future<void> postChat(String chatMessage)async{
  var client = http.Client();
  final response = await client.post(Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${API_KEY}'),

  );
  print(response.statusCode);
}