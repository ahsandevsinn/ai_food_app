
import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/auth/auth_screen.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    gettingfilterfromonBoardScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2CFEB),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 50.0,
            end: 500.0,
          ),
          duration: const Duration(seconds: 3),
          curve: Curves.easeInToLinear,
          builder: (context, val, child) {
            return SizedBox(
              width: val,
              height: val,
              child: Image.asset(AppAssetsImages.appLogo),
            );
          },
        ),
      ),
    );
  }
  void gettingfilterfromonBoardScreen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final allergies = prefs.getStringList(PrefKey.dataonBoardScreenAllergies);
    final dietryRestriction = prefs.getStringList(PrefKey.dataonBoardScreenDietryRestriction);
    print("data of allergies called on splashscreen${allergies}");
    print("data of dietryRestriction called on splashscreen${dietryRestriction}");
      print("Check is that the same${user}");
      Future.delayed(const Duration(seconds: 4), () {
        user==null?  pushReplacement(context, const AuthScreen()):pushReplacement(context,  BottomNavView(type: 0,allergies: allergies,dietaryRestrictions: dietryRestriction,));
      });
    }


}


