import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:task_menager_with_getx/style/style.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs; // Obs for observable

  void changeIndex(int index) {
    currentIndex.value = index; // Update the currentIndex value
  }
}

GetBuilder<BottomNavBarController> appBottomNav() {
  return GetBuilder<BottomNavBarController>( // Use GetBuilder to listen to changes in the controller
    init: BottomNavBarController(), // Initialize the controller
    builder: (controller) {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "New",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled_rounded),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel_outlined),
            label: "Canceled",
          ),
        ],
        selectedItemColor: colorGreen,
        unselectedItemColor: colorLightGray,
        currentIndex: controller.currentIndex.value, // Access the currentIndex from the controller
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => controller.changeIndex(index), // Call the changeIndex method in the controller
        type: BottomNavigationBarType.fixed,
      );
    },
  );
}
