import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/View/auth/auth_screen.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late AppDio dio;
  AppLogger logger = AppLogger();
  final _userNameController = TextEditingController();
  List<int> numberListShow = [];
  bool showMenu = false;
  var responseData;
  //allergies
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

  List<String> addAllergies = [];
  List<String> addDietaryRestrictions = [];

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 23),
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage(
                  AppAssetsImage.profile_text_background,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: AppText.appText(
                      "Jassica Hanson",
                      fontWeight: FontWeight.w500,
                      textColor: AppTheme.appColor,
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppTheme.appColor,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showMenu = !showMenu;
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 4),
                            child: AppText.appText("DOB:YYYY-MM-DD",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textColor: AppTheme.appColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppTheme.appColor,
                    endIndent: 40,
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
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
                                borderColor:
                                    addDietaryRestrictions.contains(allergy)
                                        ? AppTheme.whiteColor
                                        : AppTheme.appColor,
                                containerColor: addAllergies.contains(allergy)
                                    ? AppTheme.appColor
                                    : Colors.white,
                                text: allergy,
                                textColor: addAllergies.contains(allergy)
                                    ? Colors.white
                                    : AppTheme.appColor,
                                onTap: () {
                                  setState(() {
                                    if (addAllergies.contains(allergy)) {
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
                          const SizedBox(height: 30),
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
                            children: dietaryRestrictions.map((restriction) {
                              return CustomContainer(
                                borderColor:
                                    addDietaryRestrictions.contains(restriction)
                                        ? AppTheme.whiteColor
                                        : AppTheme.appColor,
                                containerColor:
                                    addDietaryRestrictions.contains(restriction)
                                        ? AppTheme.appColor
                                        : Colors.white,
                                textColor:
                                    addDietaryRestrictions.contains(restriction)
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
                                      addDietaryRestrictions.add(restriction);
                                      print(
                                          "restriction_is ${restriction} an list ${addDietaryRestrictions.toString().substring(1, addDietaryRestrictions.toString().length - 1)}");
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      showMenu ? customMenu() : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: AppButton.appButton(
                "Save",
                onTap: () {
                  print("allergies:$addAllergies  and restrictions: $addDietaryRestrictions");
                  getSuggestedRecipes(
                      allergies: addAllergies,
                      dietaryRestrictions: addDietaryRestrictions,
                      // context: context
                      );
                },
                fontSize: 20,
                fontWeight: FontWeight.w800,
                textColor: Colors.white,
                height: 50,
                width: 180,
                backgroundColor: AppTheme.appColor,
              ),
            ),
            const SizedBox(height: 30),
            // Center(
            //   child: _isSigningOut
            //       ? const CircularProgressIndicator(
            //           valueColor:
            //               AlwaysStoppedAnimation<Color>(Colors.white),
            //         )
            //       : AppButton.appButton(
            //           "SignOut",
            //           fontSize: 20,
            //           fontWeight: FontWeight.w800,
            //           textColor: Colors.white,
            //           height: 50,
            //           width: 180,
            //           backgroundColor: AppTheme.appColor,
            //           onTap: () async {
            //             setState(() {
            //               _isSigningOut = true;
            //             });
            //             await Authentication.signOut(context: context);
            //             setState(() {
            //               _isSigningOut = false;
            //             });
            //
            //             push(context, const AuthScreen());
            //           },
            //         ),
            // ),
          ],
        ),
      ),
    );
  }

  // Here is the code of custom menu
  Widget customMenu() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 110,
        height: 230,
        child: GestureDetector(
          onTap: () {
            setState(() {
              showMenu = false;
            });
          },
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 80,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (numberListShow.isNotEmpty) {
                      numberListShow.removeAt(0);
                    }
                    showMenu = false;
                    numberListShow.insert(0, index + 1);
                    print("number_is ${numberListShow[0]}");
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      AppText.appText(
                        "${index + 1}",
                        fontSize: 18,
                        textColor: AppTheme.appColor,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: AppTheme.appColor,
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
    );
  }

  getSuggestedRecipes({allergies, dietaryRestrictions}) async {
    const apiKey = 'd9186e5f351240e094658382be62d948';
    final allergiesAre = allergies.isNotEmpty ? "${allergies.join(',').toLowerCase()}" : "";
    final dietaryRestrictionsAre = dietaryRestrictions.isNotEmpty ? "${dietaryRestrictions.join(',').toLowerCase()}" : "";

    print("allergies_are $allergiesAre dietary_restrictions $dietaryRestrictionsAre");

    String apiFinalUrl;

    if (allergies.isEmpty && dietaryRestrictions.isNotEmpty) {
      // Only dietary restrictions are present
      apiFinalUrl = 'https://api.spoonacular.com/recipes/random?number=8&tags=$dietaryRestrictionsAre&apiKey=$apiKey';
    } else if (allergies.isNotEmpty && dietaryRestrictions.isEmpty) {
      // Only allergies are present
      apiFinalUrl = 'https://api.spoonacular.com/recipes/random?number=8&tags=$allergiesAre&apiKey=$apiKey';
    } else if (allergies.isNotEmpty && dietaryRestrictions.isNotEmpty) {
      // Both allergies and dietary restrictions are present
      apiFinalUrl = 'https://api.spoonacular.com/recipes/random?number=8&tags=$allergiesAre,$dietaryRestrictionsAre&apiKey=$apiKey';
    } else {
      // Both are empty
      apiFinalUrl = 'https://api.spoonacular.com/recipes/random?number=8&apiKey=$apiKey';
    }
    // final apiUrl =
    //     'https://api.spoonacular.com/recipes/random?number=8&tags=${allergies.toString().substring(1, allergies.toString().length - 1)},${dietaryRestrictions.toString().substring(1, dietaryRestrictions.toString().length - 1)}&apiKey=$apiKey';
        // 'https://api.spoonacular.com/recipes/random?number=8${allergies.toLowerCase()}&apiKey=$apiKey';
    // 'https://api.spoonacular.com/recipes/random?number=8&apiKey=$apiKey';

    try {
      var response;
      print(apiFinalUrl);
      response = await dio.get(path: apiFinalUrl);
      if (response.statusCode == 200) {
        print("jfdjbjeb${responseData}");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavView(
            responseData: response.data["recipes"],
          ),
        ));
        responseData = response.data["recipes"];
      } else {
        showSnackBar(context, "Something Went Wrong!");
      }
    } catch (e) {
      print(e);
    }
  }
}

class CustomContainer extends StatelessWidget {
  final text;
  final Function() onTap;
  final Color textColor;
  final Color containerColor;
  final borderColor;
  const CustomContainer(
      {super.key,
      this.text,
      required this.onTap,
      required this.textColor,
      required this.containerColor,
      this.borderColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 2)),
        child: AppText.appText(
          text,
          textColor: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
