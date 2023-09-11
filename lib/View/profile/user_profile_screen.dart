import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _userNameController = TextEditingController();
  List<int> numberListShow = [];
  bool showMenu = false;
  DateTime? selectedDate;
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
  ];

  List<String> addAllergies = [];
  List<String> addDietaryRestrictions = [];
  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.appColor, // Change the primary color
            colorScheme: ColorScheme.light(
                primary: AppTheme.appColor), // Change overall color scheme
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
                      _selectDate(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 4),
                            child: AppText.appText(
                                "DOB: ${selectedDate == null ? "MM-DD-YYYY" : DateFormat('MM-dd-yyyy').format(selectedDate!)}",
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
                            fontWeight: FontWeight.w600,
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
                                    } else {
                                      addAllergies.add(allergy);
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
                            fontWeight: FontWeight.w600,
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
                  print(
                      "allergies:$addAllergies  and restrictions: $addDietaryRestrictions");
                  StoreDatainSharedPref(addAllergies,addDietaryRestrictions);
                  pushReplacement(
                      context,
                      BottomNavView(
                        allergies: addAllergies,
                        dietaryRestrictions: addDietaryRestrictions,
                      ));
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

  void StoreDatainSharedPref(allergies,dietryRestriction)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(PrefKey.dataonBoardScreenAllergies, allergies);
    prefs.setStringList(PrefKey.dataonBoardScreenDietryRestriction, dietryRestriction);

  }
}

class CustomContainer extends StatelessWidget {
  final text;
  final Function() onTap;
  final Color textColor;
  final Color containerColor;
  final borderColor;
  CustomContainer(
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
            border: Border.all(color: borderColor, width: 1.5)),
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
