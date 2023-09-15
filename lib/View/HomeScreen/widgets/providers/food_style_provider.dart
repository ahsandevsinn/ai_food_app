import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//This is the allergies provider class
class FoodStyleProvider extends ChangeNotifier {

  String _foodStyleValue = "";

  String get foodStyle => _foodStyleValue;

  void setFoodStyleValue(String value) {
    _foodStyleValue = value;
    notifyListeners();
  }

  void clearFoodStyleValue() {
    _foodStyleValue = "";
    notifyListeners();
  }

}
