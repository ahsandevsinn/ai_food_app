import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/spoonacular/models/recipes_parameter_class.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesSelection extends StatefulWidget {
  final String parameter;
  final List<RecipesParameterClass> recipesParameters;

  const RecipesSelection({
    Key? key,
    required this.parameter,
    required this.recipesParameters,
  }) : super(key: key);

  @override
  State<RecipesSelection> createState() => _RecipesSelectionState();
}

class _RecipesSelectionState extends State<RecipesSelection> {
  int _selectedIndex = -1; // Track the selected index

  @override
  Widget build(BuildContext context) {
    final selectedValue =
        Provider.of<RecipesParameterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: AppText(widget.parameter, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: widget.recipesParameters.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final recipesParams = widget.recipesParameters[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index; // Update the selected index
              });
              if (widget.parameter == "Preferred Protein") {
                selectedValue.addProteinValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Style") {
                selectedValue.addStyleValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Service Size") {
                selectedValue.addServiceSizeValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Kitchen Resources") {
                selectedValue.addKitchenResourcesValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Allergies") {
                selectedValue.addAllergiesValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Dietary Restrictions") {
                selectedValue.addDietaryRestrictionsValue(recipesParams.parameter, index);
              } else if (widget.parameter == "Regional Delicacy") {
                selectedValue.addRegionalDelicacyValue(recipesParams.parameter, index);
              }
            },
            child: ListTile(
              title: AppText(recipesParams.parameter),
              trailing: Icon(
                _selectedIndex == index
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
            ),
          );
        },
      ),
    );
  }
}
