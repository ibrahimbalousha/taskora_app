import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/widgets/%D9%90AppElevatedButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: AddTaskButton(
            width: 200,
            height: 70,
            icon: Icon(Icons.add_box, color: Colors.white),
            iconPadding: 12,
            onPressed: () {},
            label: 'Add Task',
          ),
        ),
      ),
    );
  }
}
