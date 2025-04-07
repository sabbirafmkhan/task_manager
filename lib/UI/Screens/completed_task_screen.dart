import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return const TaskCard(
            chipText: "Complete",
            taskStatus: TaskStatus.completeTask,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
