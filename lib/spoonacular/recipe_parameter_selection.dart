import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/spoonacular/models/recipes_parameter_class.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesSelection extends StatefulWidget {
  final String parameter;
  final List<RecipesParameterClass> recipesParameters;

  const RecipesSelection({
    Key? key,
    required this.parameter,
    required this.recipesParameters,
  }) : super(key: key);

  @override
  State<RecipesSelection> createState() => _RecipesSelectionState();
}

class _RecipesSelectionState extends State<RecipesSelection> {
  @override
  Widget build(BuildContext context) {
    final selectedValue =
        Provider.of<RecipesParameterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: AppText(widget.parameter, color: Colors.white),
      ),
      body: allListsProviders(selectedValue),
    );
  }

  Widget allListsProviders(selectedValue) {
    if (widget.parameter == "Preferred Protein") {
      return Consumer<ProteinProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredProteinRecipe[index].parameter),
                trailing: Checkbox(
                  value: recipeProvider.preferredProteinRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if (recipeProvider.preferredProteinRecipe[index].isChecked == false) {
                      recipeProvider.toggleProteinRecipeState(index);
                      selectedValue.addProteinValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleProteinRecipeState(index);
                      selectedValue.removeProteinValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else if (widget.parameter == "Style") {
      return Consumer<StyleProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredStyleRecipe[index].parameter),
                trailing: Checkbox(
                  value: recipeProvider.preferredStyleRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if(recipeProvider.preferredStyleRecipe[index].isChecked == false){
                      recipeProvider.toggleStyleRecipeState(index);
                      selectedValue.addStyleValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleStyleRecipeState(index);
                      selectedValue.removeStyleValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else if (widget.parameter == "Allergies") {
      return Consumer<AllergiesProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredAllergiesRecipe[index].parameter),
                trailing: Checkbox(
                  value:
                      recipeProvider.preferredAllergiesRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if(recipeProvider.preferredAllergiesRecipe[index].isChecked == false){
                      recipeProvider.toggleAllergiesRecipeState(index);
                      selectedValue.addAllergiesValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleAllergiesRecipeState(index);
                      selectedValue.removeAllergiesValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else if(widget.parameter == "Service Size"){
      return Consumer<ServiceSizeProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredServiceSizeParametersRecipe[index].parameter),
                trailing: Checkbox(
                  value:
                  recipeProvider.preferredServiceSizeParametersRecipe[index].isChecked,
                  onChanged: (newValue) {
                    print("toggle_value     ${recipeProvider.preferredServiceSizeParametersRecipe[index].isChecked}");
                    if(recipeProvider.preferredServiceSizeParametersRecipe[index].isChecked == false){
                      recipeProvider.toggleServiceSizeRecipeState(index);
                      selectedValue.addServiceSizeValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleServiceSizeRecipeState(index);
                      selectedValue.removeServiceSizeValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else if(widget.parameter == "Kitchen Resources"){
      return Consumer<KitchenResourcesProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredKitchenResourcesParametersRecipe[index].parameter),
                trailing: Checkbox(
                  value:
                  recipeProvider.preferredKitchenResourcesParametersRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if(recipeProvider.preferredKitchenResourcesParametersRecipe[index].isChecked == false){
                      recipeProvider.toggleKitchenResourcesRecipeState(index);
                      selectedValue.addKitchenResourcesValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleKitchenResourcesRecipeState(index);
                      selectedValue.removeKitchenResourcesValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else if(widget.parameter == "Dietary Restrictions"){
      return Consumer<DietaryRestrictionsProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredDietaryRestrictionsParametersRecipe[index].parameter),
                trailing: Checkbox(
                  value:
                  recipeProvider.preferredDietaryRestrictionsParametersRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if(recipeProvider.preferredDietaryRestrictionsParametersRecipe[index].isChecked == false){
                      recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                      selectedValue.addDietaryRestrictionsValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleDietaryRestrictionsRecipeState(index);
                      selectedValue.removeDietaryRestrictionsValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    } else {
      return Consumer<RegionalDelicacyProvider>(
        builder: (context, recipeProvider, _) {
          return ListView.builder(
            itemCount: widget.recipesParameters.length,
            itemBuilder: (context, index) {
              final recipesParams = widget.recipesParameters[index];
              return ListTile(
                title: AppText(
                    recipeProvider.preferredRegionalDelicacyParametersRecipe[index].parameter),
                trailing: Checkbox(
                  value:
                  recipeProvider.preferredRegionalDelicacyParametersRecipe[index].isChecked,
                  onChanged: (newValue) {
                    if(recipeProvider.preferredRegionalDelicacyParametersRecipe[index].isChecked == false){
                      recipeProvider.toggleRegionalDelicacyRecipeState(index);
                      selectedValue.addRegionalDelicacyValue(recipesParams.parameter, index);
                    } else {
                      recipeProvider.toggleRegionalDelicacyRecipeState(index);
                      selectedValue.removeRegionalDelicacyValue(recipesParams.parameter, index);
                    }
                  },
                ),
              );
            },
          );
        },
      );
    }
  }
}
