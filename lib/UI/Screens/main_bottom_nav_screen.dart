import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screens/new_task_screen.dart';
import 'package:task_manager/UI/Widgets/tm_app_bar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: "Progress",
          ),
          NavigationDestination(
            icon: Icon(Icons.done_outline),
            label: "Complete",
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancelled",
          ),
        ],
      ),
    );
  }
}
