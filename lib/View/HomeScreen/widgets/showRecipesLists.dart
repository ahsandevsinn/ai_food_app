import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesSelection extends StatefulWidget {
  final String parameter;
  final List<RecipesParameterClass> recipesParameters;
  const RecipesSelection(
      {Key? key, required this.parameter, required this.recipesParameters})
      : super(key: key);

  @override
  State<RecipesSelection> createState() => _RecipesSelectionState();
}

class _RecipesSelectionState extends State<RecipesSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.appColor,
        leading: IconButton(
          icon: const Icon(Icons.close, size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.appText(
                  widget.parameter,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  textColor: AppTheme.whiteColor,
                ),
                AppText.appText(
                  "Lorem ipsum is just simply dummy text.",
                  fontSize: 16,
                  textColor: AppTheme.whiteColor,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: allListsProviders(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, size: 30,color: AppTheme.appColor,),
                      onPressed: () {
                        if (widget.parameter == "Allergies") {
                          Provider.of<DietaryRestrictionsProvider>(context, listen: false).addNextPage(context);
                        } else if(widget.parameter == "Dietary Restrictions"){
                          Provider.of<PreferredProteinProvider>(context, listen: false).addNextPage(context);
                        } else if(widget.parameter == "Preferred Protein"){
                          Provider.of<RegionalDelicacyProvider>(context, listen: false).addNextPage(context);
                        } else if(widget.parameter == "Regional Delicacy"){
                          Provider.of<KitchenResourcesProvider>(context, listen: false).addNextPage(context);
                        } else if(widget.parameter == "Kitchen Resources"){
                          Navigator.of(context).pop();
                        }
                      },

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allListsProviders() {
    if (widget.parameter == "Allergies") {
      return Consumer<AllergiesProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredAllergiesRecipe.length, (index) {
              final recipesParams =
                  recipeProvider.preferredAllergiesRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredAllergiesRecipe[index].isChecked == false) {
                    recipeProvider.toggleAllergiesRecipeState(index);
                    recipeProvider.addAllergiesValue(recipesParams.parameter, index);
                  } else {
                    recipeProvider.toggleAllergiesRecipeState(index);
                    recipeProvider.removeAllergiesValue(recipesParams.parameter, index);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: recipesParams.isChecked
                          ? AppTheme.whiteColor
                          : AppTheme.appColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: recipesParams.isChecked
                              ? AppTheme.appColor
                              : AppTheme.whiteColor,
                          width: 2)),
                  child: AppText.appText(
                    recipesParams.parameter,
                    textColor: recipesParams.isChecked
                        ? AppTheme.appColor
                        : AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          );
        },
      );
    } else if(widget.parameter == "Dietary Restrictions"){
      return Consumer<DietaryRestrictionsProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredDietaryRestrictionsParametersRecipe.length, (index) {
              final recipesParams = recipeProvider.preferredDietaryRestrictionsParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredDietaryRestrictionsParametersRecipe[index].isChecked == false) {
                    recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                    recipeProvider.addDietaryRestrictionsValue(recipesParams.parameter, index);
                  } else {
                    recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                    recipeProvider.removeDietaryRestrictionsValue(recipesParams.parameter, index);
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: recipesParams.isChecked
                          ? AppTheme.whiteColor
                          : AppTheme.appColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: recipesParams.isChecked
                              ? AppTheme.appColor
                              : AppTheme.whiteColor,
                          width: 2),
                  ),
                  child: AppText.appText(
                    recipesParams.parameter,
                    textColor: recipesParams.isChecked
                        ? AppTheme.appColor
                        : AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          );
        },
      );
    } else if (widget.parameter == "Preferred Protein"){
      return Consumer<PreferredProteinProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredProteinRecipe.length, (index) {
              final recipesParams = recipeProvider.preferredProteinRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredProteinRecipe[index].isChecked == false) {
                    recipeProvider.toggleProteinRecipeState(index);
                    recipeProvider.addProteinValue(recipesParams.parameter, index);
                  } else {
                    recipeProvider.toggleProteinRecipeState(index);
                    recipeProvider.removeProteinValue(recipesParams.parameter, index);
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: recipesParams.isChecked
                        ? AppTheme.whiteColor
                        : AppTheme.appColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: recipesParams.isChecked
                            ? AppTheme.appColor
                            : AppTheme.whiteColor,
                        width: 2),
                  ),
                  child: AppText.appText(
                    recipesParams.parameter,
                    textColor: recipesParams.isChecked
                        ? AppTheme.appColor
                        : AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          );
        },
      );
    } else if (widget.parameter == "Regional Delicacy"){
      return Consumer<RegionalDelicacyProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredRegionalDelicacyParametersRecipe.length, (index) {
              final recipesParams = recipeProvider.preferredRegionalDelicacyParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredRegionalDelicacyParametersRecipe[index].isChecked == false) {
                    recipeProvider.toggleRegionalDelicacyRecipeState(index);
                    recipeProvider.addRegionalDelicacyValue(recipesParams.parameter, index);
                  } else {
                    recipeProvider.toggleRegionalDelicacyRecipeState(index);
                    recipeProvider.removeRegionalDelicacyValue(recipesParams.parameter, index);
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: recipesParams.isChecked
                        ? AppTheme.whiteColor
                        : AppTheme.appColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: recipesParams.isChecked
                            ? AppTheme.appColor
                            : AppTheme.whiteColor,
                        width: 2),
                  ),
                  child: AppText.appText(
                    recipesParams.parameter,
                    textColor: recipesParams.isChecked
                        ? AppTheme.appColor
                        : AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          );
        },
      );
    } else if(widget.parameter == "Kitchen Resources"){
      return Consumer<KitchenResourcesProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredKitchenResourcesParametersRecipe.length, (index) {
              final recipesParams = recipeProvider.preferredKitchenResourcesParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredKitchenResourcesParametersRecipe[index].isChecked == false) {
                    recipeProvider.toggleKitchenResourcesRecipeState(index);
                    recipeProvider.addKitchenResourcesValue(recipesParams.parameter, index);
                  } else {
                    recipeProvider.toggleKitchenResourcesRecipeState(index);
                    recipeProvider.removeKitchenResourcesValue(recipesParams.parameter, index);
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: recipesParams.isChecked
                        ? AppTheme.whiteColor
                        : AppTheme.appColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: recipesParams.isChecked
                            ? AppTheme.appColor
                            : AppTheme.whiteColor,
                        width: 2),
                  ),
                  child: AppText.appText(
                    recipesParams.parameter,
                    textColor: recipesParams.isChecked
                        ? AppTheme.appColor
                        : AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          );
        },
      );
    }
    return Container();
  }
}
