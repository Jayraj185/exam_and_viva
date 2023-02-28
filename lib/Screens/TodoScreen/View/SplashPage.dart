import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.CheckLogin();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "TaskMe",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/5,left: Get.width/40),
                child: Text(
                  "From",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/8),
                child: Text(
                  "Jayraj",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21.sp
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.width/3),
                child: CircularProgressIndicator(color: Colors.white,)
              ),
            ),
          ],
        )
      ),
    );
  }
}
