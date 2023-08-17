import 'dart:convert';
import 'dart:math';

import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/spoonacular/animation/animation.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Recipies extends StatefulWidget {
  const Recipies({Key? key}) : super(key: key);

  @override
  State<Recipies> createState() => _RecipiesState();
}

class _RecipiesState extends State<Recipies> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesParameterProvider =
        Provider.of<RecipesParameterProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: TextField(
              autofocus: false,
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: "Search recipes...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.redAccent),
                    onPressed: () {
                      if (_searchController.text == "") {
                        showSnackBar(context, "Please enter recipe name.");
                      } else {
                        searchRecipe(_searchController.text);
                        _searchController.clear();
                        recipesParameterProvider.removeParams();
                        Provider.of<ProteinProvider>(context, listen: false).clearProteinAllCheckboxStates();
                        Provider.of<StyleProvider>(context, listen: false).clearStyleAllCheckboxStates();
                        Provider.of<AllergiesProvider>(context, listen: false).clearAllergiesAllCheckboxStates();
                        Provider.of<ServiceSizeProvider>(context, listen: false).clearServiceSizeAllCheckboxStates();
                        Provider.of<KitchenResourcesProvider>(context, listen: false).clearKitchenResourcesAllCheckboxStates();
                        Provider.of<DietaryRestrictionsProvider>(context, listen: false).clearDietaryRestrictionsAllCheckboxStates();
                        Provider.of<RegionalDelicacyProvider>(context, listen: false).clearRegionalDelicacyAllCheckboxStates();
                      }
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Colors.black.withOpacity(.5),
                      ),
                      borderRadius: BorderRadius.circular(15))),
              onChanged: (value) {
                // BlocProvider.of<SearchPageCubit>(context).textChange(value);
              },
              onSubmitted: (v) {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider(
                //       create: (context) => SearchResultsBloc(),
                //       child: SearchResults(
                //         id: v,
                //       ),
                //     ),
                //   ),
                // );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          return recipesParameterProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                      child: Text(
                        "Search for food recipes by selecting certain parameters",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          ChipWidget(
                            color:
                                recipesParameterProvider.addProtein.isNotEmpty
                                    ? Colors.black
                                    : Theme.of(context).primaryColor,
                            text: "Preferred Protein",
                            onPressed: () {
                              Provider.of<ProteinProvider>(context, listen: false).showProteinParameterDetails(
                                  context, "Preferred Protein");
                            },
                          ),
                          ChipWidget(
                            color: recipesParameterProvider.addStyle.isNotEmpty
                                ? Colors.black
                                : Theme.of(context).primaryColor,
                            text: "Style",
                            onPressed: () {
                              Provider.of<StyleProvider>(context, listen: false).showStyleParameterDetails(
                                  context, "Style");
                            },
                          ),
                          ChipWidget(
                            color: recipesParameterProvider.addServiceSize.isNotEmpty
                                ? Colors.black
                                : Theme.of(context).primaryColor,
                            text: "Service Size",
                            onPressed: () {
                              Provider.of<ServiceSizeProvider>(context, listen: false).showServiceSizeRecipesParameterDetails(context, "Service Size");
                            },
                          ),
                          ChipWidget(
                            color: recipesParameterProvider
                                    .addKitchenResources.isNotEmpty
                                ? Colors.black
                                : Theme.of(context).primaryColor,
                            text: "Kitchen Resources",
                            onPressed: () {
                              Provider.of<KitchenResourcesProvider>(context, listen: false).showKitchenResourcesParameterDetails(
                                  context, "Kitchen Resources");
                            },
                          ),
                          ChipWidget(
                            color:
                                recipesParameterProvider.addAllergies.isNotEmpty
                                    ? Colors.black
                                    : Theme.of(context).primaryColor,
                            text: "Allergies",
                            onPressed: () {
                              Provider.of<AllergiesProvider>(context, listen: false).showAllergiesParameterDetails(
                                  context, "Allergies");
                            },
                          ),
                          ChipWidget(
                            color: recipesParameterProvider
                                    .addDietaryRestrictions.isNotEmpty
                                ? Colors.black
                                : Theme.of(context).primaryColor,
                            text: "Dietary Restrictions",
                            onPressed: () {
                              Provider.of<DietaryRestrictionsProvider>(context, listen: false).showDietaryRestrictionsParameterDetails(
                                  context, "Dietary Restrictions");
                            },
                          ),
                          ChipWidget(
                            color: recipesParameterProvider
                                    .addRegionalDelicacy.isNotEmpty
                                ? Colors.black
                                : Theme.of(context).primaryColor,
                            text: "Regional Delicacy",
                            onPressed: () {
                              Provider.of<RegionalDelicacyProvider>(context, listen: false).showRegionalDelicacyParameterDetails(
                                  context, "Regional Delicacy");
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                      child: Text(
                        "Selected Parameters",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          recipesParameterProvider.addProtein.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Preferred Protein: ${recipesParameterProvider.addProtein.toString().substring(1, recipesParameterProvider.addProtein.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider.addStyle.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Style: ${recipesParameterProvider.addStyle.toString().substring(1, recipesParameterProvider.addStyle.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider.addServiceSize.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Service Size: ${recipesParameterProvider.addServiceSize[0]}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider.addKitchenResources.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Kitchen Resources: ${recipesParameterProvider.addKitchenResources.toString().substring(1, recipesParameterProvider.addKitchenResources.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider.addAllergies.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Allergies: ${recipesParameterProvider.addAllergies.toString().substring(1, recipesParameterProvider.addAllergies.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider
                                  .addDietaryRestrictions.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Dietary Restrictions: ${recipesParameterProvider.addDietaryRestrictions.toString().substring(1, recipesParameterProvider.addDietaryRestrictions.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                          recipesParameterProvider.addRegionalDelicacy.isEmpty
                              ? const SizedBox.shrink()
                              : ChipWidget(
                                  text:
                                      "Regional Delicacy: ${recipesParameterProvider.addRegionalDelicacy.toString().substring(1, recipesParameterProvider.addRegionalDelicacy.toString().length - 1)}",
                                  color: Theme.of(context).primaryColor),
                        ],
                      ),
                    ),
                    // Center(
                    //   child: GestureDetector(
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: Colors.blue,
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       width: 200,
                    //       height: 50,
                    //       child: const Center(
                    //         child:
                    //             AppText("Generate Recipe", color: Colors.white),
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       if (recipesParameterProvider.addProtein.isEmpty &&
                    //           recipesParameterProvider.addStyle.isEmpty &&
                    //           recipesParameterProvider.addServiceSize.isEmpty &&
                    //           recipesParameterProvider
                    //               .addKitchenResources.isEmpty &&
                    //           recipesParameterProvider.addAllergies.isEmpty &&
                    //           recipesParameterProvider
                    //               .addDietaryRestrictions.isEmpty &&
                    //           recipesParameterProvider
                    //               .addRegionalDelicacy.isEmpty) {
                    //         showSnackBar(context,
                    //             "Please select any recipes parameters.");
                    //       } else {
                    //         recipesParameterProvider.removeParams();
                    //         fetchRandomRecipesWithParameters();
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                );
        }),
      ),
    );
  }

  //search recipes by parameters
  void fetchRandomRecipesWithParameters() async {
    final recipesParameterProvider =
        Provider.of<RecipesParameterProvider>(context, listen: false);
    recipesParameterProvider.loading();
    // Additional parameters

    final query = _searchController.text == "" ? "" : _searchController.text;
    final style = recipesParameterProvider.addStyle.isEmpty
        ? ""
        : recipesParameterProvider
            .addStyle[0]; // Replace with the selected style
    final serviceSize = recipesParameterProvider.addServiceSize.isEmpty
        ? ""
        : recipesParameterProvider
            .addServiceSize[0]; // Replace with the selected service size
    final kitchenResources =
        recipesParameterProvider.addKitchenResources.isEmpty
            ? ""
            : recipesParameterProvider.addKitchenResources[
                0]; // Replace with the selected kitchen resources
    final preferredProtein = recipesParameterProvider.addProtein.isEmpty
        ? ""
        : recipesParameterProvider
            .addProtein[0]; // Replace with the selected preferred protein
    final allergies = recipesParameterProvider.addAllergies.isEmpty
        ? ""
        : recipesParameterProvider
            .addAllergies[0]; // Replace with the selected allergies
    final dietaryRestrictions =
        recipesParameterProvider.addDietaryRestrictions.isEmpty
            ? ""
            : recipesParameterProvider.addDietaryRestrictions[
                0]; // Replace with the selected dietary restrictions
    final regionalDelicacy =
        recipesParameterProvider.addRegionalDelicacy.isEmpty
            ? ""
            : recipesParameterProvider.addRegionalDelicacy[
                0]; // Replace with the selected regional delicacy
    // final apiKey = 'c8006bcb5d99435bada05e67f3db55cc';
    final apiKey = '50c97694758d413ba8021361c1a6aff8';
    final apiUrl =
        'https://api.spoonacular.com/recipes/random?';
        // 'https://api.spoonacular.com/recipes/random?number=3&tags=dinner&apiKey=$apiKey';
        // 'https://api.spoonacular.com/recipes/random?query=${_searchController.text}&cuisine=$style&diet=$dietaryRestrictions&intolerances=$allergies&includeIngredients=$preferredProtein&equipment=$kitchenResources&apiKey=$apiKey';
    final queryParams = {
      // 'tags': 'lunch',
      // 'query': query,
      'cuisine': style,
      'servings': serviceSize,
      'resources': kitchenResources,
      'ingredients': preferredProtein,
      'intolerances': allergies,
      'diet': dietaryRestrictions,
      'locale': regionalDelicacy,
      'number': '3', // Number of recipes
      'apiKey': apiKey,
    };
    final response =
        await AppDio(context).get(queryParameters: queryParams, path: apiUrl);
    if (response.statusCode == 200) {
      final data = response.data["recipes"];
      print("data_length ${data.length}");
      if (data != null) {
        recipesParameterProvider.loading();
        recipesParameterProvider.showSearchedRecipes(context,
            showRecipes: data);
      }
      print("jkdbkvbjdb${data}");
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  //search recipes by parameters
  // void searchRecipe(String searchControllerText) async {
  //   final recipesParameterProvider =
  //       Provider.of<RecipesParameterProvider>(context, listen: false);
  //   recipesParameterProvider.loading();
  //   // Additional parameters
  //   final style = recipesParameterProvider.addStyle.isEmpty
  //       ? ""
  //       : recipesParameterProvider
  //           .addStyle[0]; // Replace with the selected style
  //   final serviceSize = recipesParameterProvider.addServiceSize.isEmpty
  //       ? ""
  //       : recipesParameterProvider
  //           .addServiceSize[0]; // Replace with the selected service size
  //   final kitchenResources =
  //       recipesParameterProvider.addKitchenResources.isEmpty
  //           ? ""
  //           : recipesParameterProvider.addKitchenResources[
  //               0]; // Replace with the selected kitchen resources
  //   final preferredProtein = recipesParameterProvider.addProtein.isEmpty
  //       ? ""
  //       : recipesParameterProvider
  //           .addProtein[0]; // Replace with the selected preferred protein
  //   final allergies = recipesParameterProvider.addAllergies.isEmpty
  //       ? ""
  //       : recipesParameterProvider
  //           .addAllergies[0]; // Replace with the selected allergies
  //   final dietaryRestrictions =
  //       recipesParameterProvider.addDietaryRestrictions.isEmpty
  //           ? ""
  //           : recipesParameterProvider.addDietaryRestrictions[
  //               0]; // Replace with the selected dietary restrictions
  //   final regionalDelicacy =
  //       recipesParameterProvider.addRegionalDelicacy.isEmpty
  //           ? ""
  //           : recipesParameterProvider.addRegionalDelicacy[
  //               0]; // Replace with the selected regional delicacy
  //   // final apiKey = 'c8006bcb5d99435bada05e67f3db55cc';
  //   print("https://api.spoonacular.com/recipes/complexSearch?query=${_searchController.text}&cuisine=$style&diet=$dietaryRestrictions&intolerances=$allergies&includeIngredients=$preferredProtein&equipment=$kitchenResources&number=3");
  //   final apiKey = '50c97694758d413ba8021361c1a6aff8';
  //   final apiUrl =
  //       // 'https://api.spoonacular.com/recipes/random?number=3&tags=dinner&apiKey=$apiKey';
  //       'https://api.spoonacular.com/recipes/complexSearch?query=${_searchController.text}&cuisine=$style&diet=$dietaryRestrictions&intolerances=$allergies&includeIngredients=$preferredProtein&equipment=$kitchenResources&number=3&apiKey=$apiKey';
  //   final response = await AppDio(context).get(path: apiUrl);
  //   if (response.statusCode == 200) {
  //     final data = response.data;
  //     // print("data_length ${data.length}");
  //     if (data != null) {
  //       recipesParameterProvider.loading();
  //       // recipesParameterProvider.showSearchedRecipes(context,
  //       //     showRecipes: data);
  //     }
  //     print("response_data ${data}");
  //   } else {
  //     print('API request failed with status code: ${response.statusCode}');
  //   }
  // }

  void searchRecipe(String searchControllerText) async {

    Random random = Random();
    int randomNumber = random.nextInt(10);

    final recipesParameterProvider = Provider.of<RecipesParameterProvider>(context, listen: false);
    recipesParameterProvider.loading();

    final style = recipesParameterProvider.addStyle.isNotEmpty ? "&cuisine=${recipesParameterProvider.addStyle.toString().substring(1, recipesParameterProvider.addStyle.toString().length - 1)}" : "";
    final serviceSize = recipesParameterProvider.addServiceSize.isNotEmpty ? "&servings=${recipesParameterProvider.addServiceSize[0]}" : "";
    final kitchenResources = recipesParameterProvider.addKitchenResources.isNotEmpty ? "&equipment=${recipesParameterProvider.addKitchenResources.toString().substring(1, recipesParameterProvider.addKitchenResources.toString().length - 1)}" : "";
    final preferredProtein = recipesParameterProvider.addProtein.isNotEmpty ? "&includeIngredients=${recipesParameterProvider.addProtein.toString().substring(1, recipesParameterProvider.addProtein.toString().length - 1)}" : "";
    final allergies = recipesParameterProvider.addAllergies.isNotEmpty ? "&intolerances=${recipesParameterProvider.addAllergies.toString().substring(1, recipesParameterProvider.addAllergies.toString().length - 1)}" : "";
    final dietaryRestrictions = recipesParameterProvider.addDietaryRestrictions.isNotEmpty ? "&diet=${recipesParameterProvider.addDietaryRestrictions.toString().substring(1, recipesParameterProvider.addDietaryRestrictions.toString().length - 1)}" : "";
    // final regionalDelicacy = recipesParameterProvider.addRegionalDelicacy.isNotEmpty ? "&cuisine=${recipesParameterProvider.addRegionalDelicacy.toString().substring(1, recipesParameterProvider.addRegionalDelicacy.toString().length - 1)}" : "";
    final regionalDelicacy = recipesParameterProvider.addRegionalDelicacy.isNotEmpty ? "" : "";

    final apiKey = '50c97694758d413ba8021361c1a6aff8';
    final apiUrl = 'https://api.spoonacular.com/recipes/complexSearch?query=$searchControllerText$style$serviceSize$kitchenResources$preferredProtein$allergies$dietaryRestrictions$regionalDelicacy&number=$randomNumber&apiKey=$apiKey';

    final response = await AppDio(context).get(path: apiUrl);
    if (response.statusCode == 200) {
      final data = response.data['results'];
      if (data != null && data != [] && data.isNotEmpty) {
        recipesParameterProvider.loading();
        recipesParameterProvider.complexSearchRecipes(context, showRecipes: data);
      } else {
        recipesParameterProvider.loading();
        showSnackBar(context, "There is not Recipe available.");
      }
      print("response_data ${data}");
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }

}

class ChipWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  const ChipWidget({
    required this.text,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-2, -2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).primaryColor,
                  color: color,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
