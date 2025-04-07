import 'package:flutter/material.dart';

enum TaskStatus { newTask, progressTask, completeTask, cancelledTask }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.chipText, required this.taskStatus});
  final String chipText;
  final TaskStatus taskStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "title",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text("description"),
            Text("date: 3/25/25"),
            Row(
              children: [
                Chip(
                  label: Text(chipText, style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                TextButton(onPressed: () {}, child: Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (taskStatus) {
      case TaskStatus.newTask:
        color = Colors.blue;
      case TaskStatus.progressTask:
        color = Colors.purpleAccent;
      case TaskStatus.cancelledTask:
        color = Colors.red;
      case TaskStatus.completeTask:
        color = Colors.green;
    }
    return color;
  }
}
