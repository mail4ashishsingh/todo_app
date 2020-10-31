import 'package:flutter/material.dart';
import 'package:todo_app/screens/index.dart';
import 'router_name.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case PERSONAL_LIST_SCREEN:
      return MaterialPageRoute(builder: (context) => PersonalListScreen());
      break;

    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${routeSettings.name}')),
              ));
  }
}
