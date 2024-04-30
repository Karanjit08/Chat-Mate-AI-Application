import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/repos/chat_repo.dart';
import 'package:space_pod/services/chat_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/chat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController chatController = TextEditingController();
  List<ChatMessageModel> messages = [];
  bool generating = false;

  SpeechToText speechToText = SpeechToText();
  var speech = 'Hello Mate! How are you?';
  var isListening = false;

  void _startListening(TapDownDetails details)async{
    if(!isListening){
      var available = await speechToText.initialize();
      if(available){
        setState(() {
          isListening = true;
          speechToText.listen(onResult:(result){
            speech = result.recognizedWords;
            print('TRANSLATIONS: ${speech}');
          } );
        });


      }
    }
  }

  void _stopListening(TapUpDetails details)async{

    setState(() {
      generating = true;
      messages.add(ChatMessageModel(role: "user", parts: [ChatPartModel(text: speech)]));
    });

    final generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if(generatedText.toString().length>0){
      messages.add(ChatMessageModel(role: "model", parts: [ChatPartModel(text: generatedText.toString())]));
    }
    setState(() {
      generating = false;
    });
    setState(() {
      isListening = false;
    });
    speechToText.stop();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(onWillPop: ()async{
      SystemNavigator.pop();
      return true;
    },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: 70.h,right: 6.w),
          child: AvatarGlow(
            animate: isListening,
            duration: Duration(milliseconds: 2000),
            glowColor: HexColor('2a53aa'),
            repeat: true,
            child: GestureDetector(
              onTapDown: _startListening,
              onTapUp: _stopListening,
              child: CircleAvatar(
                backgroundColor: HexColor('2a53aa'),
                radius: 30.r,
                child: Icon((isListening)?Icons.mic : Icons.mic_none,color: Colors.white,),
              ),
            ),
          ),
        ),
        body: Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
              color: HexColor('#FFF3D3')
          ),
          child: Column(
            children: [
              Expanded(child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                    return (messages[index].role=="user") ? Container(
                        margin: EdgeInsets.only(
                            bottom: 12.h, left: 16.w, right: 16.w,top: 10.h),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              bottomLeft: Radius.circular(25.r),
                              bottomRight: Radius.circular(25.r),
                            ),
                            color: HexColor('2a53aa')),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(messages[index].role=="user" ? "User" : "Gemini",
                              style: TextStyle(
                                  fontFamily: 'Work-Sans-Italic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color:
                                  messages[index].role == "user"
                                      ? Colors.white
                                      : HexColor('3a525a')),),
                            SizedBox(height: 12.h,),
                            Text(messages[index].parts.first.text,style: TextStyle(color: Colors.white,fontFamily: 'Work-Sans-Variable',fontSize: 14.sp,fontWeight: FontWeight.w500),)
                          ],
                        )
                    ) : Container(
                        margin: EdgeInsets.only(
                            bottom: 12.h, left: 16.w, right: 16.w),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.r),
                                bottomLeft: Radius.circular(25.r),
                                bottomRight: Radius.circular(25.r)
                            ),
                            color: HexColor('f1a09b').withOpacity(0.8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(messages[index].role=="user" ? "User" : "Gemini",
                              style: TextStyle(
                                  fontFamily: 'Work-Sans-Italic',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color:
                                  messages[index].role == "user"
                                      ? HexColor('963c29')
                                      : Colors.black),),
                            SizedBox(height: 12.h,),
                            Text(messages[index].parts.first.text,style: TextStyle(color: Colors.black,fontFamily: 'Work-Sans-Variable',fontSize: 14.sp,fontWeight: FontWeight.w500,height: 1.5),)
                          ],
                        )
                    );
                  })),
              if(generating==true)
                Container(
                    height: 100,
                    width: 200,
                    child: Lottie.asset('assets/loaders/loader2.json')),
              Container(
                width: width.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  // color: HexColor('aad5e8')
                ),
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: TextField(
                        controller: chatController,
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask me Anything...',
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: HexColor('2a53aa'),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                      ),
                    ),),
                    SizedBox(width: 10.w,),
                    Padding(
                      padding: EdgeInsets.only(left:6.0.w,right: 6.0.w),
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundColor: HexColor('2a53aa'),
                        child: InkWell(
                          onTap: () async{
                            String text = chatController.text;
                            chatController.clear();
                            print('SEND CLICKED');

                            setState(() {
                              generating = true;
                              messages.add(ChatMessageModel(role: "user", parts: [ChatPartModel(text: text)]));
                            });
                            final generatedText = await ChatRepo.chatTextGenerationRepo(messages);
                            if(generatedText.toString().length>0){
                              messages.add(ChatMessageModel(role: "model", parts: [ChatPartModel(text: generatedText.toString())]));
                            }
                            setState(() {
                              generating = false;
                            });
                          },
                          child: InkWell(
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: HexColor('2a53aa'),
                              child: Icon(Icons.send,size: 35,color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
