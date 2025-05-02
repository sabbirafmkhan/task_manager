import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/UI/Screens/splash_screen.dart';
import 'package:task_manager/controller_binder.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }

  OutlineInputBorder _getZeroBorder() {
    return const OutlineInputBorder(borderSide: BorderSide.none);
  }
}
