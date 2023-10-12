import 'dart:convert';

import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../HomeScreen/widgets/providers/dietary_restrictions_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AppDio dio;
  AppLogger logger = AppLogger();
  final _userNameController = TextEditingController();
  List<int> numberListShow = [];
  List<String> measuringUnitListShow = [
    "US",
    "Metric",
  ];
  bool checkAPI = false;
  String updatedvalueM = "US";
  bool showMenu = false;
  bool measuringUnit = false;

  Map<String, dynamic> addAllergies = {};
  Map<String, dynamic> addDietaryRestrictions = {};
  Map<String, dynamic> allergies = {};
  Map<String, dynamic> dietaryRestrictions = {};

  DateTime? selectedDate;
  String? selectedDateFromPref;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.appColor, // Change the primary color
            colorScheme: ColorScheme.light(
                primary: AppTheme.appColor), // Change overall color scheme
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
  void initState() {
    dio = AppDio(context);
    logger.init();
    loadselectParamsfromAPI();
    LoadingSelectedDataFromSetupProfileScreen();

    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void loadselectParamsfromAPI() async {
    var recipesParams;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? recipesParamsJson = prefs.getString(PrefKey.parametersLists);

    if (recipesParamsJson != null) {
      try {
        recipesParams = jsonDecode(recipesParamsJson);
        allergies = recipesParams["data"]["allergies"];
        dietaryRestrictions = recipesParams["data"]["dietaryRestrictions"];
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    } else {
      print("recipesParamsJson is null");
    }
    selectedDateFromPref = prefs.getString(PrefKey.dateOfBirth);
    print("check if i recieve the data of birth${selectedDateFromPref}");
    List<String> storedData =
        prefs.getStringList(PrefKey.dataonBoardScreenAllergies)!;

    for (String entry in storedData) {
      String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
      List<String> parts = result.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();
        addAllergies[key] = value;
      }
    }
    List<String> storedData2 =
        prefs.getStringList(PrefKey.dataonBoardScreenDietryRestriction)!;
    for (String entry in storedData2) {
      String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
      List<String> parts = result.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();
        addDietaryRestrictions[key] = value;
      }
    }
    _userNameController.text = prefs.getString(PrefKey.userName)!;
    updatedvalueM = prefs.getString(PrefKey.unit)!;
  }

  @override
  Widget build(BuildContext context) {
    final allergiesProvider = Provider.of<AllergiesProvider>(context, listen: false);
    final dietaryRestrictionsProvider = Provider.of<DietaryRestrictionsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            measuringUnit = false;
          });
        });
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  scale: 0.5,
                  opacity: 0.25)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 220,
                  child: SvgPicture.asset(
                    AppAssetsImage.profile_updated_image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,

                    // color: AppTheme.whiteColor,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: CustomAppFormField(
                              texthint: "User name",
                              controller: _userNameController,
                              fontweight: FontWeight.w500,
                              hintStyle: TextStyle(
                                  color: AppTheme.appColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        fit: FlexFit.tight,
                                        child: AppText.appText(
                                          "DOB: ${selectedDate == null ? "${selectedDateFromPref == "" ? "MM-DD-YYYY" : selectedDateFromPref}" : DateFormat('MM-dd-yyyy').format(selectedDate!)}",
                                          fontSize: 11.sp,
                                          textColor: AppTheme.appColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppTheme.appColor,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      measuringUnit = !measuringUnit;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        flex: 4,
                                        child: AppText.appText(
                                            updatedvalueM == null
                                                ? "Measuring Unit"
                                                : updatedvalueM,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppTheme.appColor),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Icon(
                                          !measuringUnit
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                          color: AppTheme.appColor,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Divider(
                                      thickness: 1,
                                      color: AppTheme.appColor,
                                    )),
                                const SizedBox(
                                  width: 40,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Divider(
                                    thickness: 1,
                                    color: AppTheme.appColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            children: allergies.entries.map((allergy) {
                              String key = allergy.key;
                              dynamic value = allergy.value;
                              return CustomContainer(
                                borderColor: addAllergies.containsKey(key)
                                    ? AppTheme.whiteColor
                                    : AppTheme.appColor,
                                containerColor: addAllergies.containsKey(key)
                                    ? AppTheme.appColor
                                    : Colors.white,
                                text: value.toString(),
                                textColor: addAllergies.containsKey(key)
                                    ? Colors.white
                                    : AppTheme.appColor,
                                onTap: () {
                                  setState(() {
                                    if (addAllergies.containsKey(key)) {
                                      addAllergies.remove(key);
                                    } else {
                                      addAllergies[key] = value;
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
                            children:
                                dietaryRestrictions.entries.map((restriction) {
                              String key = restriction.key;
                              dynamic value = restriction.value;
                              return CustomContainer(
                                borderColor:
                                    addDietaryRestrictions.containsKey(key)
                                        ? AppTheme.whiteColor
                                        : AppTheme.appColor,
                                containerColor:
                                    addDietaryRestrictions.containsKey(key)
                                        ? AppTheme.appColor
                                        : Colors.white,
                                textColor:
                                    addDietaryRestrictions.containsKey(key)
                                        ? Colors.white
                                        : AppTheme.appColor,
                                text: value.toString(),
                                onTap: () {
                                  setState(() {
                                    if (addDietaryRestrictions
                                        .containsKey(key)) {
                                      addDietaryRestrictions.remove(key);
                                    } else {
                                      addDietaryRestrictions[key] = value;
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      measuringUnit
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 77),
                                child: customMeasuringUnit(),
                              ))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                checkAPI == false
                    ? Center(
                        child: AppButton.appButton(
                          "Save",
                          onTap: () async {
                            setState(() {
                              checkAPI = true;
                            });


                            allergiesProvider.showAllergiesParameterDetailsload(context, "Allergies");
                            allergiesProvider.removeAllergyParams();
                            allergiesProvider.clearAllergiesAllCheckboxStates();
                            addAllergies.forEach((key, value) {
                              int intKey = int.parse(key) -1;
                               //allergiesProvider.toggleAllergiesRecipeStatefalse(intKey);
                              if (allergiesProvider.preferredAllergiesRecipe[intKey].isChecked == false) {
                                allergiesProvider.toggleAllergiesRecipeState(intKey);
                                allergiesProvider.addAllergiesValue(value, intKey);
                              }
                            });
                            dietaryRestrictionsProvider.showDietaryRestrictionsParameterDetailsload(context, "Dietary Restrictions");
                            dietaryRestrictionsProvider.removeDietaryRestrictions();
                            dietaryRestrictionsProvider.clearDietaryRestrictionsAllCheckboxStates();
                            addDietaryRestrictions.forEach((key, value) {
                              int intKey = int.parse(key) -1;
                              dietaryRestrictionsProvider.toggleDietaryRestrictionsRecipeStatefalse(intKey);
                              if (dietaryRestrictionsProvider.preferredDietaryRestrictionsParametersRecipe[intKey].isChecked == false) {
                                dietaryRestrictionsProvider.toggleDietaryRestrictionsRecipeState(intKey);
                                dietaryRestrictionsProvider.addDietaryRestrictionsValue(value, intKey);
                              }
                            });
                            allListsProviders();
                            SaveUnit();
                            List<String> allergiesList = addAllergies.entries
                                .map((value) => value.toString())
                                .toList();
                            List<String> dietaryRestrictionsList =
                                addDietaryRestrictions.entries
                                    .map((value) => value.toString())
                                    .toList();
                            await StoreDatainSharedPref(
                                allergiesList, dietaryRestrictionsList);
                            await UpdateSetupProfileOnUpdateAPI();
                          },
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          width: 200,
                          height: 48,
                          backgroundColor: AppTheme.appColor,
                        ),
                      )
                    : Center(
                        child:
                            CircularProgressIndicator(color: AppTheme.appColor),
                      ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customMeasuringUnit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: AppTheme.appColor,
            ),
            height: 110,
            width: MediaQuery.of(context).size.width * 0.415,
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      measuringUnit = false;
                    });
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: measuringUnitListShow.map((value) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      measuringUnit = false;
                                      updatedvalueM = value;
                                    });
                                  },
                                  child: AppText.appText(
                                    value,
                                    fontSize: 18,
                                    textColor: AppTheme.whiteColor,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: AppTheme.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }


   allListsProviders() {
     final allergiesProvider = Provider.of<AllergiesProvider>(context, listen: false);
     final dietaryRestrictionsProvider = Provider.of<DietaryRestrictionsProvider>(context, listen: false);
  }

  SaveUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefKey.unit, updatedvalueM);
  }

  LoadingSelectedDataFromSetupProfileScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {});
    // showSnackBar(context, "Data is Loaded from SharedPreference");
  }

  UpdateSetupProfileOnUpdateAPI() async {
    var response;
    Map<String, dynamic> arrangeIndexParam = {};
    Map<String, dynamic> arrangeIndexParam2 = {};
    int index = 0;
    int index1 = 0;
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500; // Internal server error.

    //here creates map like allergies[0]: 4,... using for loop to insert the data;
    if (addAllergies.isEmpty) {
      arrangeIndexParam["allergies[0]"] = "0";
    } else {
      for (var data in addAllergies.entries) {
        String key = "allergies[${index}]";
        String key2 = data.key;
        dynamic value = data.value;
        arrangeIndexParam[key] = key2;
        index++;
      }
    }
    if (addDietaryRestrictions.isEmpty) {
      arrangeIndexParam2["dietary_restrictions[0]"] = "0";
    } else {
      for (var data in addDietaryRestrictions.entries) {
        String key = "dietary_restrictions[${index1}]";
        String key2 = data.key;
        dynamic value = data.value;
        arrangeIndexParam2[key] = key2;
        index1++;
      }
    }
    //----------------------//
    //check if username is empty or not
    if (_userNameController.text.isEmpty) {
      // showSnackBar(context, "field cannot be empty");
      setState(() {
        checkAPI = false;
      });
    }
    Map<String, dynamic> params = {
      "name": _userNameController.text,
      "DOB": selectedDateFromPref ??
          DateFormat('yyyy-MM-dd').format(selectedDate!),
      "measuring_unit": updatedvalueM.toLowerCase(),
      ...arrangeIndexParam,
      ...arrangeIndexParam2,
    };
    try {
      response = await dio.post(
        path: AppUrls.updateUrl,
        data: params,
      );
      var responseData = response.data;
      switch (response.statusCode) {
        case responseCode400:
          setState(() {
            checkAPI = false;
          });
          print("Bad Request.");
          break;
        case responseCode401:
          setState(() {
            checkAPI = false;
          });
          print("Unauthorized access.");
          break;
        case responseCode404:
          setState(() {
            checkAPI = false;
          });
          print(
              "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          setState(() {
            checkAPI = false;
          });
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            setState(() {
              checkAPI = false;
            });
            showSnackBar(context, "Enter your name");
          } else {
            setState(() {
              checkAPI = false;
            });
            print("everything is alright");
            Navigator.of(context).pop();
          }
          break;
        default:
          setState(() {
            checkAPI = false;
          });
          // Handle other response codes here if needed.
          break;
      }
    } catch (e) {
      //check if there is any other issue with the data from server
      setState(() {
        checkAPI = false;
      });
      print("Something went Wrong ${e}");
    }
  }

  StoreDatainSharedPref(allergies, dietryRestriction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefKey.userName, _userNameController.text);
    selectedDate == null
        ? prefs.setString(PrefKey.dateOfBirth, selectedDateFromPref!)
        : prefs.setString(PrefKey.dateOfBirth,
            DateFormat('MM-dd-yyyy').format(selectedDate!));
    prefs.setStringList(PrefKey.dataonBoardScreenAllergies, allergies);
    prefs.setStringList(
        PrefKey.dataonBoardScreenDietryRestriction, dietryRestriction);
    prefs.setInt(PrefKey.conditiontoLoad, 1);
    // showSnackBar(context, "Data is saved in SharedPreference");
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
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
