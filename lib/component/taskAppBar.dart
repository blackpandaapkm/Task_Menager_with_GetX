import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_menager_with_getx/style/style.dart';
import 'package:task_menager_with_getx/utility/utility.dart';

class ProfileController extends GetxController {
  var profileData = {}.obs;

  @override
  void onInit() {
    // Fetch profile data when the controller is initialized
    fetchProfileData();
    super.onInit();
  }

  void fetchProfileData() {
    // Simulated profile data, replace this with your actual data fetching logic
    var data = {
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      // Add more fields as needed
    };
    profileData.value = data;
  }

  void logout() async {
    // Perform logout actions here
    await removeToken();
    Get.offAllNamed("/login");
  }
}

class TaskAppBar extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorGreen,
      flexibleSpace: Container(
        margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              child: ClipOval(
                child: Image.memory(
                  showBase64Image(controller.profileData['photo']),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.profileData['firstName']} ${controller.profileData['lastName']}',
                  style: Head7Text(colorWhite),
                ),
                Text(
                  controller.profileData['email'],
                  style: Head9Text(colorWhite),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed('/taskCreateScreen');
          },
          icon: Icon(Icons.add_circle_outline),
        ),
        IconButton(
          onPressed: controller.logout,
          icon: Icon(Icons.output),
        ),
      ],
    );
  }
}
