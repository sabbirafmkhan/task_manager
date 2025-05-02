import 'package:get/get.dart';
import 'package:task_manager/UI/controllers/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
