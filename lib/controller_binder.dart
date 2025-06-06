import 'package:get/get.dart';
import 'package:task_manager/UI/controllers/cancelled_task_controller.dart';
import 'package:task_manager/UI/controllers/completed_task_controller.dart';
import 'package:task_manager/UI/controllers/login_controller.dart';
import 'package:task_manager/UI/controllers/new_task_controller.dart';
import 'package:task_manager/UI/controllers/progress_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
  }
}
