import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/UI/Widgets/snack_bar_message.dart';
import 'package:task_manager/UI/Widgets/task_card.dart';
import 'package:task_manager/UI/controllers/cancelled_task_controller.dart';
import 'package:get/get.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
        builder: (controller) {
          return Visibility(
            visible: controller.getCancelledTasksInProgress == false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.cancelled,
                  taskModel: controller.cancelledTaskList[index],
                  refreshList: _getAllCancelledTaskList,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
        },
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {
    final bool isSuccess =
        await _cancelledTaskController.getAllCancelledTaskList();
    if (isSuccess) {
      showSnackBarMessage(
        context,
        _cancelledTaskController.errorMassage!,
        true,
      );
    }
  }
}
