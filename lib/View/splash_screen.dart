import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/auth/auth_screen.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
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
  // User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      removeSearchQueryValueFromPref();
      getUserCredentials(context);
    });
    super.initState();
  }

  void getUserCredentials(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String ? value;
    String ? value2;
    List<String> finalValue = [];
    List<String> finalValue2 = [];
    String? token = prefs.getString(PrefKey.authorization);
    print("auth_token $token");
    List<String>? storedData =prefs.getStringList(PrefKey.dataonBoardScreenAllergies);
    List<String>? storedData2 =prefs.getStringList(PrefKey.dataonBoardScreenDietryRestriction);
if(storedData!=null&&storedData2!=null){
    for (String entry in storedData) {
      String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
      List<String> parts = result.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        value  = parts[1].trim();
        finalValue.add(value);

      }
    }
    for (String entry in storedData2) {
      String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
      List<String> parts = result.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        value2  = parts[1].trim();
        finalValue2.add(value2);
      }
    }
  }
    if (token != null && token.isNotEmpty) {
      print("check what is being shown here${value}");
      prefs.setInt(PrefKey.conditiontoLoad, 1);
      pushReplacement(context, BottomNavView(type: 0,allergies: finalValue,dietaryRestrictions: finalValue2));
    } else {
      pushReplacement(context, const AuthScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2CFEB),
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
              child: Image.asset(AppAssetsImages.appLogo,),
            );
          },
        ),
      ),
    );
  }

  removeSearchQueryValueFromPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefKey.searchQueryParameter);
  }

}