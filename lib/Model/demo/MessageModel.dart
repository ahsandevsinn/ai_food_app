class MessageModel {
  String recipeName;
  int servings;
  String difficulty;
  List<String> kitchenToolsUsed;
  List<String> instructions;
  num preparationTime;
  List<Ingredient> ingredients;
  Macros macros;

  MessageModel({
    required this.recipeName,
    required this.servings,
    required this.difficulty,
    required this.kitchenToolsUsed,
    required this.instructions,
    required this.preparationTime,
    required this.ingredients,
    required this.macros,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      recipeName: json['recipeName'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      kitchenToolsUsed: List<String>.from(json['kitchenToolsUsed']),
      instructions: List<String>.from(json['instructions']),
      preparationTime: json['preparationTime'],
      ingredients: List<Ingredient>.from(
        json['ingredients'].map((ingredient) => Ingredient.fromJson(ingredient)),
      ),
      macros: Macros.fromJson(json['macros']),
    );
  }
}

class Ingredient {
  String name;
  String unit;
  num amount;

  Ingredient({
    required this.name,
    required this.unit,
    required this.amount,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      unit: json['unit'],
      amount: json['amount'],
    );
  }
}

class Macros {
  MacroAmount carbs;
  MacroAmount fats;
  MacroAmount proteins;
  MacroAmount calories;

  Macros({
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.calories,
  });

  factory Macros.fromJson(Map<String, dynamic> json) {
    return Macros(
      carbs: MacroAmount.fromJson(json['carbs']),
      fats: MacroAmount.fromJson(json['fats']),
      proteins: MacroAmount.fromJson(json['proteins']),
      calories: MacroAmount.fromJson(json['calories']),
    );
  }
}

class MacroAmount {
  num amount;
  String unit;

  MacroAmount({
    required this.amount,
    required this.unit,
  });

  factory MacroAmount.fromJson(Map<String, dynamic> json) {
    return MacroAmount(
      amount: json['amount'],
      unit: json['unit'],
    );
  }
}
