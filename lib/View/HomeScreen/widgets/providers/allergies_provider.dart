import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the allergies provider class
class AllergiesProvider extends ChangeNotifier {
  final List<String> _addAllergies = [];

  List<String> get addAllergies => _addAllergies;

  List<String> addAllergiesValue(String allergies, int index) {
    _addAllergies.add(allergies);
    notifyListeners();
    return addAllergies;
  }

  List<String> removeAllergiesValue(String allergies, int index) {
    _addAllergies.remove(allergies);
    notifyListeners();
    return addAllergies;
  }

  final List<RecipesParameterClass> _allergiesRecipesParameters = [];

  List<RecipesParameterClass> get allergiesRecipesParameters =>
      _allergiesRecipesParameters;

  List<RecipesParameterClass> preferredAllergiesRecipe = [];

  void showAllergiesParameterDetails(context, String parameter) {
    if (parameter == "Allergies") {
      _allergiesRecipesParameters.addAll(preferredAllergiesRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: parameter,
              recipesParameters: preferredAllergiesRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleAllergiesRecipeState(int index) {
    _allergiesRecipesParameters[index].isChecked =
        !_allergiesRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearAllergiesAllCheckboxStates() {
    for (var parameter in _allergiesRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }

  void removeAllergyParams() {
    if (_addAllergies.isNotEmpty) {
      _addAllergies.clear();
    }
  }
}
