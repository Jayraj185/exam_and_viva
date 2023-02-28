import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:exam_and_viva/Utils/DBHelper/DoneDatabase.dart';
import 'package:exam_and_viva/Utils/DBHelper/TodoDatabase.dart';
import 'package:exam_and_viva/Utils/SharedPreffrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.GetMonth();
    homeController.GetData();
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
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
          ),
          backgroundColor: Colors.teal.shade300,
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "New Task",
                  content: Form(
                    key: homeController.key.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: Get.height/13,
                          child: TextFormField(
                            controller: homeController.txtTask.value,
                            decoration: InputDecoration(
                              hintText: "Your Task",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)
                              )
                            ),
                            validator: (value) {
                              if(value!.isEmpty)
                                {
                                  return "Please Add Your Task";
                                }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: Get.height/60,),
                        SizedBox(
                          height: Get.height/13,
                          child: TextFormField(
                            controller: homeController.txtCategory.value,
                            decoration: InputDecoration(
                                hintText: "Choose Category",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)
                              )
                            ),
                            validator: (value) {
                              if(value!.isEmpty)
                              {
                                return "Please Choose Category";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: Get.height/60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(onPressed: () => Get.back(), child: Text("Cancel"),),
                            TextButton(onPressed: () {
                              if(homeController.key.value.currentState!.validate())
                                {
                                  print("==== Start");
                                  TodoDatabase.todoDatabase.InsertData(task: homeController.txtTask.value.text, category:  homeController.txtCategory.value.text);
                                  print("==== End");
                                  homeController.GetData();
                                  Get.back();
                                }
                              else
                                {
                                  Get.snackbar("Alert","Please Add Your Data");
                                }
                            }, child: Text("Save"),),
                          ],
                        )
                      ],
                    ),
                  )
                );
              },
              icon: Icon(Icons.add,color: Colors.white,),
            ),
            IconButton(
              onPressed: () {
                IsLogin(login: false);
                Get.offNamed('Login');
              },
              icon: Icon(Icons.logout,color: Colors.white,),
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width/15,bottom: 5),
                child: Text(
                  "Today, ${homeController.month.value} ${DateTime.now().day}",
                  style: TextStyle(color: Colors.white, fontSize: 21.sp),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(30),
          ),
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => Column(
            children: [
              Container(
                height: Get.height/21,
                width: Get.width,
                color: Colors.grey.shade300,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Get.width/15,),
                child: Text(
                    "TODO (${homeController.TodoList.length})",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              homeController.TodoList.isEmpty
                  ? Center(child: Text("Please Add Todo Data"),)
                  : Container(
                height: Get.height/3,
                width: Get.width,
                child: ListView.builder(
                  itemCount: homeController.TodoList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  DoneDatabase.doneDatabase.InsertData(task: homeController.TodoList[index]['task'], category: homeController.TodoList[index]['category']);
                                  homeController.GetData2();
                                  TodoDatabase.todoDatabase.DeleteData(id: index==0?1:index+1);
                                  homeController.GetData();
                                },
                                icon: Icons.done_all,
                                backgroundColor: Colors.green,
                                label: "Done",
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  homeController.txtTask.value = TextEditingController(text: "${homeController.TodoList[index]['task']}");
                                  homeController.txtCategory.value = TextEditingController(text: "${homeController.TodoList[index]['category']}");
                                  Get.defaultDialog(
                                      title: "Upadate Task",
                                      content: Form(
                                        key: homeController.key.value,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: Get.height/13,
                                              child: TextFormField(
                                                controller: homeController.txtTask.value,
                                                decoration: InputDecoration(
                                                    hintText: "Your Task",
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.grey)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.grey)
                                                    )
                                                ),
                                                validator: (value) {
                                                  if(value!.isEmpty)
                                                  {
                                                    return "Please Add Your Task";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(height: Get.height/60,),
                                            SizedBox(
                                              height: Get.height/13,
                                              child: TextFormField(
                                                controller: homeController.txtCategory.value,
                                                decoration: InputDecoration(
                                                    hintText: "Choose Category",

                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.grey)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.grey)
                                                    )
                                                ),
                                                validator: (value) {
                                                  if(value!.isEmpty)
                                                  {
                                                    return "Please Choose Category";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(height: Get.height/60,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(onPressed: () => Get.back(), child: Text("Cancel"),),
                                                TextButton(onPressed: () {
                                                  if(homeController.key.value.currentState!.validate())
                                                  {
                                                    print("==== Start");
                                                    TodoDatabase.todoDatabase.UpadateData(task: homeController.txtTask.value.text, category:  homeController.txtCategory.value.text,id: index==0?1:index+1);
                                                    print("==== End");
                                                    homeController.GetData();
                                                    Get.back();
                                                  }
                                                  else
                                                  {
                                                    Get.snackbar("Alert","Please Add Your Data");
                                                  }
                                                }, child: Text("Update"),),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  );
                                },
                                icon: Icons.edit,
                                backgroundColor: Colors.yellowAccent,
                                label: "Edit",
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  TodoDatabase.todoDatabase.DeleteData(id: index==0?1:index+1);
                                  homeController.GetData();
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                label: "Delete",
                              ),
                            ]
                        ),
                        child: Container(
                      height: Get.height/12,
                      child: Row(
                        children: [
                          Container(
                            height: Get.height,
                            width: Get.width/45,
                            color: Colors.teal.shade300,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: Get.width/60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${homeController.TodoList[index]['task']}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "${homeController.TodoList[index]['category']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: Get.width/73,),
                                  Divider(thickness: 1,color: Colors.grey,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    );
                  },
                ),
              ),
              Container(
                height: Get.height/21,
                width: Get.width,
                color: Colors.grey.shade300,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Get.width/15,),
                child: Text(
                    "DONE (${homeController.DoneList.length})",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              homeController.DoneList.isEmpty
                  ? Center(child: Text("Please Todo Data Slide And Click Done Button"),)
                  : Container(
                height: Get.height/3,
                width: Get.width,
                child: ListView.builder(
                  itemCount: homeController.DoneList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                homeController.txtTask.value = TextEditingController(text: "${homeController.TodoList[index]['task']}");
                                homeController.txtCategory.value = TextEditingController(text: "${homeController.TodoList[index]['category']}");
                                Get.defaultDialog(
                                    title: "Upadate Task",
                                    content: Form(
                                      key: homeController.key.value,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: Get.height/13,
                                            child: TextFormField(
                                              controller: homeController.txtTask.value,
                                              decoration: InputDecoration(
                                                  hintText: "Your Task",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      borderSide: BorderSide(color: Colors.grey)
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      borderSide: BorderSide(color: Colors.grey)
                                                  )
                                              ),
                                              validator: (value) {
                                                if(value!.isEmpty)
                                                {
                                                  return "Please Add Your Task";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: Get.height/60,),
                                          SizedBox(
                                            height: Get.height/13,
                                            child: TextFormField(
                                              controller: homeController.txtCategory.value,
                                              decoration: InputDecoration(
                                                  hintText: "Choose Category",

                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      borderSide: BorderSide(color: Colors.grey)
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      borderSide: BorderSide(color: Colors.grey)
                                                  )
                                              ),
                                              validator: (value) {
                                                if(value!.isEmpty)
                                                {
                                                  return "Please Choose Category";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: Get.height/60,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(onPressed: () => Get.back(), child: Text("Cancel"),),
                                              TextButton(onPressed: () {
                                                if(homeController.key.value.currentState!.validate())
                                                {
                                                  print("==== Start");
                                                  DoneDatabase.doneDatabase.UpadateData(task: homeController.txtTask.value.text, category:  homeController.txtCategory.value.text,id: index==0?1:index+1);
                                                  print("==== End");
                                                  homeController.GetData2();
                                                  Get.back();
                                                }
                                                else
                                                {
                                                  Get.snackbar("Alert","Please Add Your Data");
                                                }
                                              }, child: Text("Update"),),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                );
                              },
                              icon: Icons.edit,
                              backgroundColor: Colors.yellowAccent,
                              label: "Edit",
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                print("===delet");
                                DoneDatabase.doneDatabase.DeleteData(id: index==0?1:index+1);
                                homeController.GetData2();
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              label: "Delete",
                            ),
                          ]
                      ),
                      child: Container(
                        height: Get.height/12,
                        child: Row(
                          children: [
                            Container(
                              height: Get.height,
                              width: Get.width/45,
                              color: Colors.green,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width/60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${homeController.DoneList[index]['task']}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "${homeController.DoneList[index]['category']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: Get.width/73,),
                                    Divider(thickness: 1,color: Colors.grey,)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.BottomIndex.value,
            type: BottomNavigationBarType.shifting,
            onTap: (value) => homeController.BottomIndex.value = value,
            selectedItemColor: Colors.teal.shade300,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled,),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month,),label: "Calender"),
            ],
          ),
        ),
      ),
    );
  }
}