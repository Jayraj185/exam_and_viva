import 'package:exam_and_viva/Screens/HomeScreen/View/HomePage.dart';
import 'package:exam_and_viva/Screens/PatternScreen/View/PatternPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/BottomBarPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/LoginPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/SignupPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/SplashPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/TodoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          routes: {
            '/' : (context) => HomePage(),
            'Pattern' : (context) => PatternPage(),
            'Splash' : (context) => SplashPage(),
            'Login' : (context) => LoginPage(),
            'Signup' : (context) => SignupPage(),
            'Bottom' : (context) => BottomBarPage(),
            'todo' : (context) => TodoPage(),
          },
        );
      },
    )
  );
}