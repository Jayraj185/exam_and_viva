import 'dart:async';

import 'package:exam_and_viva/Utils/DBHelper/DoneDatabase.dart';
import 'package:exam_and_viva/Utils/DBHelper/TodoDatabase.dart';
import 'package:exam_and_viva/Utils/SharedPreffrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  //Only Variable's

  RxDouble value = 0.0.obs;
  RxList pattern = [].obs;
  RxInt BottomIndex = 0.obs;
  RxString month = "".obs;
  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> loginkey = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> signupkey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> txtTask = TextEditingController().obs;
  Rx<TextEditingController> txtCategory = TextEditingController().obs;
  Rx<TextEditingController> txtLoginEmail = TextEditingController().obs;
  Rx<TextEditingController> txtLoginPass = TextEditingController().obs;
  Rx<TextEditingController> txtSignupEmail = TextEditingController().obs;
  Rx<TextEditingController> txtSignupPass = TextEditingController().obs;
  RxList TodoList = [].obs;
  RxList DoneList = [].obs;


  //Only Function's
  void GetMonth()
  {
    if(DateTime.now().month == 1)
    {
      month.value = "January";
    }
    else if(DateTime.now().month == 2)
    {
      month.value = "February";
    }
    else if(DateTime.now().month == 3)
    {
      month.value = "March";
    }
    else if(DateTime.now().month == 4)
    {
      month.value = "April";
    }
    else if(DateTime.now().month == 5)
    {
      month.value = "May";
    }
    else if(DateTime.now().month == 6)
    {
      month.value = "June";
    }else if(DateTime.now().month == 7)
    {
      month.value = "July";
    }
    else if(DateTime.now().month == 8)
    {
      month.value = "August";
    }
    else if(DateTime.now().month == 9)
    {
      month.value = "September";
    }
    else if(DateTime.now().month == 10)
    {
      month.value = "October";
    }
    else if(DateTime.now().month == 11)
    {
      month.value = "November";
    }
    else if(DateTime.now().month == 12)
    {
      month.value = "December";
    }

  }

  void GetData() async
  {
    TodoList.value = await TodoDatabase.todoDatabase.ReadData();
    print("===== ${TodoList[0]['id']}");
  }

  void GetData2() async
  {
    DoneList.value = await DoneDatabase.doneDatabase.ReadData();
    print("===== ${TodoList[0]['id']}");
  }

  void CheckLogin() async
  {
    bool? check = await ReadIsLogin();
    print("======= $check");
    Timer(Duration(seconds: 3), () {
      if(check != null)
      {
        if(check)
        {
          Get.offNamed('todo');
        }
        else
        {
          Get.offNamed('Login');
        }
      }
      else
      {
        Get.offNamed('Login');
      }
    });
  }
}