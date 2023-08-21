import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final text;
  final onTap;
  const CustomButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: width * 0.5,
        decoration: BoxDecoration(
            color: AppTheme.appColor,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: AppText.appText(
          text,
          fontSize: 20,
          fontWeight: FontWeight.w600,
              textColor: Colors.white,
        )),
      ),
    );
  }
}
