import 'package:exam_and_viva/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    print("=== Bottom");
    super.initState();
    homeController.GetMonth();
    homeController.GetData();
    // homeController.GetData2();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => homeController.Screens[homeController.BottomIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.BottomIndex.value,
            type: BottomNavigationBarType.shifting,
            onTap: (value) => homeController.BottomIndex.value = value,
            selectedItemColor: Colors.teal.shade300,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                  label: "Calender"),
            ],
          ),
        ),
      ),
    );
  }
}
