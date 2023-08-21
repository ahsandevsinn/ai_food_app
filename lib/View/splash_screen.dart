import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/View/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      pushReplacement(context, const AuthScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 50.0,
            end: 400.0,
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
}
