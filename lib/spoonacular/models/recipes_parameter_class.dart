import 'package:flutter/cupertino.dart';
enum IconDataSelect { selected, unselected }
class RecipesParameterClass{
  final String parameter;
  final Icon icon;

  const RecipesParameterClass({required this.parameter, required this.icon});
}