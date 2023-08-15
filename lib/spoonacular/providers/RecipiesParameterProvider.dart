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
        parameter: 'Salt', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Olive oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Butter', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sugar', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Water', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Flour', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Garlic', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Eggs', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Onion', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vanilla extract',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Milk', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Kosher salt', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Lemon juice', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Unsalted butter',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Black pepper', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Baking powder', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Pepper', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Salt and pepper',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Egg', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Brown sugar', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Baking soda', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Garlic cloves', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vegetable oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Granulated sugar',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Honey', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ground cinnamon',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ground pepper', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cream cheese', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Parmesan cheese',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Garlic powder', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Carrots', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cinnamon', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Oregano', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Red onion', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Heavy cream', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Celery', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chicken', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sour cream', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vanilla', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sea salt', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Green onions', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Lime juice', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Soy sauce', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Powdered sugar', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Fresh parsley', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Bacon', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cornstarch', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ground cumin', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Tomatoes', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Canola oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chicken broth', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Maple syrup', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Red bell pepper',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Canned tomatoes',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Lemon zest', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Paprika', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Dijon mustard', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chili powder', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chocolate', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Mayonnaise', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'White sugar', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Onions', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Fresh cilantro', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Parsley', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cilantro', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Pecans', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Beef', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ginger', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Garlic clove', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Red pepper flakes',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Walnuts', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cayenne pepper', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Extra virgin olive oil',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Carrot', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Coconut oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Zucchini', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Strawberries', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Worcestershire sauce',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sesame oil', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Food dye', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Orange juice', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Potatoes', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Fish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Tomato', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Juice of lemon', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Avocado', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Buttermilk', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Light brown sugar',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Nutmeg', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Balsamic vinegar',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ground ginger', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Yellow onion', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Fresh ginger', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Egg whites', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ground nutmeg', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Shredded cheddar cheese',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Green bell pepper',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Almonds', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Whole milk', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Lemon', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Shrimp', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> styles = [
    const RecipesParameterClass(
        parameter: 'African', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Asian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'American', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'British', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Cajun', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Caribbean', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chinese', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Eastern European',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'European', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'French', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'German', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Greek', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Indian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Irish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Italian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Japanese', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Jewish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Korean', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Latin American', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Mediterranean', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Mexican', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Middle Eastern', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Nordic', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Southern', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Spanish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Thai', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vietnamese', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> serviceSize = [
    // const RecipesParameterClass(parameter: 'One Person', icon: Icon(Icons.check_box_outline_blank)),
    // const RecipesParameterClass(parameter: 'Small Family', icon: Icon(Icons.check_box_outline_blank)),
    // const RecipesParameterClass(parameter: 'Large Gathering', icon: Icon(Icons.check_box_outline_blank)),

    const RecipesParameterClass(
        parameter: '1', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '2', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '3', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '4', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '5', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '7', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '8', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '9', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: '10', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> kitchenResources = [
    const RecipesParameterClass(
        parameter: 'Frying Pan', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Bowl', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Blender', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Oven', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Slow Cooker', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Microwave', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Food Processor', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Grill', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> allergies = [
    const RecipesParameterClass(
        parameter: 'Dairy', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Egg', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Gluten', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Grain', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Peanut', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Seafood', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sesame', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Shellfish', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Soy', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Sulfite', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Tree Nut', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Wheat', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> dietaryRestrictions = [
    const RecipesParameterClass(
        parameter: 'Gluten Free', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ketogenic', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vegetarian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Lacto-Vegetarian',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Ovo-Vegetarian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Vegan', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Pescetarian', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Paleo', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Primal', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Low FODMAP', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Whole30', icon: Icon(Icons.check_box_outline_blank)),
  ];

  List<RecipesParameterClass> regionalDelicacy = [
    const RecipesParameterClass(
        parameter: 'Italian Pizza', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Mexican Tacos', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Japanese Sushi', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Chinese Dumplings',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Indian Curry', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'French Baguette',
        icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Italian Pasta', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Thai Pad Thai', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'Greek Souvlaki', icon: Icon(Icons.check_box_outline_blank)),
    const RecipesParameterClass(
        parameter: 'American Burger',
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
