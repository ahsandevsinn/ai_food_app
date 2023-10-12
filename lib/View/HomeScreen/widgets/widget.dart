import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRecipesSelection extends StatelessWidget {
  final String recipeText;
  final showListDataInChip;
  final widget;
  final Function() onTap;

  const CustomRecipesSelection(
      {Key? key,
      required this.recipeText,
      required this.onTap,
      this.showListDataInChip, this.widget,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return showListDataInChip.isEmpty? GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            border: Border.all(color: AppTheme.appColor, width: 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.appText(recipeText,
                  fontSize: 15,
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
    ):Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          border: Border.all(color: AppTheme.appColor, width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.appText("${recipeText}: ",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  textColor: AppTheme.appColor),
              Expanded(child: widget,),
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
