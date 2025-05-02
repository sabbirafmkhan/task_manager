import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<TaskModel> _cancelledTaskList = [];
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getAllCancelledTaskList() async {
    bool isSuccess = false;

    _getCancelledTasksInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.cancelledTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelledTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMessage;
    }

    _getCancelledTasksInProgress = false;
    update();

    return isSuccess;
  }
}
