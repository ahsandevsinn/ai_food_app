import 'dart:convert';

import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/TestScreens/model_recipe.dart';
import 'package:ai_food/View/HomeScreen/search_screen.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/food_style_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/widget.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/dio/spoonacular_app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/app_logger.dart';

class RecipeParamScreen extends StatefulWidget {
  const RecipeParamScreen({Key? key}) : super(key: key);

  @override
  State<RecipeParamScreen> createState() => _RecipeParamScreenState();
}

class _RecipeParamScreenState extends State<RecipeParamScreen> {
  bool showFoodStyle = false;

  //start food style
  List<String>foodStyle = [];
  List<String> addFoodStyle = [];

  late AppDio dio;
  late SpoonAcularAppDio spoonDio;

  AppLogger logger = AppLogger();

  bool isLoading = false;

  @override
  void initState() {
    dio = AppDio(context);
    spoonDio =  SpoonAcularAppDio(context);
    logger.init();
    getRecipesParameters(context);
    super.initState();
  }

  void getRecipesParameters(context) async {
    final allergyProvider = Provider.of<AllergiesProvider>(context,listen: false).preferredAllergiesRecipe;
    final dietaryRestrictionsProvider = Provider.of<DietaryRestrictionsProvider>(context,listen: false).preferredDietaryRestrictionsParametersRecipe;
    final preferredProteinProvider = Provider.of<PreferredProteinProvider>(context,listen: false).preferredProteinRecipe;
    final regionalDelicacyProvider = Provider.of<RegionalDelicacyProvider>(context,listen: false).preferredRegionalDelicacyParametersRecipe;
    final kitchenResourcesProvider = Provider.of<KitchenResourcesProvider>(context,listen: false).preferredKitchenResourcesParametersRecipe;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? paramsList = prefs.getString(PrefKey.parametersLists);

    try {
      var recipesParams = jsonDecode(paramsList!);
      var foodStyles = recipesParams["data"]["foodStyles"];
      var allergies = recipesParams["data"]["allergies"];
      var dietaryRestrictions = recipesParams["data"]["dietaryRestrictions"];
      var preferredProteins = recipesParams["data"]["preferredProteins"];
      var regionalDelicacies = recipesParams["data"]["regionalDelicacies"];
      var kitchenResources = recipesParams["data"]["kitchenResources"];

      //adding food styles list
      foodStyles.forEach((key, value) {
        foodStyle.add(value);
      });

      //adding allergies list
      if(allergyProvider.isEmpty){
        allergies.forEach((key, value) {
          allergyProvider.add(RecipesParameterClass(parameter: value));
        });
      }

      //adding dietary restrictions list
      if(dietaryRestrictionsProvider.isEmpty){
        dietaryRestrictions.forEach((key, value) {
          dietaryRestrictionsProvider.add(RecipesParameterClass(parameter: value));
        });
      }

      //adding proteins list
      if(preferredProteinProvider.isEmpty){
        preferredProteins.forEach((key, value) {
          preferredProteinProvider.add(RecipesParameterClass(parameter: value));
        });
      }

      //adding regional delicacy list
      if(regionalDelicacyProvider.isEmpty){
        regionalDelicacies.forEach((key, value) {
          regionalDelicacyProvider.add(RecipesParameterClass(parameter: value));
        });
      }

      //adding kitchen resources list
      if(kitchenResourcesProvider.isEmpty){
        kitchenResources.forEach((key, value) {
          kitchenResourcesProvider.add(RecipesParameterClass(parameter: value));
        });
      }

      setState(() {});
    } catch (e) {
      print("Error decoding JSON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final foodStyleProvider = Provider.of<FoodStyleProvider>(context,listen: false);
    print("food_style ${foodStyleProvider.foodStyle}");
    final allergiesProvider =
        Provider.of<AllergiesProvider>(context, listen: true);
    final restrictionsProvider =
        Provider.of<DietaryRestrictionsProvider>(context, listen: true);
    final proteinProvider =
        Provider.of<PreferredProteinProvider>(context, listen: true);
    final delicacyProvider =
        Provider.of<RegionalDelicacyProvider>(context, listen: true);
    final kitchenProvider =
        Provider.of<KitchenResourcesProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 65,
        leadingWidth: 60,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 20,
            ),
            child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios,
                      size: 25, color: AppTheme.whiteColor),
                )),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            showFoodStyle = false;
          });
        },
        child: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.appText(
                        "Food choices:",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        textColor: AppTheme.appColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          //allergies
                          allergiesProvider.removeAllergyParams();
                          allergiesProvider.clearAllergiesAllCheckboxStates();
                          //restrictions
                          restrictionsProvider.removeDietaryRestrictions();
                          restrictionsProvider.clearDietaryRestrictionsAllCheckboxStates();
                          //protein
                          proteinProvider.removePreferredProtein();
                          proteinProvider.clearProteinAllCheckboxStates();
                          //delicacy
                          delicacyProvider.removeRegionalDelicacy();
                          delicacyProvider.clearRegionalDelicacyAllCheckboxStates();
                          //kitchen
                          kitchenProvider.removeKitchenResources();
                          kitchenProvider.clearKitchenResourcesAllCheckboxStates();

                          //food style
                          foodStyleProvider.clearFoodStyleValue();

                          showSnackBar(context, "Filters Reset Succesfully");
                        },
                        child: AppText.appText(
                          "Reset filters",
                          fontSize: 16,
                          underLine: true,
                          fontWeight: FontWeight.w400,
                          textColor: AppTheme.appColor,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              showFoodStyle = !showFoodStyle;

                              setState(() {});
                            },
                            child: Container(
                              height: 55,
                              width: 227,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  border: Border.all(
                                      color: AppTheme.appColor, width: 2)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText.appText(
                                        foodStyleProvider.foodStyle.isEmpty
                                            ? "Food style"
                                            : foodStyleProvider.foodStyle,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppTheme.appColor),
                                    !showFoodStyle
                                        ? Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: AppTheme.appColor,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.keyboard_arrow_up_outlined,
                                            color: AppTheme.appColor,
                                            size: 30,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          //here are the allergies
                          CustomRecipesSelection(
                            recipeText: "Allergies",
                            onTap: () {
                              Provider.of<AllergiesProvider>(context,
                                      listen: false)
                                  .showAllergiesParameterDetails(
                                      context, "Allergies");
                            },
                          ),
                          const SizedBox(height: 30),
                          //ends allergies

                          //here are the Dietary restrictions
                          CustomRecipesSelection(
                            recipeText: "Dietary restrictions",
                            onTap: () {
                              Provider.of<DietaryRestrictionsProvider>(context,
                                      listen: false)
                                  .showDietaryRestrictionsParameterDetails(
                                      context, "Dietary Restrictions");
                            },
                          ),
                          const SizedBox(height: 30),
                          //ends Dietary restrictions

                          //here are the Regional delicacy
                          CustomRecipesSelection(
                            recipeText: "Preferred protein",
                            onTap: () {
                              Provider.of<PreferredProteinProvider>(context,
                                      listen: false)
                                  .showProteinParameterDetails(
                                      context, "Preferred Protein");
                            },
                          ),
                          const SizedBox(height: 30),
                          //ends Regional delicacy

                          //here are the Regional delicacy
                          CustomRecipesSelection(
                            recipeText: "Regional delicacy",
                            onTap: () {
                              Provider.of<RegionalDelicacyProvider>(context,
                                      listen: false)
                                  .showRegionalDelicacyParameterDetails(
                                      context, "Regional Delicacy");
                            },
                          ),
                          const SizedBox(height: 30),
                          //ends Regional delicacy

                          //here are the Kitchen resources
                          CustomRecipesSelection(
                            recipeText: "Kitchen resources",
                            onTap: () {
                              Provider.of<KitchenResourcesProvider>(context,
                                      listen: false)
                                  .showKitchenResourcesParameterDetails(
                                      context, "Kitchen Resources");
                            },
                          ),
                          const SizedBox(height: 30),
                          //ends Kitchen resources
                        ],
                      ),
                      showFoodStyle
                          ? Padding(
                              padding: const EdgeInsets.only(top: 69.0),
                              child: customFoodStyle(),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  //kitchen resources ends
                  const SizedBox(height: 30),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.appColor,
                          ),
                        )
                      : Center(
                          child: AppButton.appButton(
                            "Generate",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                            height: 50,
                            width: 180,
                            backgroundColor: AppTheme.appColor,
                            onTap: () async {
                              await generateRecipe(
                                  style: addFoodStyle,
                                  allergy: allergiesProvider,
                                  dietary: restrictionsProvider,
                                  regional: delicacyProvider,
                                  kitchen: kitchenProvider);
                            },
                          ),
                        ),
                  // ignore: prefer_const_constructors
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customFoodStyle() {
    final foodStyleProvider = Provider.of<FoodStyleProvider>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.appColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: SizedBox(
          width: 227,
          height: 260,
          child: GestureDetector(
            onTap: () {
              // This handles the tap outside the list
              setState(() {
                showFoodStyle = false;
              });
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: foodStyle.length,
              itemBuilder: (context, int index) {
                int max = foodStyle.length;
                return InkWell(
                  onTap: () {
                    setState(() {
                      foodStyleProvider.clearFoodStyleValue();
                      showFoodStyle = false;
                      addFoodStyle.insert(0, foodStyle[index]);
                      foodStyleProvider.setFoodStyleValue(foodStyle[index]);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.appColor,
                    ),
                    child: Padding(
                      padding: index == 0 ? const EdgeInsets.only(top: 10.0) : (index == max -1 ? const EdgeInsets.only(bottom: 10.0) :  const EdgeInsets.symmetric(vertical: 0.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: AppText.appText(
                              foodStyle[index],
                              fontSize: 18,
                              textColor: AppTheme.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color:
                                  // foodStyle[index] == "Thai cuisine"
                                  //     ? Colors.transparent
                                  //     :
                                  AppTheme.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future generateRecipe({style, allergy, dietary, regional, kitchen}) async {
    setState(() {
      isLoading = true;
    });
    final foodStyleProvider = Provider.of<FoodStyleProvider>(context,listen: false);
    final allergiesProvider =
        Provider.of<AllergiesProvider>(context, listen: false);
    final restrictionsProvider =
        Provider.of<DietaryRestrictionsProvider>(context, listen: false);
    final proteinProvider =
        Provider.of<PreferredProteinProvider>(context, listen: false);
    final delicacyProvider =
        Provider.of<RegionalDelicacyProvider>(context, listen: false);
    final kitchenProvider =
        Provider.of<KitchenResourcesProvider>(context, listen: false);
    // const apiKey = 'd9186e5f351240e094658382be62d948';
    const apiKey = '6fee21631c5c432dba9b34b9070a2d31';
    final style = foodStyleProvider.foodStyle.isNotEmpty
        ? "&cuisine=${foodStyleProvider.foodStyle.toString().substring(1, foodStyleProvider.foodStyle.toString().length - 1)}"
        : "";
    final kitchenResources = kitchenProvider.addKitchenResources.isNotEmpty
        ? "&equipment=${kitchenProvider.addKitchenResources.toString().substring(1, kitchenProvider.addKitchenResources.toString().length - 1)}"
        : "";
    final preferredProtein = proteinProvider.addProtein.isNotEmpty
        ? "&includeIngredients=${proteinProvider.addProtein.toString().substring(1, proteinProvider.addProtein.toString().length - 1)}"
        : "";
    final allergies = allergiesProvider.addAllergies.isNotEmpty
        ? "&intolerances=${allergiesProvider.addAllergies.toString().substring(1, allergiesProvider.addAllergies.toString().length - 1)}"
        : "";
    final dietaryRestrictions = restrictionsProvider
            .addDietaryRestrictions.isNotEmpty
        ? "&diet=${restrictionsProvider.addDietaryRestrictions.toString().substring(1, restrictionsProvider.addDietaryRestrictions.toString().length - 1)}"
        : "";
    final regionalDelicacy = delicacyProvider.addRegionalDelicacy.isNotEmpty
        ? "query=${delicacyProvider.addRegionalDelicacy.toString().substring(1, delicacyProvider.addRegionalDelicacy.toString().length - 1)}"
        : "";
    final apiUrl =
        '${AppUrls.spoonacularBaseUrl}/recipes/complexSearch?$regionalDelicacy$style$kitchenResources$preferredProtein$allergies$dietaryRestrictions&number=8&apiKey=$apiKey';

    final response = await spoonDio.get(path: apiUrl);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      pushReplacement(
          context,
          BottomNavView(
            type: 1,
            offset: response.data["offset"],
            totalResults: response.data["totalResults"],
            foodStyle: foodStyleProvider.foodStyle,
            searchType: 1,
            data: response.data["results"],
          ));
      setState(() {
        isLoading = false;
      });
    } else {
      if (response.statusCode == 402) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "${response.statusMessage}");
      } else {
        setState(() {
          isLoading = false;
        });
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }
}
