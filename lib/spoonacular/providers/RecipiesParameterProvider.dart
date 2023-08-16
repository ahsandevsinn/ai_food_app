import 'dart:convert';

import 'package:ai_food/spoonacular/models/recipes_parameter_class.dart';
import 'package:ai_food/spoonacular/recipe_parameter_selection.dart';
import 'package:ai_food/spoonacular/screens/complex_search_recipes.dart';
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
    // if (_addProtein.isNotEmpty) {
    //   _addProtein.removeAt(0);
    // }
    // _addProtein.insert(0, protein);
    _addProtein.add(protein);
    notifyListeners();
    return addProtein;
  }

  List<String> removeProteinValue(String protein, int index) {
    _addProtein.remove(protein);
    notifyListeners();
    return addProtein;
  }
  //ends protein

  //for style
  final List<String> _addStyle = [];

  List<String> get addStyle => _addStyle;

  List<String> addStyleValue(String style, int index) {
    // if (_addStyle.isNotEmpty) {
    //   _addStyle.removeAt(0);
    // }
    // _addStyle.insert(0, style);
    _addStyle.add(style);
    notifyListeners();
    return addStyle;
  }

  List<String> removeStyleValue(String style, int index) {
    _addStyle.remove(style);
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
    // if (_addAllergies.isNotEmpty) {
    //   _addAllergies.removeAt(0);
    // }
    // _addAllergies.insert(0, allergies);
    _addAllergies.add(allergies);
    notifyListeners();
    return addAllergies;
  }

  List<String> removeAllergiesValue(String allergies, int index) {
    _addAllergies.remove(allergies);
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
    RecipesParameterClass(parameter: 'Salt'),
    RecipesParameterClass(parameter: 'Olive oil'),
    RecipesParameterClass(parameter: 'Butter'),
    RecipesParameterClass(parameter: 'Sugar'),
    RecipesParameterClass(parameter: 'Water'),
    RecipesParameterClass(parameter: 'Flour'),
    RecipesParameterClass(parameter: 'Garlic'),
    RecipesParameterClass(parameter: 'Eggs'),
    RecipesParameterClass(parameter: 'Onion'),
    RecipesParameterClass(
      parameter: 'Vanilla extract',
    ),
    RecipesParameterClass(parameter: 'Milk'),
    RecipesParameterClass(parameter: 'Kosher salt'),
    RecipesParameterClass(parameter: 'Lemon juice'),
    RecipesParameterClass(
      parameter: 'Unsalted butter',
    ),
    RecipesParameterClass(parameter: 'Black pepper'),
    RecipesParameterClass(parameter: 'Baking powder'),
    RecipesParameterClass(parameter: 'Pepper'),
    RecipesParameterClass(
      parameter: 'Salt and pepper',
    ),
    RecipesParameterClass(parameter: 'Egg'),
    RecipesParameterClass(parameter: 'Brown sugar'),
    RecipesParameterClass(parameter: 'Baking soda'),
    RecipesParameterClass(parameter: 'Garlic cloves'),
    RecipesParameterClass(parameter: 'Vegetable oil'),
    RecipesParameterClass(
      parameter: 'Granulated sugar',
    ),
    RecipesParameterClass(parameter: 'Honey'),
    RecipesParameterClass(
      parameter: 'Ground cinnamon',
    ),
    RecipesParameterClass(parameter: 'Ground pepper'),
    RecipesParameterClass(parameter: 'Cream cheese'),
    RecipesParameterClass(
      parameter: 'Parmesan cheese',
    ),
    RecipesParameterClass(parameter: 'Garlic powder'),
    RecipesParameterClass(parameter: 'Carrots'),
    RecipesParameterClass(parameter: 'Cinnamon'),
    RecipesParameterClass(parameter: 'Oregano'),
    RecipesParameterClass(parameter: 'Red onion'),
    RecipesParameterClass(parameter: 'Heavy cream'),
    RecipesParameterClass(parameter: 'Celery'),
    RecipesParameterClass(parameter: 'Chicken'),
    RecipesParameterClass(parameter: 'Sour cream'),
    RecipesParameterClass(parameter: 'Vanilla'),
    RecipesParameterClass(parameter: 'Sea salt'),
    RecipesParameterClass(parameter: 'Green onions'),
    RecipesParameterClass(parameter: 'Lime juice'),
    RecipesParameterClass(parameter: 'Soy sauce'),
    RecipesParameterClass(parameter: 'Powdered sugar'),
    RecipesParameterClass(parameter: 'Fresh parsley'),
    RecipesParameterClass(parameter: 'Bacon'),
    RecipesParameterClass(parameter: 'Cornstarch'),
    RecipesParameterClass(parameter: 'Ground cumin'),
    RecipesParameterClass(parameter: 'Tomatoes'),
    RecipesParameterClass(parameter: 'Canola oil'),
    RecipesParameterClass(parameter: 'Oil'),
    RecipesParameterClass(parameter: 'Chicken broth'),
    RecipesParameterClass(parameter: 'Maple syrup'),
    RecipesParameterClass(
      parameter: 'Red bell pepper',
    ),
    RecipesParameterClass(
      parameter: 'Canned tomatoes',
    ),
    RecipesParameterClass(parameter: 'Lemon zest'),
    RecipesParameterClass(parameter: 'Paprika'),
    RecipesParameterClass(parameter: 'Dijon mustard'),
    RecipesParameterClass(parameter: 'Chili powder'),
    RecipesParameterClass(parameter: 'Chocolate'),
    RecipesParameterClass(parameter: 'Mayonnaise'),
    RecipesParameterClass(parameter: 'White sugar'),
    RecipesParameterClass(parameter: 'Onions'),
    RecipesParameterClass(parameter: 'Fresh cilantro'),
    RecipesParameterClass(parameter: 'Parsley'),
    RecipesParameterClass(parameter: 'Cilantro'),
    RecipesParameterClass(parameter: 'Pecans'),
    RecipesParameterClass(parameter: 'Beef'),
    RecipesParameterClass(parameter: 'Ginger'),
    RecipesParameterClass(parameter: 'Garlic clove'),
    RecipesParameterClass(
      parameter: 'Red pepper flakes',
    ),
    RecipesParameterClass(parameter: 'Walnuts'),
    RecipesParameterClass(parameter: 'Cayenne pepper'),
    RecipesParameterClass(
      parameter: 'Extra virgin olive oil',
    ),
    RecipesParameterClass(parameter: 'Carrot'),
    RecipesParameterClass(parameter: 'Coconut oil'),
    RecipesParameterClass(parameter: 'Zucchini'),
    RecipesParameterClass(parameter: 'Strawberries'),
    RecipesParameterClass(
      parameter: 'Worcestershire sauce',
    ),
    RecipesParameterClass(parameter: 'Sesame oil'),
    RecipesParameterClass(parameter: 'Food dye'),
    RecipesParameterClass(parameter: 'Orange juice'),
    RecipesParameterClass(parameter: 'Potatoes'),
    RecipesParameterClass(parameter: 'Fish'),
    RecipesParameterClass(parameter: 'Tomato'),
    RecipesParameterClass(parameter: 'Juice of lemon'),
    RecipesParameterClass(parameter: 'Avocado'),
    RecipesParameterClass(parameter: 'Buttermilk'),
    RecipesParameterClass(
      parameter: 'Light brown sugar',
    ),
    RecipesParameterClass(parameter: 'Nutmeg'),
    RecipesParameterClass(
      parameter: 'Balsamic vinegar',
    ),
    RecipesParameterClass(parameter: 'Ground ginger'),
    RecipesParameterClass(parameter: 'Yellow onion'),
    RecipesParameterClass(parameter: 'Fresh ginger'),
    RecipesParameterClass(parameter: 'Egg whites'),
    RecipesParameterClass(parameter: 'Ground nutmeg'),
    RecipesParameterClass(
      parameter: 'Shredded cheddar cheese',
    ),
    RecipesParameterClass(
      parameter: 'Green bell pepper',
    ),
    RecipesParameterClass(parameter: 'Almonds'),
    RecipesParameterClass(parameter: 'Whole milk'),
    RecipesParameterClass(parameter: 'Lemon'),
    RecipesParameterClass(parameter: 'Shrimp'),
  ];

  List<RecipesParameterClass> styles = [
    RecipesParameterClass(parameter: 'African'),
    RecipesParameterClass(parameter: 'Asian'),
    RecipesParameterClass(parameter: 'American'),
    RecipesParameterClass(parameter: 'British'),
    RecipesParameterClass(parameter: 'Cajun'),
    RecipesParameterClass(parameter: 'Caribbean'),
    RecipesParameterClass(parameter: 'Chinese'),
    RecipesParameterClass(
      parameter: 'Eastern European',
    ),
    RecipesParameterClass(parameter: 'European'),
    RecipesParameterClass(parameter: 'French'),
    RecipesParameterClass(parameter: 'German'),
    RecipesParameterClass(parameter: 'Greek'),
    RecipesParameterClass(parameter: 'Indian'),
    RecipesParameterClass(parameter: 'Irish'),
    RecipesParameterClass(parameter: 'Italian'),
    RecipesParameterClass(parameter: 'Japanese'),
    RecipesParameterClass(parameter: 'Jewish'),
    RecipesParameterClass(parameter: 'Korean'),
    RecipesParameterClass(parameter: 'Latin American'),
    RecipesParameterClass(parameter: 'Mediterranean'),
    RecipesParameterClass(parameter: 'Mexican'),
    RecipesParameterClass(parameter: 'Middle Eastern'),
    RecipesParameterClass(parameter: 'Nordic'),
    RecipesParameterClass(parameter: 'Southern'),
    RecipesParameterClass(parameter: 'Spanish'),
    RecipesParameterClass(parameter: 'Thai'),
    RecipesParameterClass(parameter: 'Vietnamese'),
  ];

  List<RecipesParameterClass> serviceSize = [
    //  RecipesParameterClass(parameter: 'One Person'),
    //  RecipesParameterClass(parameter: 'Small Family'),
    //  RecipesParameterClass(parameter: 'Large Gathering'),

    RecipesParameterClass(parameter: '1'),
    RecipesParameterClass(parameter: '2'),
    RecipesParameterClass(parameter: '3'),
    RecipesParameterClass(parameter: '4'),
    RecipesParameterClass(parameter: '5'),
    RecipesParameterClass(parameter: '7'),
    RecipesParameterClass(parameter: '8'),
    RecipesParameterClass(parameter: '9'),
    RecipesParameterClass(parameter: '10'),
  ];

  List<RecipesParameterClass> kitchenResources = [
    RecipesParameterClass(parameter: 'Frying Pan'),
    RecipesParameterClass(parameter: 'Bowl'),
    RecipesParameterClass(parameter: 'Blender'),
    RecipesParameterClass(parameter: 'Oven'),
    RecipesParameterClass(parameter: 'Slow Cooker'),
    RecipesParameterClass(parameter: 'Microwave'),
    RecipesParameterClass(parameter: 'Food Processor'),
    RecipesParameterClass(parameter: 'Grill'),
  ];

  List<RecipesParameterClass> allergies = [
    RecipesParameterClass(parameter: 'Dairy'),
    RecipesParameterClass(parameter: 'Egg'),
    RecipesParameterClass(parameter: 'Gluten'),
    RecipesParameterClass(parameter: 'Grain'),
    RecipesParameterClass(parameter: 'Peanut'),
    RecipesParameterClass(parameter: 'Seafood'),
    RecipesParameterClass(parameter: 'Sesame'),
    RecipesParameterClass(parameter: 'Shellfish'),
    RecipesParameterClass(parameter: 'Soy'),
    RecipesParameterClass(parameter: 'Sulfite'),
    RecipesParameterClass(parameter: 'Tree Nut'),
    RecipesParameterClass(parameter: 'Wheat'),
  ];

  List<RecipesParameterClass> dietaryRestrictions = [
    RecipesParameterClass(parameter: 'Gluten Free'),
    RecipesParameterClass(parameter: 'Ketogenic'),
    RecipesParameterClass(parameter: 'Vegetarian'),
    RecipesParameterClass(
      parameter: 'Lacto-Vegetarian',
    ),
    RecipesParameterClass(parameter: 'Ovo-Vegetarian'),
    RecipesParameterClass(parameter: 'Vegan'),
    RecipesParameterClass(parameter: 'Pescetarian'),
    RecipesParameterClass(parameter: 'Paleo'),
    RecipesParameterClass(parameter: 'Primal'),
    RecipesParameterClass(parameter: 'Low FODMAP'),
    RecipesParameterClass(parameter: 'Whole30'),
  ];

  List<RecipesParameterClass> regionalDelicacy = [
    RecipesParameterClass(parameter: 'Italian Pizza'),
    RecipesParameterClass(parameter: 'Mexican Tacos'),
    RecipesParameterClass(parameter: 'Japanese Sushi'),
    RecipesParameterClass(
      parameter: 'Chinese Dumplings',
    ),
    RecipesParameterClass(parameter: 'Indian Curry'),
    RecipesParameterClass(
      parameter: 'French Baguette',
    ),
    RecipesParameterClass(parameter: 'Italian Pasta'),
    RecipesParameterClass(parameter: 'Thai Pad Thai'),
    RecipesParameterClass(parameter: 'Greek Souvlaki'),
    RecipesParameterClass(
      parameter: 'American Burger',
    ),
  ];


  void toggleRecipeState(int index){
    _recipesParameters[index].isChecked = !_recipesParameters[index].isChecked;
    notifyListeners();
  }

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

  void complexSearchRecipes(context, {required List<dynamic> showRecipes}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => ComplexSearchedRecipes(showRecipes: showRecipes),
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
      _addProtein.clear();
    }
    if (_addStyle.isNotEmpty) {
      _addStyle.clear();
    }
    if (_addServiceSize.isNotEmpty) {
      _addServiceSize.clear();
    }
    if (_addKitchenResources.isNotEmpty) {
      _addKitchenResources.clear();
    }
    if (_addAllergies.isNotEmpty) {
      _addAllergies.clear();
    }
    if (_addDietaryRestrictions.isNotEmpty) {
      _addDietaryRestrictions.clear();
    }
    if (_addRegionalDelicacy.isNotEmpty) {
      _addRegionalDelicacy.clear();
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

  bool changeIconType() {
    _changeIcon = !_changeIcon;
    notifyListeners();
    return changeIcon;
  }

  final List<int> _addNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  List<int> get addNumber => _addNumber;

  List<int> addNumberValue(int value, int index) {
    _addNumber.insert(0, value);
    notifyListeners();
    return addNumber;
  }
}


