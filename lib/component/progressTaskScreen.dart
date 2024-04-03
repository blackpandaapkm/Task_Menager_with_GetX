import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_menager_with_getx/api/apiClient.dart';
import '../style/style.dart';
import 'package:task_menager_with_getx/component/TaskList.dart';

class ProgressTaskController extends GetxController {
  var taskItems = [].obs;
  var loading = true.obs;
  var status = "Progress".obs;

  @override
  void onInit() {
    callData();
    super.onInit();
  }

  void callData() async {
    loading.value = true;
    var data = await TaskListRequest(status.value);
    taskItems.assignAll(data);
    loading.value = false;
  }

  void deleteItem(id) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete !"),
          content: Text("Once deleted, you can't get it back"),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Get.back();
                loading.value = true;
                await TaskDeleteRequest(id);
                callData();
              },
              child: Text('Yes'),
            ),
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void updateStatus(id) async {
    loading.value = true;
    await TaskUpdateRequest(id, status.value);
    callData();
    status.value = "Progress";
  }

  void statusChange(id) async {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(30),
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Radio buttons
                  ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Confirm'),
                    onPressed: () {
                      Get.back();
                      updateStatus(id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ProgressTaskScreen extends GetView<ProgressTaskController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () async {
          controller.callData();
        },
        child: TaskList(
          controller.taskItems,
          controller.deleteItem,
          controller.statusChange,
        ),
      ),
    );
  }
}
