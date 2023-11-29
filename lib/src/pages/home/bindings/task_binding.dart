import 'package:get/get.dart';
import 'package:task_list/src/pages/task/controller/task_controller.dart';

class TaskBinding extends Bindings{

  void dependencies() {
    Get.put(TaskController());
  }

}