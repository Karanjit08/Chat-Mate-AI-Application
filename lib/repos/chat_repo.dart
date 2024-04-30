import 'dart:convert';

import '../models/chat_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';


class ChatRepo{

  static Future<String> chatTextGenerationRepo(List<ChatMessageModel> previousMessages)async{
    var client = http.Client();
    final response = await client.post(Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${API_KEY}'),
      body: jsonEncode({
        "contents": previousMessages.map((e) => e.toMap()).toList(),
        "generationConfig": {
          "temperature": 0.9,
          "topK": 1,
          "topP": 1,
          "maxOutputTokens": 2048,
          "stopSequences": []
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          }
        ]
      })
    );
    if(response.statusCode>=200 && response.statusCode<300){
      Map<String, dynamic> data = json.decode(response.body);
      // print(response.body);
      print(response.statusCode);

      print(data['candidates'][0]['content']['parts'][0]['text']);
      return data['candidates'][0]['content']['parts'][0]['text'];
    }
    return '';

  }

}