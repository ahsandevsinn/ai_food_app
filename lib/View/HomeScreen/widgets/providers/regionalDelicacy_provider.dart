import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the Regional Delicacy provider class
class RegionalDelicacyProvider extends ChangeNotifier {
  final List<String> _addRegionalDelicacy = [];

  List<String> get addRegionalDelicacy => _addRegionalDelicacy;

  List<String> addRegionalDelicacyValue(String delicacy, int index) {
    _addRegionalDelicacy.add(delicacy);
    notifyListeners();
    return addRegionalDelicacy;
  }

  List<String> removeRegionalDelicacyValue(String delicacy, int index) {
    _addRegionalDelicacy.remove(delicacy);
    notifyListeners();
    return addRegionalDelicacy;
  }

  final List<RecipesParameterClass> _regionalDelicacyRecipesParameters = [];

  List<RecipesParameterClass> get regionalDelicacyRecipesParameters =>
      _regionalDelicacyRecipesParameters;

  List<RecipesParameterClass> preferredRegionalDelicacyParametersRecipe = [
    RecipesParameterClass(parameter: 'Italian Pizza'),
    RecipesParameterClass(parameter: 'Mexican Tacos'),
    RecipesParameterClass(parameter: 'Japanese Sushi'),
    RecipesParameterClass(parameter: 'Chinese Dumplings'),
    RecipesParameterClass(parameter: 'Indian Curry'),
    RecipesParameterClass(parameter: 'French Baguette'),
    RecipesParameterClass(parameter: 'Italian Pasta'),
    RecipesParameterClass(parameter: 'Thai Pad Thai'),
    RecipesParameterClass(parameter: 'Greek Souvlaki'),
    RecipesParameterClass(parameter: 'American Burger'),
  ];

  void showRegionalDelicacyParameterDetails(context, String parameter) {
    if (parameter == "Regional Delicacy") {
      _regionalDelicacyRecipesParameters
          .addAll(preferredRegionalDelicacyParametersRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: parameter,
              recipesParameters: preferredRegionalDelicacyParametersRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleRegionalDelicacyRecipeState(int index) {
    _regionalDelicacyRecipesParameters[index].isChecked =
        !_regionalDelicacyRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearRegionalDelicacyAllCheckboxStates() {
    for (var parameter in _regionalDelicacyRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }

  void removeRegionalDelicacy() {
    if (_addRegionalDelicacy.isNotEmpty) {
      _addRegionalDelicacy.clear();
    }
  }

  void addNextPage(BuildContext context) {
    _regionalDelicacyRecipesParameters.addAll(preferredRegionalDelicacyParametersRecipe);
    var newScreen = RecipesSelection(
      parameter: "Regional Delicacy",
      recipesParameters: preferredRegionalDelicacyParametersRecipe,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => newScreen),
    );
    notifyListeners();
  }
}
