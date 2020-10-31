import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/configuration_screen/config_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(ConfigScreen());
}
