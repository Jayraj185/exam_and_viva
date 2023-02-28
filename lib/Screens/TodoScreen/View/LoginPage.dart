import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:exam_and_viva/Screens/TodoScreen/Model/LoginModel.dart';
import 'package:exam_and_viva/Utils/SharedPreffrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.txtLoginEmail.value.clear();
    homeController.txtLoginPass.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(""),
          title: Text("Login TODO App",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.teal.shade300,
        ),
        body: Form(
          key: homeController.loginkey.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width/15),
                  child: Text(
                    "Email*",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: Get.height/16,
                  width: Get.width/1.1,
                  margin: EdgeInsets.only(top: Get.width/30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextFormField(
                    controller: homeController.txtLoginEmail.value,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.teal),
                      prefixIcon: Icon(Icons.mail,color: Colors.teal,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.teal)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.teal)
                      )
                    ),
                    validator: (value) {
                      if(value!.isEmpty)
                        {
                          return "Please Enter Your Email";
                        }
                      else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width/15,top: Get.width/15),
                  child: Text(
                    "Password*",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: Get.height/16,
                  width: Get.width/1.1,
                  margin: EdgeInsets.only(top: Get.width/30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextFormField(
                    controller: homeController.txtLoginPass.value,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.teal),
                        prefixIcon: Icon(Icons.lock,color: Colors.teal,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.teal)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.teal)
                        )
                    ),
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Please Enter Your Password";
                      }
                      else if(value.length != 6)
                      {
                        return "Please Add max. 6 Letter password";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: Get.width/15,),
              SizedBox(
                  height: Get.height/18,
                  width: Get.width/3,
                  child: ElevatedButton(onPressed: () async {
                    if(homeController.loginkey.value.currentState!.validate())
                      {
                        LoginModel login = await readShared();
                        if(login.email == homeController.txtLoginEmail.value.text && login.pass == homeController.txtLoginPass.value.text)
                          {
                            IsLogin(login: true);
                            Get.offNamed('todo');
                          }
                        else
                          {
                            Get.snackbar("Alert", "Please Enter Your Valid Email & Password");
                          }
                      }
                    else
                      {
                        Get.snackbar("Alert", "Please Enter Your Email & Password");
                      }
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),))
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width/15,top: Get.width/15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create New Account",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp
                        ),
                      ),
                      SizedBox(width: Get.width/60,),
                      InkWell(
                        onTap: (){
                          Get.offNamed('Signup');
                        },
                        child: Text(
                          "Sign-up",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 12.sp
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
