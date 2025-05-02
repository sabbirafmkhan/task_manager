import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTasksInProgress = false;
  bool get getNewTasksInProgress => _getNewTasksInProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _getNewTasksInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMessage;
    }
    _getNewTasksInProgress = false;
    update();

    return isSuccess;
  }
}
