import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
        ),
      ),
      home: const SplashScreen(),
    );
  }

  OutlineInputBorder _getZeroBorder() {
    return const OutlineInputBorder(borderSide: BorderSide.none);
  }
}
