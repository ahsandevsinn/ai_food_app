import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SearchRecipesScreen extends StatefulWidget {
  const SearchRecipesScreen({Key? key}) : super(key: key);

  @override
  State<SearchRecipesScreen> createState() => _SearchRecipesScreenState();
}

class _SearchRecipesScreenState extends State<SearchRecipesScreen> {
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

  //start of allergies
  List allergies = [
    "Dairy",
    "Peanut",
    "Seafood",
    "Sesame",
    "Wheat",
    "Soy",
    "Sulfite",
    "Gluten",
    "Egg",
    "Grain",
    "Tree nut",
    "Shellfish",
  ];
  List<String> addAllergies = [];
  //ends of allergies
  //start of dietary Restrictions
  List dietaryRestrictions = [
    "Gluten free",
    "ketogenic",
    "Vegetarian",
    "Lacto-Vegetarian",
    "Ovo-Vegetarian",
    "Vegan",
    "Pescetarian",
    "Paleo",
    "Primal",
    "Low FODMAP",
    "Whole30",
    "Shellfish",
  ];
  List<String> addDietaryRestrictions = [];
  //ends of dietary Restrictions

  //start of Preferred Protein
  List<String> preferredProtein = [
    "Fish",
    "Seafood",
    "Lean beef",
    "Skim milk",
    "Skim yogurt",
    "Eggs",
    "Lean port",
    "Low-fat cheese",
    "Beans",
    "Skinless, white meat-poultry",
  ];
  List<String> addPreferredProtein = [];
  //ends of Preferred Protein

  //start of Regional Delicacy
  List<String> regionalDelicacy = [
    'Italian Pizza',
    'Mexican Tacos',
    'Japanese Sushi',
    'Chinese Dumplings',
    'Indian Curry',
    'French Baguette',
    'Italian Pasta',
    'Thai Pad Thai',
    'Greek Souvlaki',
    'American Burger',
  ];
  List<String> addRegionalDelicacy = [];
  //ends of Regional Delicacy

