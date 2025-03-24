import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widgets/summary_card.dart';
import 'package:task_manager/UI/Widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: ListView.separated(
              itemCount: 6,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const TaskCard(chipText: "New", chipColor: Colors.blue);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_circle_sharp),
      ),
    );
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SummaryCard(count: 12, title: "New"),
            SummaryCard(count: 12, title: "Progress"),
            SummaryCard(count: 5, title: "Complete"),
            SummaryCard(count: 0, title: "Cancelled"),
          ],
        ),
      ),
    );
  }
}
