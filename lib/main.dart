import 'package:flutter/material.dart';
import 'package:movie_app/screens/mode_screen.dart';
import 'package:movie_app/utils/context_utility.dart';
import 'package:movie_app/utils/notify_service.dart';
import 'package:movie_app/utils/uni_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  await UniServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ContextUtility.navigatorKey,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ModeScreen(),
    );
  }
}
