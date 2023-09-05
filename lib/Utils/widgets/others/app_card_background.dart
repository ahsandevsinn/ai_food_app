import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';

class AppCardBackground {
static  Widget appCardBackground({
    double? width,
    double? height,
    double scale = 1.0,
    double opacity = 1.0,
    bool isAntiAlias = false,
    BoxFit? fit,
    AlignmentGeometry imageAlignment = Alignment.center,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme.appColor,
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
        image: DecorationImage(
          opacity: opacity,
          isAntiAlias: isAntiAlias == false ? false : true,
          fit: fit,
          alignment: imageAlignment,
          scale: scale,
          image: AssetImage(
            "assets/images/splash_image.png",
          ),
        ),
      ),
    );
  }
}