class ProteinProvider extends ChangeNotifier {
  final List<RecipesParameterClass> _proteinRecipesParameters = [];

  List<RecipesParameterClass> get proteinRecipesParameters => _proteinRecipesParameters;

  List<RecipesParameterClass> preferredProteinRecipe = [
    RecipesParameterClass(parameter: 'Salt'),
    RecipesParameterClass(parameter: 'Olive oil'),
    RecipesParameterClass(parameter: 'Butter'),
    RecipesParameterClass(parameter: 'Sugar'),
    RecipesParameterClass(parameter: 'Water'),
    RecipesParameterClass(parameter: 'Flour'),
    RecipesParameterClass(parameter: 'Garlic'),
    RecipesParameterClass(parameter: 'Eggs'),
    RecipesParameterClass(parameter: 'Onion'),
    RecipesParameterClass(
      parameter: 'Vanilla extract',
    ),
    RecipesParameterClass(parameter: 'Milk'),
    RecipesParameterClass(parameter: 'Kosher salt'),
    RecipesParameterClass(parameter: 'Lemon juice'),
    RecipesParameterClass(
      parameter: 'Unsalted butter',
    ),
    RecipesParameterClass(parameter: 'Black pepper'),
    RecipesParameterClass(parameter: 'Baking powder'),
    RecipesParameterClass(parameter: 'Pepper'),
    RecipesParameterClass(
      parameter: 'Salt and pepper',
    ),
    RecipesParameterClass(parameter: 'Egg'),
    RecipesParameterClass(parameter: 'Brown sugar'),
    RecipesParameterClass(parameter: 'Baking soda'),
    RecipesParameterClass(parameter: 'Garlic cloves'),
    RecipesParameterClass(parameter: 'Vegetable oil'),
    RecipesParameterClass(
      parameter: 'Granulated sugar',
    ),
    RecipesParameterClass(parameter: 'Honey'),
    RecipesParameterClass(
      parameter: 'Ground cinnamon',
    ),
    RecipesParameterClass(parameter: 'Ground pepper'),
    RecipesParameterClass(parameter: 'Cream cheese'),
    RecipesParameterClass(
      parameter: 'Parmesan cheese',
    ),
    RecipesParameterClass(parameter: 'Garlic powder'),
    RecipesParameterClass(parameter: 'Carrots'),
    RecipesParameterClass(parameter: 'Cinnamon'),
    RecipesParameterClass(parameter: 'Oregano'),
    RecipesParameterClass(parameter: 'Red onion'),
    RecipesParameterClass(parameter: 'Heavy cream'),
    RecipesParameterClass(parameter: 'Celery'),
    RecipesParameterClass(parameter: 'Chicken'),
    RecipesParameterClass(parameter: 'Sour cream'),
    RecipesParameterClass(parameter: 'Vanilla'),
    RecipesParameterClass(parameter: 'Sea salt'),
    RecipesParameterClass(parameter: 'Green onions'),
    RecipesParameterClass(parameter: 'Lime juice'),
    RecipesParameterClass(parameter: 'Soy sauce'),
    RecipesParameterClass(parameter: 'Powdered sugar'),
    RecipesParameterClass(parameter: 'Fresh parsley'),
    RecipesParameterClass(parameter: 'Bacon'),
    RecipesParameterClass(parameter: 'Cornstarch'),
    RecipesParameterClass(parameter: 'Ground cumin'),
    RecipesParameterClass(parameter: 'Tomatoes'),
    RecipesParameterClass(parameter: 'Canola oil'),
    RecipesParameterClass(parameter: 'Oil'),
    RecipesParameterClass(parameter: 'Chicken broth'),
    RecipesParameterClass(parameter: 'Maple syrup'),
    RecipesParameterClass(
      parameter: 'Red bell pepper',
    ),
    RecipesParameterClass(
      parameter: 'Canned tomatoes',
    ),
    RecipesParameterClass(parameter: 'Lemon zest'),
    RecipesParameterClass(parameter: 'Paprika'),
    RecipesParameterClass(parameter: 'Dijon mustard'),
    RecipesParameterClass(parameter: 'Chili powder'),
    RecipesParameterClass(parameter: 'Chocolate'),
    RecipesParameterClass(parameter: 'Mayonnaise'),
    RecipesParameterClass(parameter: 'White sugar'),
    RecipesParameterClass(parameter: 'Onions'),
    RecipesParameterClass(parameter: 'Fresh cilantro'),
    RecipesParameterClass(parameter: 'Parsley'),
    RecipesParameterClass(parameter: 'Cilantro'),
    RecipesParameterClass(parameter: 'Pecans'),
    RecipesParameterClass(parameter: 'Beef'),
    RecipesParameterClass(parameter: 'Ginger'),
    RecipesParameterClass(parameter: 'Garlic clove'),
    RecipesParameterClass(
      parameter: 'Red pepper flakes',
    ),
    RecipesParameterClass(parameter: 'Walnuts'),
    RecipesParameterClass(parameter: 'Cayenne pepper'),
    RecipesParameterClass(
      parameter: 'Extra virgin olive oil',
    ),
    RecipesParameterClass(parameter: 'Carrot'),
    RecipesParameterClass(parameter: 'Coconut oil'),
    RecipesParameterClass(parameter: 'Zucchini'),
    RecipesParameterClass(parameter: 'Strawberries'),
    RecipesParameterClass(
      parameter: 'Worcestershire sauce',
    ),
    RecipesParameterClass(parameter: 'Sesame oil'),
    RecipesParameterClass(parameter: 'Food dye'),
    RecipesParameterClass(parameter: 'Orange juice'),
    RecipesParameterClass(parameter: 'Potatoes'),
    RecipesParameterClass(parameter: 'Fish'),
    RecipesParameterClass(parameter: 'Tomato'),
    RecipesParameterClass(parameter: 'Juice of lemon'),
    RecipesParameterClass(parameter: 'Avocado'),
    RecipesParameterClass(parameter: 'Buttermilk'),
    RecipesParameterClass(
      parameter: 'Light brown sugar',
    ),
    RecipesParameterClass(parameter: 'Nutmeg'),
    RecipesParameterClass(
      parameter: 'Balsamic vinegar',
    ),
    RecipesParameterClass(parameter: 'Ground ginger'),
    RecipesParameterClass(parameter: 'Yellow onion'),
    RecipesParameterClass(parameter: 'Fresh ginger'),
    RecipesParameterClass(parameter: 'Egg whites'),
    RecipesParameterClass(parameter: 'Ground nutmeg'),
    RecipesParameterClass(
      parameter: 'Shredded cheddar cheese',
    ),
    RecipesParameterClass(
      parameter: 'Green bell pepper',
    ),
    RecipesParameterClass(parameter: 'Almonds'),
    RecipesParameterClass(parameter: 'Whole milk'),
    RecipesParameterClass(parameter: 'Lemon'),
    RecipesParameterClass(parameter: 'Shrimp'),
  ];

