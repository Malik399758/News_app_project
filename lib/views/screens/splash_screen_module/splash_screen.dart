
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/views/screens/home_module/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),() =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
    HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body : Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.asset('assets/images/News splash_screen.png'),
           Text('News App',style: GoogleFonts.padauk(fontSize: 20.sp,
           fontWeight: FontWeight.w600),),
           SizedBox(height: 10.w,),
           SpinKitChasingDots(
             color: Colors.blue,
             size: 20,
           )
         ],
       )
    );
  }
}
