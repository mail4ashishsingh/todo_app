import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/index.dart';

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List",
      debugShowCheckedModeBanner: false,
      // home: TodoListScreen(),
      home: PersonalListScreen(),
    );
  }
}
