import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: 400,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.appColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Authentication",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
