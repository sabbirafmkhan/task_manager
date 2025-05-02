import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/UI/Widgets/snack_bar_message.dart';
import 'package:task_manager/UI/Widgets/task_card.dart';
import 'package:task_manager/UI/controllers/completed_task_controller.dart';
import 'package:get/get.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.getCompletedTasksInProgress == false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.completed,
                  taskModel: controller.completedTaskList[index],
                  refreshList: _getAllCompletedTaskList,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
        },
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    final bool isSuccess =
        await _completedTaskController.getAllCompletedTaskList();
    if (isSuccess) {
      showSnackBarMessage(
        context,
        _completedTaskController.errorMassage!,
        true,
      );
    }
  }
}
