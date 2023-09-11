import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the Resources Provider provider class
class KitchenResourcesProvider extends ChangeNotifier {
  final List<String> _addKitchenResources = [];

  List<String> get addKitchenResources => _addKitchenResources;

  List<String> addKitchenResourcesValue(String kitchenResources, int index) {
    _addKitchenResources.add(kitchenResources);
    notifyListeners();
    return addKitchenResources;
  }

  List<String> removeKitchenResourcesValue(String kitchenResources, int index) {
    _addKitchenResources.remove(kitchenResources);
    notifyListeners();
    return addKitchenResources;
  }

  final List<RecipesParameterClass> _kitchenResourcesRecipesParameters = [];

  List<RecipesParameterClass> get kitchenResourcesRecipesParameters =>
      _kitchenResourcesRecipesParameters;

  List<RecipesParameterClass> preferredKitchenResourcesParametersRecipe = [
    RecipesParameterClass(parameter: 'Blender'),
    RecipesParameterClass(parameter: 'Cutting board'),
    RecipesParameterClass(parameter: 'Frying pan'),
    RecipesParameterClass(parameter: 'knife'),
    RecipesParameterClass(parameter: 'Salad spinner'),
    RecipesParameterClass(parameter: 'Sheet pan'),
    RecipesParameterClass(parameter: 'Measuring cup'),
    RecipesParameterClass(parameter: 'Measuring spoon'),
    RecipesParameterClass(parameter: 'Whisk'),
    RecipesParameterClass(parameter: 'Tongs'),
    RecipesParameterClass(parameter: 'Bowl'),
    RecipesParameterClass(parameter: 'Oven'),
    RecipesParameterClass(parameter: 'Microwave'),
    RecipesParameterClass(parameter: 'Food Processor'),
    RecipesParameterClass(parameter: 'Slow Cooker'),
  ];

  void showKitchenResourcesParameterDetails(context, String parameter) {
    if (parameter == "Kitchen Resources") {
      _kitchenResourcesRecipesParameters
          .addAll(preferredKitchenResourcesParametersRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: parameter,
              recipesParameters: preferredKitchenResourcesParametersRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleKitchenResourcesRecipeState(int index) {
    _kitchenResourcesRecipesParameters[index].isChecked =
        !_kitchenResourcesRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearKitchenResourcesAllCheckboxStates() {
    for (var parameter in _kitchenResourcesRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }

  void removeKitchenResources() {
    if (_addKitchenResources.isNotEmpty) {
      _addKitchenResources.clear();
    }
  }

  void addNextPage(BuildContext context) {
    _kitchenResourcesRecipesParameters
        .addAll(preferredKitchenResourcesParametersRecipe);
    var newScreen = RecipesSelection(
      parameter: "Kitchen Resources",
      recipesParameters: preferredKitchenResourcesParametersRecipe,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => newScreen),
    );
    notifyListeners();
  }
}
