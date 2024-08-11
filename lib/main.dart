import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/context_utility.dart';
import 'package:movie_app/core/utils/notify_service.dart';
import 'package:movie_app/core/utils/uni_services.dart';
import 'package:movie_app/view/mode_screen.dart';
import 'package:movie_app/view_model/movie_dashboard_view_model.dart';
import 'package:movie_app/view_model/movie_details_view_model.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieDashboardViewModel(),),
        ChangeNotifierProvider(create: (context) => MovieDetailsViewModel(),),
      ],
      child: MaterialApp(
        navigatorKey: ContextUtility.navigatorKey,
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const ModeScreen(),
      ),
    );
  }
}
