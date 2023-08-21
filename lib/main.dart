import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/View/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppLogger logger = AppLogger();
  logger.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'AIFood',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: BottomNavView(),
        home: SplashScreen(),
      );
    });
  }
}
