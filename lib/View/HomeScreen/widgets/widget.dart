import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/material.dart';

class CustomRecipesSelection extends StatelessWidget {
  final String recipeText;
  final Function() onTap;
  const CustomRecipesSelection({Key? key, required this.recipeText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            border: Border.all(color: AppTheme.appColor,width: 2)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.appText(
                  // "Allergies",
                  recipeText,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: AppTheme.appColor),
              Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.appColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
