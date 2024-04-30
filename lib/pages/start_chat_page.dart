import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/pages/home_page.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('2a53aa'),
      ),
      body: Container(
        width: width.w,
        height: height.h,
        color:  HexColor('2a53aa'),
        child: Column(
          children: [
            Container(
              width: width.w,
              height: 250.h,

              child: Lottie.asset('assets/loaders/2hG4ePeUaS.json'),
            ),
            Expanded(
                child: Container(
                  width: width.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r)
                    )
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Welcome To',style: TextStyle(fontSize: 26.sp,color: HexColor('2a53aa'),fontWeight: FontWeight.w600,fontFamily: 'Work-Sans-Variable'),),
                            SizedBox(width: 5.w,),
                            Text('ChatMate',style: TextStyle(fontSize: 26.sp,color: HexColor('f1a5a1'),fontWeight: FontWeight.w600,fontFamily: 'Work-Sans-Variable'),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30),
                        child: Text('Welcome to the forefront of conversational technology with our Flutter AI ChatMate. Designed to redefine how we '
                            'interact and engage. Our app harnesses the power of artificial intelligence to deliver'
                            ' intelligent personalized conversations right at your fingertips.',style: TextStyle(fontSize: 14.sp,color: Colors.black54,fontWeight: FontWeight.w400,height: 1.4,wordSpacing: 2,fontFamily: 'Work-Sans-Variable'),),
                      ),
                      SizedBox(height: 8.h,),
                      InkWell(
                        onTap: (){
                          print('Tapped');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        child: Container(
                          width: 310.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: HexColor('2a53aa'),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Text('START CHATTING',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Work-Sans-Variable'),)),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        )
      ),
    );
  }
}
