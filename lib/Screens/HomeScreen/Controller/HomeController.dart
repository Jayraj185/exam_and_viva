import 'dart:async';

import 'package:exam_and_viva/Screens/TodoScreen/View/CalendarPage.dart';
import 'package:exam_and_viva/Screens/TodoScreen/View/TodoPage.dart';
import 'package:exam_and_viva/Utils/DBHelper/TodoDatabase.dart';
import 'package:exam_and_viva/Utils/SharedPreffrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

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
  RxList Screens = [
    TodoPage(),
    CalendarPage(),
  ].obs;
  Rx<DateTime> focusdate = DateTime.now().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  RxList AllTaskList = [].obs;

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
    List dataList = await TodoDatabase.todoDatabase.ReadData();
    TodoList.clear();
    DoneList.clear();
    print("========= ${dataList.length}");
    for(int i=0; i<dataList.length; i++)
      {
        print("========= $i  ${dataList[i]['task']}");
        if(dataList[i]['status'] == 0)
          {
            print("if========= $i ${dataList[i]['status']}");
            TodoList.add(dataList[i]);
          }
        else
          {
            print("else========= $i ${dataList[i]['status']}");
            DoneList.add(dataList[i]);
          }
      }
  }

  void GetAllData() async
  {
    List dataList = await TodoDatabase.todoDatabase.ReadData();
    AllTaskList.clear();
    for(int i=0; i<dataList.length; i++)
      {
        if((selectedDate.value.day.toString() == dataList[i]['date']) && (selectedDate.value.month == dataList[i]['month_int']) && (selectedDate.value.year.toString() == dataList[i]['year']))
          {
            AllTaskList.add(dataList[i]);
          }
      }
  }

  void CheckLogin() async
  {
    bool? check = await ReadIsLogin();
    Timer(Duration(seconds: 3), () {
      if(check != null)
      {
        if(check)
        {
          Get.offNamed('Bottom');
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