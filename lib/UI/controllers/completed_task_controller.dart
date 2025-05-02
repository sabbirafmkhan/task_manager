import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<TaskModel> _completedTaskList = [];
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getAllCompletedTaskList() async {
    bool isSuccess = false;

    _getCompletedTasksInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
    } else {
      _errorMassage = response.errorMessage;
    }

    _getCompletedTasksInProgress = false;
    update();

    return isSuccess;
  }
}
