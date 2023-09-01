import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/showRecipesLists.dart';
import 'package:ai_food/View/HomeScreen/widgets/widget.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _searchController = TextEditingController();
  bool showFoodStyle = false;
  bool showServingSize = false;

  //start food style
  List foodStyle = [
    'Italian cuisine',
    'Mexican cuisine',
    'Greek cuisine',
    'Spanish cuisine',
    'Indian cuisine',
    'Japanese cuisine',
    'American cuisine',
    'Turkish cuisine',
    'French cuisine',
    'Chinese cuisine',
    'Brazilian cuisine',
    'Thai cuisine',
  ];
  List<String> addFoodStyle = [];
  //ends of food style

  //start serving size
  List servingSize = [
    '1-2 Persons',
    '2-3 Persons',
    '3-4 Persons',
    '4-5 Persons',
    '5-6 Persons',
    '6+ Persons',
  ];
  List<String> addServingSize = [];
  //ends of serving size

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final allergiesProvider = Provider.of<AllergiesProvider>(context, listen: true);
    final restrictionsProvider = Provider.of<DietaryRestrictionsProvider>(context, listen: true);
    final proteinProvider = Provider.of<PreferredProteinProvider>(context, listen: true);
    final delicacyProvider = Provider.of<RegionalDelicacyProvider>(context, listen: true);
    final kitchenProvider = Provider.of<KitchenResourcesProvider>(context, listen: true);
    print("geting_data addAllergies${allergiesProvider.addAllergies.toString().substring(1, allergiesProvider.addAllergies.toString().length - 1)}");
    print("geting_data addDietaryRestrictions${restrictionsProvider.addDietaryRestrictions.toString().substring(1, restrictionsProvider.addDietaryRestrictions.toString().length - 1)}");
    print("geting_data proteinProvider${proteinProvider.addProtein.toString().substring(1, proteinProvider.addProtein.toString().length - 1)}");
    print("geting_data delicacyProvider${delicacyProvider.addRegionalDelicacy.toString().substring(1, delicacyProvider.addRegionalDelicacy.toString().length - 1)}");
    print("geting_data kitchenProvider${kitchenProvider.addKitchenResources.toString().substring(1, kitchenProvider.addKitchenResources.toString().length - 1)}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
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
                    controller: _searchController,
                    autofocus: true,
                    cursorColor: AppTheme.appColor,
                    style: TextStyle(color: AppTheme.appColor),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: AppTheme.whiteColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a recipe';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _autoValidateMode = AutovalidateMode.disabled;
                      });
                    },
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xffb38ade),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                ),
                child: const Icon(Icons.search_outlined, size: 40),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppText.appText(
                "Food Choices:",
                fontSize: 22,
                fontWeight: FontWeight.w800,
                textColor: AppTheme.appColor,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showFoodStyle = !showFoodStyle;
                          showServingSize = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 48,
                          width: 227,
                          decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppTheme.appColor, width: 2)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.appText(
                                    addFoodStyle.isEmpty
                                        ? "Food Style"
                                        : addFoodStyle[0].toString(),
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
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showServingSize = !showServingSize;
                          showFoodStyle = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 48,
                          width: 227,
                          decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppTheme.appColor, width: 2)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.appText(
                                    addServingSize.isEmpty
                                        ? "Serving Size"
                                        : addServingSize[0].toString(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppTheme.appColor),
                                !showServingSize
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
                      const SizedBox(height: 20),

                      //here are the allergies
                      CustomRecipesSelection(
                        recipeText: "Allergies",
                        onTap: () {
                          Provider.of<AllergiesProvider>(context, listen: false)
                              .showAllergiesParameterDetails(
                                  context, "Allergies");
                        },
                      ),
                      const SizedBox(height: 20),
                      //ends allergies

                      //here are the Dietary restrictions
                      CustomRecipesSelection(
                        recipeText: "Dietary restrictions",
                        onTap: () {
                          Provider.of<DietaryRestrictionsProvider>(context, listen: false)
                              .showDietaryRestrictionsParameterDetails(
                              context, "Dietary Restrictions");
                        },
                      ),
                      const SizedBox(height: 20),
                      //ends Dietary restrictions

                      //here are the Regional delicacy
                      CustomRecipesSelection(
                        recipeText: "Preferred protein",
                        onTap: () {
                          Provider.of<PreferredProteinProvider>(context, listen: false)
                              .showProteinParameterDetails(
                              context, "Preferred Protein");
                        },
                      ),
                      const SizedBox(height: 20),
                      //ends Regional delicacy

                      //here are the Regional delicacy
                      CustomRecipesSelection(
                        recipeText: "Regional delicacy",
                        onTap: () {
                          Provider.of<RegionalDelicacyProvider>(context, listen: false)
                              .showRegionalDelicacyParameterDetails(
                              context, "Regional Delicacy");
                        },
                      ),
                      const SizedBox(height: 20),
                      //ends Regional delicacy

                      //here are the Kitchen resources
                      CustomRecipesSelection(
                        recipeText: "Kitchen resources",
                        onTap: () {
                          Provider.of<KitchenResourcesProvider>(context, listen: false)
                              .showKitchenResourcesParameterDetails(
                              context, "Kitchen Resources");
                        },
                      ),
                      const SizedBox(height: 20),
                      //ends Kitchen resources
                    ],
                  ),
                  showServingSize
                      ? Padding(
                          padding: const EdgeInsets.only(top: 127.0),
                          child: customServingSize(),
                        )
                      : const SizedBox.shrink(),
                  showFoodStyle
                      ? Padding(
                          padding: const EdgeInsets.only(top: 59.0),
                          child: customFoodStyle(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              //kitchen resources ends
              const SizedBox(height: 30),
              Center(
                child: AppButton.appButton(
                  "Generate",
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  textColor: Colors.white,
                  height: 50,
                  width: 180,
                  backgroundColor: AppTheme.appColor,
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
    );
  }

  Widget customFoodStyle() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.appColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
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
                return InkWell(
                  onTap: () {
                    setState(() {
                      showFoodStyle = false;
                      addFoodStyle.insert(0, foodStyle[index]);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.appColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        AppText.appText(
                          "${foodStyle[index]}",
                          fontSize: 18,
                          textColor: AppTheme.whiteColor,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2.0,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
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

  Widget customServingSize() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.appColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
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
              itemCount: servingSize.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      showServingSize = false;
                      addServingSize.insert(0, servingSize[index]);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.appColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        AppText.appText(
                          "${servingSize[index]}",
                          fontSize: 18,
                          textColor: AppTheme.whiteColor,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2.0,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
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
}
