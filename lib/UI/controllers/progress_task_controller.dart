import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTasksInProgress = false;
  bool get getProgressTasksInProgress => _getProgressTasksInProgress;

  String? _errorMassage;
  String? get errorMassage => _errorMassage;

  List<TaskModel> _progressTaskList = [];
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getAllProgressTaskList() async {
    bool isSuccess = false;

    _getProgressTasksInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progressTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMessage;
    }

    _getProgressTasksInProgress = false;
    update();

    return isSuccess;
  }
}
