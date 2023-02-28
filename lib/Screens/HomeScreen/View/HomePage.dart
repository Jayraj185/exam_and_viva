import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Practical Exam"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed('Pattern');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    "Pattern App",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  )),
              SizedBox(
                height: Get.height / 6,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed('Splash');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    "TODO App",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