  void showProteinParameterDetails(context, String parameter) {
    if (parameter == "Preferred Protein") {
      _proteinRecipesParameters.addAll(preferredProteinRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) =>
              RecipesSelection(
                  parameter: parameter,
                  recipesParameters: preferredProteinRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleProteinRecipeState(int index){
    _proteinRecipesParameters[index].isChecked = !_proteinRecipesParameters[index].isChecked;
    notifyListeners();
  }
  void clearProteinAllCheckboxStates() {
    for (var parameter in _proteinRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }
}

class StyleProvider extends ChangeNotifier {
  final List<RecipesParameterClass> _styleRecipesParameters = [];

  List<RecipesParameterClass> get styleRecipesParameters => _styleRecipesParameters;

  List<RecipesParameterClass> preferredStyleRecipe = [
    RecipesParameterClass(parameter: 'African'),
    RecipesParameterClass(parameter: 'Asian'),
    RecipesParameterClass(parameter: 'American'),
    RecipesParameterClass(parameter: 'British'),
    RecipesParameterClass(parameter: 'Cajun'),
    RecipesParameterClass(parameter: 'Caribbean'),
    RecipesParameterClass(parameter: 'Chinese'),
    RecipesParameterClass(
      parameter: 'Eastern European',
    ),
    RecipesParameterClass(parameter: 'European'),
    RecipesParameterClass(parameter: 'French'),
    RecipesParameterClass(parameter: 'German'),
    RecipesParameterClass(parameter: 'Greek'),
    RecipesParameterClass(parameter: 'Indian'),
    RecipesParameterClass(parameter: 'Irish'),
    RecipesParameterClass(parameter: 'Italian'),
    RecipesParameterClass(parameter: 'Japanese'),
    RecipesParameterClass(parameter: 'Jewish'),
    RecipesParameterClass(parameter: 'Korean'),
    RecipesParameterClass(parameter: 'Latin American'),
    RecipesParameterClass(parameter: 'Mediterranean'),
    RecipesParameterClass(parameter: 'Mexican'),
    RecipesParameterClass(parameter: 'Middle Eastern'),
    RecipesParameterClass(parameter: 'Nordic'),
    RecipesParameterClass(parameter: 'Southern'),
    RecipesParameterClass(parameter: 'Spanish'),
    RecipesParameterClass(parameter: 'Thai'),
    RecipesParameterClass(parameter: 'Vietnamese'),
  ];

  void showStyleParameterDetails(context, String parameter) {
    if (parameter == "Style") {
      _styleRecipesParameters.addAll(preferredStyleRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) =>
              RecipesSelection(
                  parameter: parameter,
                  recipesParameters: preferredStyleRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleStyleRecipeState(int index){
    _styleRecipesParameters[index].isChecked = !_styleRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearStyleAllCheckboxStates() {
    for (var parameter in _styleRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }
}

class AllergiesProvider extends ChangeNotifier {
  final List<RecipesParameterClass> _allergiesRecipesParameters = [];

  List<RecipesParameterClass> get allergiesRecipesParameters => _allergiesRecipesParameters;

  List<RecipesParameterClass> preferredAllergiesRecipe = [
    RecipesParameterClass(parameter: 'Dairy'),
    RecipesParameterClass(parameter: 'Egg'),
    RecipesParameterClass(parameter: 'Gluten'),
    RecipesParameterClass(parameter: 'Grain'),
    RecipesParameterClass(parameter: 'Peanut'),
    RecipesParameterClass(parameter: 'Seafood'),
    RecipesParameterClass(parameter: 'Sesame'),
    RecipesParameterClass(parameter: 'Shellfish'),
    RecipesParameterClass(parameter: 'Soy'),
    RecipesParameterClass(parameter: 'Sulfite'),
    RecipesParameterClass(parameter: 'Tree Nut'),
    RecipesParameterClass(parameter: 'Wheat'),
  ];

  void showAllergiesParameterDetails(context, String parameter) {
    if (parameter == "Allergies") {
      _allergiesRecipesParameters.addAll(preferredAllergiesRecipe);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) =>
              RecipesSelection(
                  parameter: parameter,
                  recipesParameters: preferredAllergiesRecipe),
        ),
      );
      notifyListeners();
    }
  }

  void toggleAllergiesRecipeState(int index){
    _allergiesRecipesParameters[index].isChecked = !_allergiesRecipesParameters[index].isChecked;
    notifyListeners();
  }

  void clearAllergiesAllCheckboxStates() {
    for (var parameter in _allergiesRecipesParameters) {
      parameter.isChecked = false;
    }
    notifyListeners();
  }
}