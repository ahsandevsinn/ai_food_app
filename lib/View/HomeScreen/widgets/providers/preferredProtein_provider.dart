import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the Preferred Protein provider class
class PreferredProteinProvider extends ChangeNotifier {
  final List<String> _addProtein = [];

  List<String> get addProtein => _addProtein;

  List<String> addProteinValue(String protein, int index) {
    _addProtein.add(protein);
    notifyListeners();
    return addProtein;
  }

  List<String> removeProteinValue(String protein, int index) {
    _addProtein.remove(protein);
    notifyListeners();
    return addProtein;
  }

  final List<RecipesParameterClass> _proteinRecipesParameters = [];

  List<RecipesParameterClass> get proteinRecipesParameters =>
      _proteinRecipesParameters;

  List<RecipesParameterClass> preferredProteinRecipe = [
    RecipesParameterClass(parameter: 'Fish'),
    RecipesParameterClass(parameter: 'Seafood'),
    RecipesParameterClass(parameter: 'Lean beef'),
    RecipesParameterClass(parameter: 'Skim milk'),
    RecipesParameterClass(parameter: 'Skim yogurt'),
    RecipesParameterClass(parameter: 'Eggs'),
    RecipesParameterClass(parameter: 'Lean pork'),
    RecipesParameterClass(parameter: 'Low-fat cheese'),
    RecipesParameterClass(parameter: 'Beans'),
    RecipesParameterClass(parameter: 'Skinless, white meat - poultry'),
  ];

  void showProteinParameterDetails(context, String parameter) {
    if (parameter == "Preferred Protein") {
      _proteinRecipesParameters.addAll(preferredProteinRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: parameter, recipesParameters: preferredProteinRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleProteinRecipeState(int index) {
    _proteinRecipesParameters[index].isChecked =
        !_proteinRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearProteinAllCheckboxStates() {
    for (var parameter in _proteinRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }

  void removePreferredProtein() {
    if (_addProtein.isNotEmpty) {
      _addProtein.clear();
    }
  }
}