  //start of Kitchen Resources
  List<String> kitchenResources = [
    'Blender',
    'Colander',
    'Chef\'s knife',
    'Cutting board',
    'Frying pan',
    'Knife',
    'Immersion blender',
    'Salad Spinner',
    'Peeler',
    'Parchment paper',
    'Stock pot',
    'Spoon',
    'Sheet pan',
    'Measuring cup',
    'Measuring spoon',
    'Whisk',
    'Tongs',
    'Wooden spoon',
    'Bowl',
    'Oven',
    'Microwave',
    'Food processor',
    'Slow cooker',
  ];
  List<String> addKitchenResources = [];
  //ends of Kitchen Resources

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        // color: Colors.blueGrey,
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
                              border: Border.all(color: AppTheme.appColor,width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.appText(
                                    addFoodStyle.isEmpty
                                        ? "Food Style"
                                        : addFoodStyle[0]
                                        .toString(),
                                    fontSize: 18,
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
                              border: Border.all(color: AppTheme.appColor,width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.appText(
                                    addServingSize.isEmpty
                                        ? "Serving Size"
                                        : addServingSize[0]
                                        .toString(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppTheme.appColor),
                                !showServingSize
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
                      AppText.appText(
                        "Allergies:",
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        textColor: AppTheme.appColor,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: allergies.map((allergy) {
                          return CustomContainer(
                            containerColor:
                            addAllergies.contains(allergy)
                                ? AppTheme.appColor
                                : Colors.white,
                            text: allergy,
                            textColor:
                            addAllergies.contains(allergy)
                                ? Colors.white
                                : AppTheme.appColor,
                            onTap: () {
                              setState(() {
                                if (addAllergies
                                    .contains(allergy)) {
                                  addAllergies.remove(allergy);
                                  print(
                                      "allergy_is ${allergy} an list ${addAllergies.toString().substring(1, addAllergies.toString().length - 1)}");
                                } else {
                                  addAllergies.add(allergy);
                                  print(
                                      "allergy_is ${allergy} an list ${addAllergies.toString().substring(1, addAllergies.toString().length - 1)}");
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      //allergies ends
                      const SizedBox(height: 20),
                      AppText.appText(
                        "Dietary restrictions:",
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        textColor: AppTheme.appColor,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                        dietaryRestrictions.map((restriction) {
                          return CustomContainer(
                            containerColor: addDietaryRestrictions
                                .contains(restriction)
                                ? AppTheme.appColor
                                : Colors.white,
                            textColor: addDietaryRestrictions
                                .contains(restriction)
                                ? Colors.white
                                : AppTheme.appColor,
                            text: restriction,
                            onTap: () {
                              setState(() {
                                if (addDietaryRestrictions
                                    .contains(restriction)) {
                                  addDietaryRestrictions
                                      .remove(restriction);
                                  print(
                                      "restriction_is ${restriction} an list ${addDietaryRestrictions.toString().substring(1, addDietaryRestrictions.toString().length - 1)}");
                                } else {
                                  addDietaryRestrictions
                                      .add(restriction);
                                  print(
                                      "restriction_is ${restriction} an list ${addDietaryRestrictions.toString().substring(1, addDietaryRestrictions.toString().length - 1)}");
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      //dietary restrictions ends
                    ],
                  ),
                  showServingSize
                      ? Padding(
                    padding: const EdgeInsets.only(top: 123.0),
                    child: customServingSize(),
                  )
                      : const SizedBox.shrink(),
                  showFoodStyle
                      ? Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: customFoodStyle(),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 20),
              AppText.appText(
                "Preferred Protein:",
                fontSize: 22,
                fontWeight: FontWeight.w800,
                textColor: AppTheme.appColor,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                preferredProtein.map((protein) {
                  return CustomContainer(
                    containerColor: addPreferredProtein
                        .contains(protein)
                        ? AppTheme.appColor
                        : Colors.white,
                    textColor: addPreferredProtein
                        .contains(protein)
                        ? Colors.white
                        : AppTheme.appColor,
                    text: protein,
                    onTap: () {
                      setState(() {
                        if (addPreferredProtein
                            .contains(protein)) {
                          addPreferredProtein
                              .remove(protein);
                          print(
                              "preferredProtein_is ${protein} an list ${addPreferredProtein.toString().substring(1, addPreferredProtein.toString().length - 1)}");
                        } else {
                          addPreferredProtein
                              .add(protein);
                          print(
                              "preferredProtein_is ${protein} an list ${addPreferredProtein.toString().substring(1, addPreferredProtein.toString().length - 1)}");
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              //preferred proteins ends
              const SizedBox(height: 20),
              AppText.appText(
                "Regional Delicacy:",
                fontSize: 22,
                fontWeight: FontWeight.w800,
                textColor: AppTheme.appColor,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                regionalDelicacy.map((delicacy) {
                  return CustomContainer(
                    containerColor: addRegionalDelicacy
                        .contains(delicacy)
                        ? AppTheme.appColor
                        : Colors.white,
                    textColor: addRegionalDelicacy
                        .contains(delicacy)
                        ? Colors.white
                        : AppTheme.appColor,
                    text: delicacy,
                    onTap: () {
                      setState(() {
                        if (addRegionalDelicacy
                            .contains(delicacy)) {
                          addRegionalDelicacy
                              .remove(delicacy);
                          print(
                              "regionalDelicacy_is ${delicacy} an list ${addRegionalDelicacy.toString().substring(1, addRegionalDelicacy.toString().length - 1)}");
                        } else {
                          addRegionalDelicacy
                              .add(delicacy);
                          print(
                              "regionalDelicacy_is ${delicacy} an list ${addRegionalDelicacy.toString().substring(1, addRegionalDelicacy.toString().length - 1)}");
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              //regional delicacy ends
              const SizedBox(height: 20),
              AppText.appText(
                "Kitchen resources:",
                fontSize: 22,
                fontWeight: FontWeight.w800,
                textColor: AppTheme.appColor,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                kitchenResources.map((resources) {
                  return CustomContainer(
                    containerColor: addKitchenResources
                        .contains(resources)
                        ? AppTheme.appColor
                        : Colors.white,
                    textColor: addKitchenResources
                        .contains(resources)
                        ? Colors.white
                        : AppTheme.appColor,
                    text: resources,
                    onTap: () {
                      setState(() {
                        if (addKitchenResources
                            .contains(resources)) {
                          addKitchenResources
                              .remove(resources);
                          print(
                              "regionalDelicacy_is ${resources} an list ${addKitchenResources.toString().substring(1, addKitchenResources.toString().length - 1)}");
                        } else {
                          addKitchenResources
                              .add(resources);
                          print(
                              "regionalDelicacy_is ${resources} an list ${addKitchenResources.toString().substring(1, addKitchenResources.toString().length - 1)}");
                        }
                      });
                    },
                  );
                }).toList(),
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
                    // push(context, ForgotPasswordScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget customFoodStyle() {
    return Card(
      color: AppTheme.appColor,
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
    return Card(
      color: AppTheme.appColor,
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

  // BorderRadiusGeometry customBorderRadius() {
  //   if (foodStyle.length == 1) {
  //     return const BorderRadius.only(
  //       topLeft: Radius.circular(10),
  //       topRight: Radius.circular(10),
  //     );
  //   } else if (foodStyle.length == 12) {
  //     return const BorderRadius.only(
  //       bottomLeft: Radius.circular(10),
  //       bottomRight: Radius.circular(10),
  //     );
  //   }
  //   return const BorderRadius.only();
  // }

}
