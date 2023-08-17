import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Controller/provider/login_provider.dart';
import 'package:ai_food/View/splash_screen.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:ai_food/spoonacular/screens/bottom_nav_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<RecipesParameterProvider>(create: (_) => RecipesParameterProvider()),
        ChangeNotifierProvider<ProteinProvider>(create: (_) => ProteinProvider()),
        ChangeNotifierProvider<StyleProvider>(create: (_) => StyleProvider()),
        ChangeNotifierProvider<AllergiesProvider>(create: (_) => AllergiesProvider()),
        ChangeNotifierProvider<ChatBotProvider>(create: (_) => ChatBotProvider()),
        ChangeNotifierProvider<ServiceSizeProvider>(create: (_) => ServiceSizeProvider()),
        ChangeNotifierProvider<KitchenResourcesProvider>(create: (_) => KitchenResourcesProvider()),
        ChangeNotifierProvider<DietaryRestrictionsProvider>(create: (_) => DietaryRestrictionsProvider()),
        ChangeNotifierProvider<RegionalDelicacyProvider>(create: (_) => RegionalDelicacyProvider()),
      ],
      child: MaterialApp(
        title: 'AIFood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
        ),
        // home: BottomNavView(),
        home: SplashScreen(),
      ),
    );
  }
}

