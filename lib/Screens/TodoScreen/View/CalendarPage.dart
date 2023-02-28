import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:exam_and_viva/Utils/DBHelper/TodoDatabase.dart';
import 'package:exam_and_viva/Utils/SharedPreffrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    print("=== Calendar");
    super.initState();
    homeController.GetMonth();
    homeController.GetData();
    homeController.GetAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.teal.shade300,
          actions: [
            IconButton(
              onPressed: () {
                homeController.txtTask.value.clear();
                homeController.txtCategory.value.clear();
                Get.defaultDialog(
                    title: "New Task",
                    content: Form(
                      key: homeController.key.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: Get.height / 13,
                            child: TextFormField(
                              controller: homeController.txtTask.value,
                              decoration: InputDecoration(
                                  hintText: "Your Task",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Add Your Task";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 60,
                          ),
                          SizedBox(
                            height: Get.height / 13,
                            child: TextFormField(
                              controller: homeController.txtCategory.value,
                              decoration: InputDecoration(
                                  hintText: "Choose Category",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Choose Category";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: Get.height / 60,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (homeController.key.value.currentState!
                                      .validate()) {
                                    print("==== Start");
                                    TodoDatabase.todoDatabase.InsertData(
                                      task: homeController.txtTask.value.text,
                                      category: homeController.txtCategory.value.text,
                                      status: 0,
                                      date: "${DateTime.now().day}",
                                      month: homeController.month.value,
                                      year: "${DateTime.now().year}",
                                      month_int: DateTime.now().month
                                    );
                                    print("==== End");
                                    homeController.GetData();
                                    homeController.GetAllData();
                                    Get.back();
                                  } else {
                                    Get.snackbar(
                                        "Alert", "Please Add Your Data");
                                  }
                                },
                                child: Text("Save"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                IsLogin(login: false);
                Get.offNamed('Login');
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width / 15, bottom: 5),
                child: Text(
                  "All Task",
                  style: TextStyle(color: Colors.white, fontSize: 21.sp),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(30),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: Get.height / 6.3,
              width: Get.width,
              color: Colors.white,
              child: Obx(
                () => TableCalendar(
                  focusedDay: homeController.focusdate.value,
                  calendarFormat: CalendarFormat.week,
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(homeController.selectedDate.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    print("OnDay");
                    if (!isSameDay(
                        homeController.selectedDate.value, selectedDay)) {
                      homeController.selectedDate.value = selectedDay;
                      homeController.focusdate.value = focusedDay;
                    }
                    homeController.GetAllData();
                  },
                  onFormatChanged: (format) {},
                  onPageChanged: (focusedDay) {
                    homeController.focusdate.value = focusedDay;
                  },
                ),
              ),
            ),
            Obx(
              () => homeController.AllTaskList.isEmpty
                  ? Center(
                      child: Text("Data Not Available"),
                    )
                  : Container(
                      height: Get.height / 1.6,
                      width: Get.width,
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeController.AllTaskList.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Slidable(
                                endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          TodoDatabase.todoDatabase.InsertData(task: homeController.AllTaskList[index]['task'], category: homeController.AllTaskList[index]['category'], status: 1, date: homeController.AllTaskList[index]['date'], month: homeController.AllTaskList[index]['month'], year: homeController.AllTaskList[index]['year'], month_int: homeController.AllTaskList[index]['month_int']);
                                          // TodoDatabase.todoDatabase.InsertData(
                                          //     task: homeController.AllTaskList[index]['task'],
                                          //     category: homeController.AllTaskList[index]['category'],
                                          // );
                                          homeController.GetData();
                                          TodoDatabase.todoDatabase.DeleteData(id: homeController.AllTaskList[index]['id']);
                                          homeController.GetData();
                                          homeController.GetAllData();
                                        },
                                        icon: Icons.done_all,
                                        backgroundColor: Colors.green,
                                        label: "Done",
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          homeController.txtTask.value = TextEditingController(text: "${homeController.AllTaskList[index]['task']}");
                                          homeController.txtCategory.value = TextEditingController(text: "${homeController.AllTaskList[index]['category']}");
                                          Get.defaultDialog(
                                              title: "Upadate Task",
                                              content: Form(
                                                key: homeController.key.value,
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                      Get.height / 13,
                                                      child: TextFormField(
                                                        controller:
                                                        homeController.txtTask.value,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                            "Your Task",
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                                borderSide:
                                                                BorderSide(
                                                                    color:
                                                                    Colors.grey))),
                                                        validator: (value) {
                                                          if (value!
                                                              .isEmpty) {
                                                            return "Please Add Your Task";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      Get.height / 60,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      Get.height / 13,
                                                      child: TextFormField(
                                                        controller:
                                                        homeController
                                                            .txtCategory
                                                            .value,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                            "Choose Category",
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                                borderSide:
                                                                BorderSide(
                                                                    color:
                                                                    Colors.grey))),
                                                        validator: (value) {
                                                          if (value!
                                                              .isEmpty) {
                                                            return "Please Choose Category";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      Get.height / 60,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text(
                                                              "Cancel"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            if (homeController.key.value.currentState!.validate()) {
                                                              print("==== Start");
                                                              TodoDatabase.todoDatabase.UpadateData(
                                                                  task: homeController.txtTask.value.text,
                                                                  category: homeController.txtCategory.value.text,
                                                                  id: homeController.AllTaskList[index]['id'],
                                                                  date: "${homeController.AllTaskList[index]['date']}",
                                                                  month: "${homeController.AllTaskList[index]['month']}",
                                                                  status: homeController.AllTaskList[index]['status'],
                                                                  year: "${homeController.AllTaskList[index]['year']}",
                                                                  month_int: homeController.AllTaskList[index]['month_int'],
                                                              );
                                                              print("==== End");
                                                              homeController.GetData();
                                                              homeController.GetAllData();
                                                              Get.back();
                                                            } else {
                                                              Get.snackbar(
                                                                  "Alert",
                                                                  "Please Add Your Data");
                                                            }
                                                          },
                                                          child: Text(
                                                              "Update"),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                        icon: Icons.edit,
                                        backgroundColor:
                                        Colors.yellowAccent,
                                        label: "Edit",
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          TodoDatabase.todoDatabase.DeleteData(id: homeController.AllTaskList[index]['id']);
                                          homeController.GetData();
                                          homeController.GetAllData();
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: Colors.red,
                                        label: "Delete",
                                      ),
                                    ]),
                                child: Container(
                                  height: Get.height / 12,
                                  // color: Colors.red,
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Container(
                                          height: Get.height,
                                          width: Get.width / 45,
                                          color: homeController.AllTaskList[index]['status'] == 0 ? Colors.teal.shade300 : Colors.green,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width / 60),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${homeController.AllTaskList[index]['task']}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Text(
                                                  "${homeController.AllTaskList[index]['category']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: Get.width / 73,
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      )
                    ),
            )
          ],
        ),
      ),
    );
  }
}
