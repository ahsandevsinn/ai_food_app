import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the dietary restrictions provider class
class DietaryRestrictionsProvider extends ChangeNotifier {
  final List<String> _addDietaryRestrictions = [];

  List<String> get addDietaryRestrictions => _addDietaryRestrictions;

  List<String> addDietaryRestrictionsValue(String restrictions, int index) {
    _addDietaryRestrictions.add(restrictions);
    notifyListeners();
    return addDietaryRestrictions;
  }

  List<String> removeDietaryRestrictionsValue(String restrictions, int index) {
    _addDietaryRestrictions.remove(restrictions);
    notifyListeners();
    return addDietaryRestrictions;
  }

  final List<RecipesParameterClass> _dietaryRestrictionsRecipesParameters = [];

  List<RecipesParameterClass> get dietaryRestrictionsRecipesParameters =>
      _dietaryRestrictionsRecipesParameters;

  List<RecipesParameterClass> preferredDietaryRestrictionsParametersRecipe = [];

  void showDietaryRestrictionsParameterDetails(context, String parameter) {
    if (parameter == "Dietary Restrictions") {
      _dietaryRestrictionsRecipesParameters
          .addAll(preferredDietaryRestrictionsParametersRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: parameter,
              recipesParameters: preferredDietaryRestrictionsParametersRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleDietaryRestrictionsRecipeState(int index) {
    _dietaryRestrictionsRecipesParameters[index].isChecked =
        !_dietaryRestrictionsRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearDietaryRestrictionsAllCheckboxStates() {
    for (var parameter in _dietaryRestrictionsRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }

  void removeDietaryRestrictions() {
    if (_addDietaryRestrictions.isNotEmpty) {
      _addDietaryRestrictions.clear();
    }
  }

  void addNextPage(BuildContext context) {
    _dietaryRestrictionsRecipesParameters
        .addAll(preferredDietaryRestrictionsParametersRecipe);
    var newScreen = RecipesSelection(
      parameter: "Dietary Restrictions",
      recipesParameters: preferredDietaryRestrictionsParametersRecipe,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => newScreen),
    );
    notifyListeners();
  }
}
