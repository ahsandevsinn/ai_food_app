import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/View/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curve;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _controller.forward();
    _controller.addListener(() {
      setState(() {
        // Animation listener
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      pushReplacement(context, const LoginScreen());
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        // child: FadeTransition(
        //   opacity: _curve,
        //   child: Image.asset(AppAssetsImages.appLogo),
        // ),
      ),
    );
  }
}
