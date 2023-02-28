import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PatternPage extends StatefulWidget {
  const PatternPage({Key? key}) : super(key: key);

  @override
  State<PatternPage> createState() => _PatternPageState();
}

class _PatternPageState extends State<PatternPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
          ),
          title: Text("Pattern",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: Get.height/2,
              width: Get.width,
             margin: EdgeInsets.only(left: Get.width/15),
             child: Obx(
               () => ListView.builder(
                 itemCount: homeController.pattern.length,
                 itemBuilder: (context, index) {
                   return Text(
                       "${homeController.pattern[index]}",
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 16.sp
                     ),
                   );
                 },
               ),
             ),
             // color: Colors.red,
            ),
            SizedBox(height: Get.height/15,),
            Obx(() => Slider(
              inactiveColor: Colors.grey,
              activeColor: Colors.black,
              label: "${homeController.value.value}",
              value: homeController.value.value,
              onChanged: (value) {
                //print("===== $value");
                homeController.value.value = value;
                homeController.pattern.clear();
                for(int i=1; i<=value.round(); i++)
                  {
                    List data = [];
                    for(int j=1; j<=i; j++)
                      {
                        data.add(j);
                      }
                    homeController.pattern.add(data);
                  }
              },
              max: 10,
              min: 0,
              divisions: 10,
            ))
          ],
        )
      ),
    );
  }
}
