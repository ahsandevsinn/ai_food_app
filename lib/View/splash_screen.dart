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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curve;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
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
        child: FadeTransition(
          opacity: _curve,
          child: Image.asset(AppAssetsImages.appLogo),
        ),
      ),
    );
  }
}

