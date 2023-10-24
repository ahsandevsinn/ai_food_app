import 'dart:convert';

import 'package:ai_food/Constants/apikey.dart';
import 'package:ai_food/Utils/logout.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/errordialogue.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_logger.dart';
import 'widgets/providers/chat_bot_provider.dart';

class RecipeParamScreen extends StatefulWidget {
  const RecipeParamScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeParamScreen> createState() => _RecipeParamScreenState();
}

class _RecipeParamScreenState extends State<RecipeParamScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool showFoodStyle = false;
  var isLoadedfromShared;

  //start food style
  List<String> foodStyle = [];
  List<String> addFoodStyle = [];

  late AppDio dio;
  late SpoonAcularAppDio spoonDio;

  AppLogger logger = AppLogger();

  bool isLoading = false;
  bool isLoadingSearch = false;
  bool checkLoadDataFromAPI = false;
  bool NoInternetConnection = false;

  @override
  void initState() {
    dio = AppDio(context);
    spoonDio = SpoonAcularAppDio(context);
    logger.init();
    loadconditionfromSharedPref();
    setRecipesParameters();
    super.initState();
  }
  void loadconditionfromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoadedfromShared = prefs.getInt(PrefKey.conditiontoLoad)!;
    });
    print("check what is going on here${isLoadedfromShared}");
  }

  void setRecipesParameters() async {
    final allergiesProvider =
        Provider.of<AllergiesProvider>(context, listen: false);
    final dietaryRestrictionProvider =
        Provider.of<DietaryRestrictionsProvider>(context, listen: false);
    var response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode405 = 405; // Method not allowed
    const int responseCode500 = 500; // Internal server error.
    setState(() {
      checkLoadDataFromAPI = false;
    });
    try {
      response = await dio.get(path: AppUrls.searchParameterUrl);
      var responseData = response.data;
      if (response.statusCode == responseCode405) {
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode404) {
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode400) {
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          if (responseData["data"]["statusCode"] == 403) {
            alertDialogErrorBan(
                context: context, message: "${responseData["message"]}");
          } else {
            showSnackBar(context, "${responseData["message"]}");
          }
        } else {
          setState(() {
            checkLoadDataFromAPI = true;
          });
          var encodeData = jsonEncode(responseData);
          prefs.setString(PrefKey.parametersLists, encodeData);

          final allergyProvider =
              Provider.of<AllergiesProvider>(context, listen: false)
                  .preferredAllergiesRecipe;
          final dietaryRestrictionsProvider =
              Provider.of<DietaryRestrictionsProvider>(context, listen: false)
                  .preferredDietaryRestrictionsParametersRecipe;
          final preferredProteinProvider =
              Provider.of<PreferredProteinProvider>(context, listen: false)
                  .preferredProteinRecipe;
          final regionalDelicacyProvider =
              Provider.of<RegionalDelicacyProvider>(context, listen: false)
                  .preferredRegionalDelicacyParametersRecipe;
          final kitchenResourcesProvider =
              Provider.of<KitchenResourcesProvider>(context, listen: false)
                  .preferredKitchenResourcesParametersRecipe;
          var foodStyles = responseData["data"]["foodStyles"];
          var allergies = responseData["data"]["allergies"];
          var dietaryRestrictions = responseData["data"]["dietaryRestrictions"];
          var preferredProteins = responseData["data"]["preferredProteins"];
          var regionalDelicacies = responseData["data"]["regionalDelicacies"];
          var kitchenResources = responseData["data"]["kitchenResources"];

          //adding food styles list
          foodStyles.forEach((key, value) {
            foodStyle.add(value);
          });

          //adding allergies list
          if (allergyProvider.isEmpty) {
            allergies.forEach((key, value) {
              allergyProvider.add(RecipesParameterClass(parameter: value));
            });
          }

          //adding dietary restrictions list
          if (dietaryRestrictionsProvider.isEmpty) {
            dietaryRestrictions.forEach((key, value) {
              dietaryRestrictionsProvider
                  .add(RecipesParameterClass(parameter: value));
            });
          }

          //adding proteins list
          if (preferredProteinProvider.isEmpty) {
            preferredProteins.forEach((key, value) {
              preferredProteinProvider
                  .add(RecipesParameterClass(parameter: value));
            });
          }

          //adding regional delicacy list
          if (regionalDelicacyProvider.isEmpty) {
            regionalDelicacies.forEach((key, value) {
              regionalDelicacyProvider
                  .add(RecipesParameterClass(parameter: value));
            });
          }

          //adding kitchen resources list
          if (kitchenResourcesProvider.isEmpty) {
            kitchenResources.forEach((key, value) {
              kitchenResourcesProvider
                  .add(RecipesParameterClass(parameter: value));
            });
          }
          if (isLoadedfromShared == 1) {
            print("dkjasdkljaklsdjklasndklajsdklasjkdnjkasdklnaskldnlak");
            List<String> storedData =
                prefs.getStringList(PrefKey.dataonBoardScreenAllergies)!;
            allergiesProvider.showAllergiesParameterDetailsload(
                context, "Allergies");
            for (String entry in storedData) {
              String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
              List<String> parts = result.split(':');
              if (parts.length == 2) {
                int key = int.parse(parts[0].trim()) - 1;
                String value = parts[1].trim();
                if (allergiesProvider.preferredAllergiesRecipe[key].isChecked ==
                    false) {
                  allergiesProvider.toggleAllergiesRecipeState(key);
                  allergiesProvider.addAllergiesValue(value, key);
                }
              }
            }
            print("dkjasdkljaklsdjklasndklajsdklasjkdnjkasdklnaskldnlak");
            List<String> storedData2 = prefs
                .getStringList(PrefKey.dataonBoardScreenDietryRestriction)!;
            dietaryRestrictionProvider
                .showDietaryRestrictionsParameterDetailsload(
                    context, "Dietary Restrictions");
            for (String entry in storedData2) {
              String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
              List<String> parts = result.split(':');
              if (parts.length == 2) {
                int key = int.parse(parts[0].trim()) - 1;
                String value = parts[1].trim();
                if (dietaryRestrictionProvider
                        .preferredDietaryRestrictionsParametersRecipe[key]
                        .isChecked ==
                    false) {
                  dietaryRestrictionProvider
                      .toggleDietaryRestrictionsRecipeState(key);
                  dietaryRestrictionProvider.addDietaryRestrictionsValue(
                      value, key);
                }
              }
            }
          }
        }
      }
    } catch (e) {
      setState(() {
        checkLoadDataFromAPI = true;
        NoInternetConnection = true;
      });
      print("Something went Wrong ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final foodStyleProvider =
        Provider.of<FoodStyleProvider>(context, listen: false);
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
    return checkLoadDataFromAPI == false
        ?  Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: width,
              height: height,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppTheme.appColor,
              )),
            ),
          ):NoInternetConnection == true?Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/internet_lost.png',
                height: 200, width: 200),
            const SizedBox(height: 30),
            AppText.appText(
              "No Internet Connection",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: AppTheme.appColor,
            ),
            const SizedBox(height: 10),
            AppText.appText(
              "Check your connection, then refresh the \n page",
              fontWeight: FontWeight.bold,
              textColor: AppTheme.appColor,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            AppButton.appButton(
              "Refresh",
              onTap: (){
                pushReplacement(context, BottomNavView());
              },
              width: 100,
              height: 40,
              border: true,
              textColor: AppTheme.appColor,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    ): Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  toolbarHeight: 1,
                  leading: SizedBox.shrink(),
                ),
                body: GestureDetector(
                  onTap: () {
                    setState(() {
                      showFoodStyle = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            scale: 0.5,
                            opacity: 0.15)),
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 28),
                            Container(
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xffd9c4ef),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: SizedBox(
                                      width: width * 0.65,
                                      child: TextFormField(
                                        onFieldSubmitted: (value) {
                                          if(_searchController.text == "" || _searchController.text.isEmpty){
                                            showSnackBar(context, "Please type something.");
                                          } else {
                                            getFood(context);
                                          }
                                        },
                                        textInputAction: TextInputAction.search,
                                        controller: _searchController,
                                        autofocus: false,
                                        cursorColor: AppTheme.appColor,
                                        style: TextStyle(color: AppTheme.whiteColor),
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'Find recipes',
                                          hintStyle: TextStyle(
                                              color: AppTheme.whiteColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a recipe';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          // setState(() {
                                          //   _autoValidateMode = AutovalidateMode.disabled;
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if(_searchController.text == "" || _searchController.text.isEmpty){
                                        showSnackBar(context, "Please type something.");
                                      } else {
                                        getFood(context);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFB38ADE),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(100),
                                                bottomRight: Radius.circular(100)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                            // child: SvgPicture.asset("assets/images/Search.svg",
                                            child: isLoadingSearch ? SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: CircularProgressIndicator(color: AppTheme.whiteColor,)) : AppText.appText("Find",
                                              textColor: AppTheme.whiteColor,
                                              fontWeight: FontWeight.bold,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            AppText.appText(
                              "Food choices:",
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              textColor: AppTheme.appColor,
                            ),
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showFoodStyle = !showFoodStyle;
                                        });
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 227,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            border: Border.all(
                                                color: AppTheme.appColor,
                                                width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText.appText(
                                                  foodStyleProvider
                                                          .foodStyle.isEmpty
                                                      ? "Food style"
                                                      : foodStyleProvider
                                                          .foodStyle,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppTheme.appColor),
                                              !showFoodStyle
                                                  ? Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      color: AppTheme.appColor,
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .keyboard_arrow_up_outlined,
                                                      color: AppTheme.appColor,
                                                      size: 30,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    //here are the allergies
                                    CustomRecipesSelection(
                                      widget: chipWidget(
                                          details:
                                              allergiesProvider.addAllergies),
                                      recipeText: "Allergies",
                                      showListDataInChip:
                                          allergiesProvider.addAllergies,
                                      onTap: () {
                                        Provider.of<AllergiesProvider>(context,
                                                listen: false)
                                            .showAllergiesParameterDetails(
                                                context, "Allergies");
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    //ends allergies

                                    //here are the Dietary restrictions
                                    CustomRecipesSelection(
                                      widget: chipWidget(
                                          details: restrictionsProvider
                                              .addDietaryRestrictions),
                                      recipeText: "Dietary restrictions",
                                      showListDataInChip: restrictionsProvider
                                          .addDietaryRestrictions,
                                      onTap: () {
                                        Provider.of<DietaryRestrictionsProvider>(
                                                context,
                                                listen: false)
                                            .showDietaryRestrictionsParameterDetails(
                                                context,
                                                "Dietary Restrictions");
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    //ends Dietary restrictions

                                    //here are the Regional delicacy
                                    CustomRecipesSelection(
                                      widget: chipWidget(
                                          details: proteinProvider.addProtein),
                                      recipeText: "Preferred protein",
                                      showListDataInChip:
                                          proteinProvider.addProtein,
                                      onTap: () {
                                        Provider.of<PreferredProteinProvider>(
                                                context,
                                                listen: false)
                                            .showProteinParameterDetails(
                                                context, "Preferred Protein");
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    //ends Regional delicacy

                                    //here are the Regional delicacy
                                    CustomRecipesSelection(
                                      widget: chipWidget(
                                          details: delicacyProvider
                                              .addRegionalDelicacy),
                                      recipeText: "Regional delicacy",
                                      showListDataInChip:
                                          delicacyProvider.addRegionalDelicacy,
                                      onTap: () {
                                        Provider.of<RegionalDelicacyProvider>(
                                                context,
                                                listen: false)
                                            .showRegionalDelicacyParameterDetails(
                                                context, "Regional Delicacy");
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    //ends Regional delicacy

                                    //here are the Kitchen resources
                                    CustomRecipesSelection(
                                      widget: chipWidget(
                                          details: kitchenProvider
                                              .addKitchenResources),
                                      recipeText: "Kitchen resources",
                                      showListDataInChip:
                                          kitchenProvider.addKitchenResources,
                                      onTap: () {
                                        Provider.of<KitchenResourcesProvider>(
                                                context,
                                                listen: false)
                                            .showKitchenResourcesParameterDetails(
                                                context, "Kitchen Resources");
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    //ends Kitchen resources
                                  ],
                                ),
                                showFoodStyle
                                    ? customFoodStyle()
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            //kitchen resources ends
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  //allergies
                                  if (allergiesProvider
                                          .addAllergies.isNotEmpty ||
                                      restrictionsProvider
                                          .addDietaryRestrictions.isNotEmpty ||
                                      proteinProvider.addProtein.isNotEmpty ||
                                      kitchenProvider
                                          .addKitchenResources.isNotEmpty ||
                                      delicacyProvider
                                          .addRegionalDelicacy.isNotEmpty ||
                                      foodStyleProvider.foodStyle.isNotEmpty) {
                                    //  allergies
                                    allergiesProvider.removeAllergyParams();
                                    allergiesProvider
                                        .clearAllergiesAllCheckboxStates();
                                    //restrictions
                                    restrictionsProvider
                                        .removeDietaryRestrictions();
                                    restrictionsProvider
                                        .clearDietaryRestrictionsAllCheckboxStates();
                                    //protein
                                    proteinProvider.removePreferredProtein();
                                    proteinProvider
                                        .clearProteinAllCheckboxStates();
                                    //delicacy
                                    delicacyProvider.removeRegionalDelicacy();
                                    delicacyProvider
                                        .clearRegionalDelicacyAllCheckboxStates();
                                    //kitchen
                                    kitchenProvider.removeKitchenResources();
                                    kitchenProvider
                                        .clearKitchenResourcesAllCheckboxStates();
                                    //food style
                                    foodStyleProvider.clearFoodStyleValue();
                                    showSnackBar(
                                        context, "Filters Reset Succesfully");
                                  }
                                },
                                child: AppText.appText(
                                  "Reset filters",
                                  fontSize: 16,
                                  underLine: true,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppTheme.appColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
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
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  100) *
                                              45,
                                      height: 50,
                                      backgroundColor: AppTheme.appColor,
                                      onTap: () async {
                                        await generateRecipe(
                                            style: addFoodStyle,
                                            allergy: allergiesProvider,
                                            dietary: restrictionsProvider,
                                            regional: delicacyProvider,
                                            kitchen: kitchenProvider);
                                        //removeSearchQueryValueFromPref();
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

  // removeSearchQueryValueFromPref() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(PrefKey.searchQueryParameter);
  // }

  Widget customFoodStyle() {
    final foodStyleProvider =
        Provider.of<FoodStyleProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.appColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
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
                        padding: index == 0
                            ? const EdgeInsets.only(top: 10.0)
                            : (index == max - 1
                                ? const EdgeInsets.only(bottom: 10.0)
                                : const EdgeInsets.symmetric(vertical: 0.0)),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 14),
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
      ),
    );
  }

  Future generateRecipe({style, allergy, dietary, regional, kitchen}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response;
    setState(() {
      isLoading = true;
    });
    prefs.setInt(PrefKey.conditiontoLoad, 0);
    final foodStyleProvider =
        Provider.of<FoodStyleProvider>(context, listen: false);
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
    final style = foodStyleProvider.foodStyle.isNotEmpty
        ? "&cuisine=${foodStyleProvider.foodStyle}"
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
    final apiUrlTwo =
        '${AppUrls.spoonacularBaseUrl}/recipes/complexSearch?$regionalDelicacy$style$kitchenResources$preferredProtein$allergies$dietaryRestrictions&number=8&apiKey=$apiKey2';

    try {
      response = await spoonDio.get(path: apiUrl);
      if (response.statusCode == 200) {
        pushReplacement(
            context,
            BottomNavView(
              urlString: apiUrl.split("&apiKey=$apiKey").toString().substring(
                  1, apiUrl.split("&apiKey=$apiKey").toString().length - 3),
              type: 1,
              offset: response.data["offset"],
              totalResults: response.data["totalResults"],
              foodStyle: foodStyleProvider.foodStyle,
              searchList: List.generate(
                  response.data["results"].length, (index) => false),
              searchType: 1,
              data: response.data["results"],
            ));
        setState(() {
          isLoading = false;
        });
      } else {
        if (response.statusCode == 402) {
          response = await spoonDio.get(path: apiUrlTwo);
          if (response.statusCode == 402) {
            showSnackBar(context, "${response.statusMessage}");
          } else {
            pushReplacement(
              context,
              BottomNavView(
                urlString: apiUrlTwo
                    .split("&apiKey=$apiKey2")
                    .toString()
                    .substring(
                        1,
                        apiUrlTwo.split("&apiKey=$apiKey2").toString().length -
                            3),
                type: 1,
                offset: response.data["offset"],
                totalResults: response.data["totalResults"],
                foodStyle: foodStyleProvider.foodStyle,
                searchList: List.generate(
                    response.data["results"].length, (index) => false),
                searchType: 1,
                data: response.data["results"],
              ),
            );
          }
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;

          });
          print(
              'API request with the second key failed with status code: ${response.statusCode}');
          showSnackBar(context, "${response.statusMessage}");
          print('API request failed with status code: ${response.statusCode}');
          showSnackBar(context, "${response.statusMessage}");
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, response == null ?  "Something went wrong.": "${response.statusCode}");
    }
  }

  chipWidget({details}) {
    String itemsText = details.join(', ');
    return Text(
      textAlign: TextAlign.left,
      "${itemsText}",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppTheme.appColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
    );
  }





  Future<void> getFood(context) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLoadingSearch = true;
    });

    var searchtext = _searchController.text;
    if(searchtext.isNotEmpty){
      // pref.setString(PrefKey.searchQueryParameter, searchtext);
    }else{}

    final apiUrl =
        '${AppUrls.spoonacularBaseUrl}/recipes/complexSearch?query=$searchtext&apiKey=$apiKey';

    final apiUrl2 =
        '${AppUrls.spoonacularBaseUrl}/recipes/complexSearch?query=$searchtext&apiKey=$apiKey2';

    try {
      final response = await spoonDio.get(path: apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          isLoadingSearch = false;
        });
        pushReplacement(
          context,
          BottomNavView(
            urlString: apiUrl.split("&apiKey=$apiKey").toString().substring(
                1, apiUrl.split("&apiKey=$apiKey").toString().length - 3),
            searchType: 0,
            type: 1,
            data: response.data["results"],
            searchList: List.generate(response.data["results"].length, (index) => false),
            query: searchtext,
            offset: response.data["offset"],
          ),
        );

        // _searchController.clear();
      }else if (response.statusCode == 402) {
        try{
          var responseApi2 = await spoonDio.get(path: apiUrl2);
          if (responseApi2.statusCode == 200) {
            setState(() {
              isLoadingSearch = false;
            });
            pushReplacement(
              context,
              BottomNavView(
                urlString: apiUrl2
                    .split("&apiKey=$apiKey2")
                    .toString()
                    .substring(
                    1,
                    apiUrl2.split("&apiKey=$apiKey2").toString().length -
                        3),
                searchType: 0,
                type: 1,
                data: responseApi2.data["results"],
                searchList: List.generate(responseApi2.data["results"].length, (index) => false),
                query: searchtext,
                offset: responseApi2.data["offset"],
              ),
            );
            print("status_code is ${responseApi2.statusCode}");
          } else if(responseApi2.statusCode == 402){
            setState(() {
              isLoadingSearch = false;
            });
            showSnackBar(context, "${responseApi2.statusMessage}");
          }
        }catch(e){
          print("Catch eroor"+e.toString());
        }
        setState(() {
          isLoadingSearch = false;
          // randomData = true;
          // errorResponse = response.data["message"];
          // print("l;nkwkdn${response.data["message"]}");
        });
        // showSnackBar(context, "${response.statusMessage}");
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('API request failed with error: $error');
    } finally {
      // Set isLoading to false when the API call completes (success or failure)
    }
  }


}
