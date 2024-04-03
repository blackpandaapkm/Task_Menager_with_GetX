import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/style.dart';

class TaskItem {
  String id;
  String title;
  String description;
  String createdDate;
  String status;

  TaskItem({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.status,
  });
}

class TaskController extends GetxController {
  var taskItems = <TaskItem>[].obs;

  void deleteTask(String id) {
    taskItems.removeWhere((task) => task.id == id);
  }

  void updateTaskStatus(String id, String status) {
    var task = taskItems.firstWhere((task) => task.id == id);
    task.status = status;
  }
}

class TaskList extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: controller.taskItems.length,
      itemBuilder: (context, index) {
        var task = controller.taskItems[index];
        Color statusColor = colorGreen;
        if (task.status == "New") {
          statusColor = colorBlue;
        } else if (task.status == "Progress") {
          statusColor = colorOrange;
        } else if (task.status == "Canceled") {
          statusColor = colorRed;
        } else if (task.status == "Completed") {
          statusColor = colorLight;
        }

        return Card(
          child: ItemSizeBox(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Head6Text(colorDarkBlue),
                ),
                Text(
                  task.description,
                  style: Head7Text(colorLightGray),
                ),
                Text(
                  task.createdDate,
                  style: Head9Text(colorDarkBlue),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusChild(task.status, statusColor),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.updateTaskStatus(
                                    task.id, "InProgress");
                              },
                              child: Icon(Icons.edit_location_alt_outlined,
                                  size: 16),
                              style:
                              AppStatusButtonStyle(colorBlue),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.deleteTask(task.id);
                              },
                              child: Icon(Icons.delete_outlined,
                                  size: 16),
                              style:
                              AppStatusButtonStyle(colorRed),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
