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
import 'package:flutter_svg/flutter_svg.dart';
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
  // Capitalize the first letter of each sentence
  String capitalizeSentences(String input) {
    if (input.isEmpty) return input;

    final sentences = input.split(RegExp(r'(?<=[.!?])\s+'));

    final capitalizedSentences = sentences.map((sentence) {
      if (sentence.isNotEmpty) {
        final firstLetter = sentence[0].toUpperCase();
        final restOfSentence = sentence.substring(1).toLowerCase();
        return '$firstLetter$restOfSentence';
      } else {
        return sentence;
      }
    });

    return capitalizedSentences.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: AppTheme.appColor,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: SvgPicture.asset(
              "assets/images/Cancel.svg",
              color: AppTheme.whiteColor,
              width: 10,
              height: 10,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(60), // Adjust the height as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizeSentences(widget.parameter),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Select your parameters.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                allListsProviders(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, right: 10),
        child: FloatingActionButton(
          backgroundColor: AppTheme.whiteColor,
          onPressed: () {
            Navigator.of(context).pop();
            // if (widget.parameter == "Allergies") {
            //   Provider.of<DietaryRestrictionsProvider>(context, listen: false)
            //       .addNextPage(context);
            // } else if (widget.parameter == "Dietary Restrictions") {
            //   Provider.of<PreferredProteinProvider>(context, listen: false)
            //       .addNextPage(context);
            // } else if (widget.parameter == "Preferred Protein") {
            //   Provider.of<RegionalDelicacyProvider>(context, listen: false)
            //       .addNextPage(context);
            // } else if (widget.parameter == "Regional Delicacy") {
            //   Provider.of<KitchenResourcesProvider>(context, listen: false)
            //       .addNextPage(context);
            // } else if (widget.parameter == "Kitchen Resources") {
            //
            // }
          },
          child: Icon(
            Icons.arrow_forward,
            color: AppTheme.appColor,
            size: 40,
          ),
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
                  if (recipeProvider
                          .preferredAllergiesRecipe[index].isChecked ==
                      false) {
                    recipeProvider.toggleAllergiesRecipeState(index);
                    recipeProvider.addAllergiesValue(
                        recipesParams.parameter, index);
                    // recipeProvider.addAllergieslistIndex(index);
                  } else {
                    recipeProvider.toggleAllergiesRecipeState(index);
                    recipeProvider.removeAllergiesValue(
                        recipesParams.parameter, index);
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
    } else if (widget.parameter == "Dietary Restrictions") {
      return Consumer<DietaryRestrictionsProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredDietaryRestrictionsParametersRecipe
                    .length, (index) {
              final recipesParams = recipeProvider
                  .preferredDietaryRestrictionsParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider
                          .preferredDietaryRestrictionsParametersRecipe[index]
                          .isChecked ==
                      false) {
                    recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                    recipeProvider.addDietaryRestrictionsValue(
                        recipesParams.parameter, index);
                  //  recipeProvider.addDietaryRestrictionslistIndex(index);
                  } else {
                    recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                    recipeProvider.removeDietaryRestrictionsValue(
                        recipesParams.parameter, index);
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
    } else if (widget.parameter == "Preferred Protein") {
      return Consumer<PreferredProteinProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredProteinRecipe.length, (index) {
              final recipesParams =
                  recipeProvider.preferredProteinRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider.preferredProteinRecipe[index].isChecked ==
                      false) {
                    recipeProvider.toggleProteinRecipeState(index);
                    recipeProvider.addProteinValue(
                        recipesParams.parameter, index);
                    //recipeProvider.addProtienlistIndex(index);
                  } else {
                    recipeProvider.toggleProteinRecipeState(index);
                    recipeProvider.removeProteinValue(
                        recipesParams.parameter, index);
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
    } else if (widget.parameter == "Regional Delicacy") {
      return Consumer<RegionalDelicacyProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredRegionalDelicacyParametersRecipe.length,
                (index) {
              final recipesParams = recipeProvider
                  .preferredRegionalDelicacyParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider
                          .preferredRegionalDelicacyParametersRecipe[index]
                          .isChecked ==
                      false) {
                    recipeProvider.toggleRegionalDelicacyRecipeState(index);
                    recipeProvider.addRegionalDelicacyValue(
                        recipesParams.parameter, index);
                //    recipeProvider.addRegionalDelicacylistIndex(index);
                  } else {
                    recipeProvider.toggleRegionalDelicacyRecipeState(index);
                    recipeProvider.removeRegionalDelicacyValue(
                        recipesParams.parameter, index);
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
    } else if (widget.parameter == "Kitchen Resources") {
      return Consumer<KitchenResourcesProvider>(
        builder: (context, recipeProvider, _) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                recipeProvider.preferredKitchenResourcesParametersRecipe.length,
                (index) {
              final recipesParams = recipeProvider
                  .preferredKitchenResourcesParametersRecipe[index];
              return GestureDetector(
                onTap: () {
                  if (recipeProvider
                          .preferredKitchenResourcesParametersRecipe[index]
                          .isChecked ==
                      false) {
                    recipeProvider.toggleKitchenResourcesRecipeState(index);
                    recipeProvider.addKitchenResourcesValue(
                        recipesParams.parameter, index);
                   // recipeProvider.addKitchenResourceslistIndex(index);
                  } else {
                    recipeProvider.toggleKitchenResourcesRecipeState(index);
                    recipeProvider.removeKitchenResourcesValue(
                        recipesParams.parameter, index);
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
