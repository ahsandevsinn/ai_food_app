import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/chat_bot_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/food_style_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:ai_food/View/recipe_info/recipe_info.dart';
import 'package:ai_food/View/splash_screen.dart';
import 'package:ai_food/providers/google_signin_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<GoogleSignInProvider>(
              create: (_) => GoogleSignInProvider()),
          ChangeNotifierProvider<FoodStyleProvider>(
              create: (_) => FoodStyleProvider()),
          ChangeNotifierProvider<AllergiesProvider>(
              create: (_) => AllergiesProvider()),
          ChangeNotifierProvider<DietaryRestrictionsProvider>(
              create: (_) => DietaryRestrictionsProvider()),
          ChangeNotifierProvider<PreferredProteinProvider>(
              create: (_) => PreferredProteinProvider()),
          ChangeNotifierProvider<RegionalDelicacyProvider>(
              create: (_) => RegionalDelicacyProvider()),
          ChangeNotifierProvider<KitchenResourcesProvider>(
              create: (_) => KitchenResourcesProvider()),
          ChangeNotifierProvider<ChatBotProvider>(
              create: (_) => ChatBotProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AIFood',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: BottomNavView(),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
