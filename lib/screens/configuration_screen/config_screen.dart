import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/index.dart';
import 'package:todo_app/router.dart' as router;

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List",
      debugShowCheckedModeBanner: false,
      home: createContent(),
      onGenerateRoute: router.generateRoute,
    );
  }

  createContent() {
    // return OnBoardingScreen();
    // return PersonalListScreen();
    // return PersonalListSample01Screen();
    return TodoListScreen();
  }
}
