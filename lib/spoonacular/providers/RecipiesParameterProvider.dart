import 'dart:convert';

import 'package:ai_food/spoonacular/models/recipes_parameter_class.dart';
import 'package:ai_food/spoonacular/recipe_parameter_selection.dart';
import 'package:ai_food/spoonacular/screens/favourite_screen.dart';
import 'package:ai_food/spoonacular/screens/searched_recipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipesParameterProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool loading() {
    _isLoading = !_isLoading;
    notifyListeners();
    return isLoading;
  }

  //for protein
  final List<String> _addProtein = [];

  List<String> get addProtein => _addProtein;

  List<String> addProteinValue(String protein, int index) {
    if (_addProtein.isNotEmpty) {
      _addProtein.removeAt(0);
    }
    _addProtein.insert(0, protein);
    notifyListeners();
    return addProtein;
  }
  //ends protein

  //for style
  final List<String> _addStyle = [];

  List<String> get addStyle => _addStyle;

  List<String> addStyleValue(String style, int index) {
    if (_addStyle.isNotEmpty) {
      _addStyle.removeAt(0);
    }
    _addStyle.insert(0, style);
    notifyListeners();
    return addStyle;
  }
  //ends protein

  //for service size
  final List<String> _addServiceSize = [];

  List<String> get addServiceSize => _addServiceSize;

  List<String> addServiceSizeValue(String serviceSize, int index) {
    if (_addServiceSize.isNotEmpty) {
      _addServiceSize.removeAt(0);
    }
    _addServiceSize.insert(0, serviceSize);
    notifyListeners();
    return addServiceSize;
  }
  //ends service size

  //for kitchen resources
  final List<String> _addKitchenResources = [];

  List<String> get addKitchenResources => _addKitchenResources;

  List<String> addKitchenResourcesValue(String kitchenResources, int index) {
    if (_addKitchenResources.isNotEmpty) {
      _addKitchenResources.removeAt(0);
    }
    _addKitchenResources.insert(0, kitchenResources);
    notifyListeners();
    return addKitchenResources;
  }
  //ends kitchen resources

  //for allergies
  final List<String> _addAllergies = [];

  List<String> get addAllergies => _addAllergies;

  List<String> addAllergiesValue(String allergies, int index) {
    if (_addAllergies.isNotEmpty) {
      _addAllergies.removeAt(0);
    }
    _addAllergies.insert(0, allergies);
    notifyListeners();
    return addAllergies;
  }
  //ends allergies

  //for dietary restrictions
  final List<String> _addDietaryRestrictions = [];

  List<String> get addDietaryRestrictions => _addDietaryRestrictions;

  List<String> addDietaryRestrictionsValue(String restrictions, int index) {
    if (_addDietaryRestrictions.isNotEmpty) {
      _addDietaryRestrictions.removeAt(0);
    }
    _addDietaryRestrictions.insert(0, restrictions);
    notifyListeners();
    return addDietaryRestrictions;
  }
  //ends dietary restrictions

  //for Regional Delicacy
  final List<String> _addRegionalDelicacy = [];

  List<String> get addRegionalDelicacy => _addRegionalDelicacy;

  List<String> addRegionalDelicacyValue(String delicacy, int index) {
    if (_addRegionalDelicacy.isNotEmpty) {
      _addRegionalDelicacy.removeAt(0);
    }
    _addRegionalDelicacy.insert(0, delicacy);
    notifyListeners();
    return addRegionalDelicacy;
  }
  //ends Regional Delicacy

  final List<RecipesParameterClass> _recipesParameters = [];

  List<RecipesParameterClass> get recipesParameters => _recipesParameters;

  List<RecipesParameterClass> preferredProtein = [
    const RecipesParameterClass(
        parameter: '🍗 Chicken', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥩 Beef', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🐖 Pork', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🐟 Fish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍤 Shrimp', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🦃 Turkey', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🐑 Lamb', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌱 Tofu', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌱 Tempeh', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌱 Seitan', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥚 Eggs', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍛 Quinoa', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌿 Lentils', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥫 Beans', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌽 Peas', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍃 Edamame', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🧀 Cottage cheese',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥛 Greek yogurt',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥜 Nuts', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌰 Seeds', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥛 Dairy', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🦌 Venison', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🦬 Bison', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🐇 Rabbit', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🦆 Duck', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> styles = [
    const RecipesParameterClass(
        parameter: '🇮🇹 Italian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇨🇳 Chinese', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇲🇽 Mexican', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇯🇵 Japanese', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇮🇳 Indian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇹🇭 Thai', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇪🇸 Spanish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇫🇷 French', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇬🇷 Greek', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇰🇷 Korean', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇻🇳 Vietnamese',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇧🇷 Brazilian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇷🇺 Russian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇮🇪 Irish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇹🇷 Turkish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇸🇦 Middle Eastern',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇿🇦 South African',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇨🇦 Canadian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇺🇸 American', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🇦🇺 Australian',
        icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> serviceSize = [
    const RecipesParameterClass(
        parameter: '👤 One Person', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '👨‍👩‍👦 Small Family',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '👥 Large Gathering',
        icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> kitchenResources = [
    const RecipesParameterClass(
        parameter: '🍳 Stovetop', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍲 Oven', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥘 Slow Cooker', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥣 Blender', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍶 Microwave', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🧀 Food Processor',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍴 Grill', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> allergies = [
    const RecipesParameterClass(
        parameter: '🥜 Nuts', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥛 Dairy', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍞 Gluten', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥚 Eggs', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🐟 Fish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍤 Shellfish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍯 Soy', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> dietaryRestrictions = [
    const RecipesParameterClass(
        parameter: '🌱 Vegetarian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥦 Vegan', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥚 Lacto-vegetarian',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥛 Ovo-vegetarian',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥕 Pescatarian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍖 Paleo', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥑 Keto', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥗 Gluten-free', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> regionalDelicacy = [
    const RecipesParameterClass(
        parameter: '🍕 Italian Pizza',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🌮 Mexican Tacos',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍣 Japanese Sushi',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥟 Chinese Dumplings',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍛 Indian Curry',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🥖 French Baguette',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍝 Italian Pasta',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍤 Thai Pad Thai',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍢 Greek Souvlaki',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '🍔 American Burger',
        icon: Icon(Icons.check_box_outline_blank)),
  ];

  void showParameterDetails(context, String parameter) {
    String selectedParameter = parameter;
    if (selectedParameter == "Preferred Protein") {
      _recipesParameters.addAll(preferredProtein);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter,
              recipesParameters: preferredProtein),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Style") {
      _recipesParameters.addAll(styles);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter, recipesParameters: styles),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Service Size") {
      _recipesParameters.addAll(serviceSize);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter, recipesParameters: serviceSize),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Kitchen Resources") {
      _recipesParameters.addAll(kitchenResources);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter,
              recipesParameters: kitchenResources),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Allergies") {
      _recipesParameters.addAll(allergies);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter, recipesParameters: allergies),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Dietary Restrictions") {
      _recipesParameters.addAll(dietaryRestrictions);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter,
              recipesParameters: dietaryRestrictions),
        ),
      );
      notifyListeners();
    } else if (selectedParameter == "Regional Delicacy") {
      _recipesParameters.addAll(regionalDelicacy);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RecipesSelection(
              parameter: selectedParameter,
              recipesParameters: regionalDelicacy),
        ),
      );
      notifyListeners();
    }
  }

  // IconData getIconSelection(IconDataSelect icon) {
  //   return icon == IconDataSelect.selected
  //       ? Icons.check_box
  //       : Icons.check_box_outline_blank;
  // }

  void showSearchedRecipes(context, {required List<dynamic> showRecipes}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => SearchedRecipes(showRecipes: showRecipes),
      ),
    );
  }
  // void removeParams() {
  //   if (_addProtein.isNotEmpty) {
  //     _addProtein.removeAt(0);
  //   } else if (_addStyle.isNotEmpty) {
  //     _addStyle.removeAt(0);
  //   } else if (_addServiceSize.isNotEmpty) {
  //     _addServiceSize.removeAt(0);
  //   } else if (_addKitchenResources.isNotEmpty) {
  //     _addKitchenResources.removeAt(0);
  //   } else if (_addAllergies.isNotEmpty) {
  //     _addAllergies.removeAt(0);
  //   } else if (_addDietaryRestrictions.isNotEmpty) {
  //     _addDietaryRestrictions.removeAt(0);
  //   } else if (_addRegionalDelicacy.isNotEmpty) {
  //     _addRegionalDelicacy.removeAt(0);
  //   }
  //
  //   notifyListeners();
  // }

  void removeParams() {
    if (_addProtein.isNotEmpty) {
      _addProtein.removeAt(0);
    }
    if (_addStyle.isNotEmpty) {
      _addStyle.removeAt(0);
    }
    if (_addServiceSize.isNotEmpty) {
      _addServiceSize.removeAt(0);
    }
    if (_addKitchenResources.isNotEmpty) {
      _addKitchenResources.removeAt(0);
    }
    if (_addAllergies.isNotEmpty) {
      _addAllergies.removeAt(0);
    }
    if (_addDietaryRestrictions.isNotEmpty) {
      _addDietaryRestrictions.removeAt(0);
    }
    if (_addRegionalDelicacy.isNotEmpty) {
      _addRegionalDelicacy.removeAt(0);
    }

    notifyListeners();
  }

  final List<Map<String, dynamic>> _addFavouriteRecipes = [];
  List<Map<String, dynamic>> get addFavouriteRecipes => _addFavouriteRecipes;

  Future<void> favouriteRecipesAdded(
      {required Map<String, dynamic> favouriteRecipes}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _addFavouriteRecipes.add(favouriteRecipes);
    var encodedData = jsonEncode(_addFavouriteRecipes);
    await prefs.setString('favouriteRecipes', encodedData);
    print("getting_provider_pres $encodedData");
    notifyListeners();
  }

  // void setFavouriteRecipes () async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await prefs.setString('favouriteRecipes', jsonEncode(_addFavouriteRecipes));
  //   await prefs.setString('favouriteRecipes', jsonEncode(_addFavouriteRecipes));
  // }

  bool _changeIcon = false;
  bool get changeIcon => _changeIcon;

  bool changeIconType(){
    _changeIcon = !_changeIcon;
    notifyListeners();
    return changeIcon;
  }

}
