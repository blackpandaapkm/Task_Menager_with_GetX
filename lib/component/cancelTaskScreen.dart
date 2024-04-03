import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_menager_with_getx/component/TaskList.dart';
import '../api/apiClient.dart';
import '../style/style.dart';

class CancelTaskController extends GetxController {
  var taskItems = [].obs; // Observable list
  var loading = true.obs; // Observable loading state
  var status = "Canceled";

  get controller => null; // Default status

  @override
  void onInit() {
    callData(); // Fetch data on controller initialization
    super.onInit();
  }

  void callData() async {
    loading.value = true; // Set loading to true
    var data = await TaskListRequest(status);
    taskItems.assignAll(data); // Assign data to taskItems
    loading.value = false; // Set loading to false
  }

  void deleteItem(id) async {
    Get.dialog(
      AlertDialog(
        title: Text("Delete !"),
        content: Text("Once deleted, you can't get it back"),
        actions: [
          OutlinedButton(
            onPressed: () async {
              Get.back();
              loading.value = true; // Set loading to true
              await TaskDeleteRequest(id);
              controller.callData();
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
      ),
    );
  }

  void updateStatus(id) async {
    loading.value = true; // Set loading to true
    await TaskUpdateRequest(id, status);
    controller.callData();
    status = "Canceled"; // Reset status
  }

  void statusChange(id) async {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.all(30),
            height: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RadioListTile(
                  title: Text("New"),
                  value: "New",
                  groupValue: status,
                  onChanged: (value) => setState(() => status = value.toString()),
                ),
                RadioListTile(
                  title: Text("Progress"),
                  value: "Progress",
                  groupValue: status,
                  onChanged: (value) => setState(() => status = value.toString()),
                ),
                RadioListTile(
                  title: Text("Completed"),
                  value: "Completed",
                  groupValue: status,
                  onChanged: (value) => setState(() => status = value.toString()),
                ),
                RadioListTile(
                  title: Text("Canceled"),
                  value: "Canceled",
                  groupValue: status,
                  onChanged: (value) => setState(() => status = value.toString()),
                ),
                Container(
                  child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Confirm'),
                    onPressed: () {
                      Get.back();
                      updateStatus(id);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CancelTaskScreen extends GetView<CancelTaskController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () async {
          await controller.callData();
        },
        child: TaskList(controller.taskItems, controller.deleteItem, controller.statusChange),
      );
    });
  }
}
