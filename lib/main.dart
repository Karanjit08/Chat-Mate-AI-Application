import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space_pod/pages/home_page.dart';
import 'package:space_pod/pages/start_chat_page.dart';

void main(){
  runApp(flutterApp());
}

class flutterApp extends StatelessWidget {
  const flutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (_,child)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartPage()
      ),
    );
  }
}
