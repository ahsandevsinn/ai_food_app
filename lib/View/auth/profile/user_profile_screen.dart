import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/auth/ForgotPassword/forget_password.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _userNameController = TextEditingController();
  List<int> numberListShow = [];
  bool showMenu = false;

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
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              showMenu = false;
            });
          });
        },
        child: Scaffold(
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(AppAssetsImage.profile_text_background),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: CustomAppFormField(
                      texthint: "User name",
                      controller: _userNameController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showMenu = !showMenu;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 110,
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 3),
                                            child: AppText.appText(
                                                numberListShow.isEmpty
                                                    ? "Age"
                                                    : numberListShow[0]
                                                        .toString(),
                                                fontSize: 18,
                                                textColor: AppTheme.appColor),
                                          ),
                                          const SizedBox(width: 45),
                                          !showMenu
                                              ? Transform.rotate(
                                                  angle: 360 * math.pi / 245,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
                                                    color: AppTheme.appColor,
                                                    size: 20,
                                                  ),
                                                )
                                              : Transform.rotate(
                                                  angle: 360 * math.pi / 145,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
                                                    color: AppTheme.appColor,
                                                    size: 20,
                                                  ),
                                                ),
                                          // Icon(Icons.arrow_back_ios_outlined, color: AppTheme.appColor),
                                          // DropdownButton<int>(
                                          //   underline: Container(),
                                          //   elevation: 0,
                                          //   iconEnabledColor: AppTheme.appColor,
                                          //   value: selectedNumber,
                                          //   onChanged: (newValue) {
                                          //     setState(() {
                                          //       selectedNumber = newValue!;
                                          //     });
                                          //     print("selected_numve ${selectedNumber}");
                                          //   },
                                          //   items:
                                          //       numberList.map<DropdownMenuItem<int>>((int value) {
                                          //     return DropdownMenuItem<int>(
                                          //       value: value,
                                          //       child: AppText.appText(
                                          //         value.toString(),
                                          //         textColor: AppTheme.appColor,
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 110,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: AppTheme.appColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 40),
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
                                        containerColor: addAllergies.contains(allergy)
                                                ? AppTheme.appColor
                                                : Colors.white,
                                        text: allergy,
                                        textColor:
                                            addAllergies.contains(allergy)
                                                ? Colors.white
                                                : AppTheme.appColor,
                                        onTap: () {
                                          setState(() {
                                            if (addAllergies.contains(allergy)) {
                                              addAllergies.remove(allergy);
                                              print("allergy_is ${allergy} an list ${addAllergies.toString().substring(1, addAllergies.toString().length - 1)}");
                                            } else {
                                              addAllergies.add(allergy);
                                              print("allergy_is ${allergy} an list ${addAllergies.toString().substring(1, addAllergies.toString().length - 1)}");
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 10),
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
                                        containerColor: addDietaryRestrictions.contains(restriction)
                                            ? AppTheme.appColor
                                            : Colors.white,
                                        textColor: addDietaryRestrictions.contains(restriction)
                                            ? Colors.white
                                            : AppTheme.appColor,
                                        text: restriction,
                                        onTap: () {
                                          setState(() {
                                            if (addDietaryRestrictions.contains(restriction)) {
                                              addDietaryRestrictions.remove(restriction);
                                              print("restriction_is ${restriction} an list ${addDietaryRestrictions.toString().substring(1, addDietaryRestrictions.toString().length - 1)}");
                                            } else {
                                              addDietaryRestrictions.add(restriction);
                                              print("restriction_is ${restriction} an list ${addDietaryRestrictions.toString().substring(1, addDietaryRestrictions.toString().length - 1)}");
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            showMenu
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 28.0),
                                    child: customMenu(),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: AppButton.appButton(
                      "Save",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      textColor: Colors.white,
                      height: 50,
                      width: 180,
                      backgroundColor: AppTheme.appColor,
                      onTap: (){
                        push(context, const ForgetPassword());
                        // push(context, const ForgotPasswordPage());
                      }
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Here is the code of custom menu
  Widget customMenu() {
    return Card(
      child: SizedBox(
        width: 130,
        height: 230,
        child: GestureDetector(
          onTap: () {
            // This handles the tap outside the list
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
                    showMenu = false;
                    numberListShow.insert(0, index + 1);
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
                        margin: const EdgeInsets.symmetric(horizontal: 14),
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
}

class CustomContainer extends StatelessWidget {
  final text;
  final Function() onTap;
  final Color textColor;
  final Color containerColor;
  const CustomContainer(
      {super.key,
      this.text,
      required this.onTap,
      required this.textColor,
      required this.containerColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 40,
        // margin: EdgeInsets.only(left: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.appColor, width: 2)),
        child: AppText.appText(
          text,
          // textColor: AppTheme.appColor,
          textColor: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
