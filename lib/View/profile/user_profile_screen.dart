import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
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
  bool showMenu = false;
  bool checkAPI = false;

  //initializing Global variables for DIO package
  late AppDio dio;
  AppLogger logger = AppLogger();
  String myName = "Howdy Sir!";

  //final data stores and sent to UpdateAPI
  final _userNameController = TextEditingController();
  Map<String, dynamic> addAllergies = {};
  Map<String, dynamic> addDietaryRestrictions = {};
  Map<String, dynamic> allergies = {};
  Map<String, dynamic> dietaryRestrictions = {};
  DateTime? selectedDate;

  //------------------------------------//
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
  void initState() {
    //initializing DIO on initial state
    dio = AppDio(context);
    logger.init();
    getUserName();
    loadselectParamsfromAPI(); //-----------------//
    super.initState();
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
                  Container(
                    height: 40,
                    child: TextFormField(
                      cursorColor: AppTheme.appColor,
                      style: TextStyle(color: AppTheme.appColor, fontWeight: FontWeight.w500),
                      controller: _userNameController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.only(left: 12, bottom: 3),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          disabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: AppTheme.appColor,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          hintText: myName,
                          hintStyle: TextStyle(
                              color: AppTheme.appColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  ),
                  // const SizedBox(height: 10),
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
                                      print(
                                          "how much data has been added here${addDietaryRestrictions[key] = value}");
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        /* where i am converting the map keys into list so that i can call them in
                         profile screen to fetch the data from sharedpreference
                          by calling the keys and match them */
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
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      textColor: Colors.white,
                      height: 50,
                      width: 180,
                      backgroundColor: AppTheme.appColor,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.appColor,
                    ),
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
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
    if(addAllergies.isEmpty){
      arrangeIndexParam["allergies[0]"] = "0";
    }else {
      for (var data in addAllergies.entries) {
        String key = "allergies[${index}]";
        String key2 = data.key;
        dynamic value = data.value;
        arrangeIndexParam[key] = key2;
        index++;
      }
    }
    if(addDietaryRestrictions.isEmpty){
      arrangeIndexParam2["dietary_restrictions[0]"] = "0";
    }else{
      for (var data in addDietaryRestrictions.entries) {
        String key = "dietary_restrictions[${index1}]";
        String key2 = data.key;
        dynamic value = data.value;
        arrangeIndexParam2[key] = key2;
        index1++;
      }
    }
    if (selectedDate == null) {
      showSnackBar(context, "select DOB");
      setState(() {
        checkAPI = false;
      });
    } else if (_userNameController.text.isEmpty) {
      showSnackBar(context, "field cannot be empty");
      setState(() {
        checkAPI = false;
      });
    }
    Map<String, dynamic> params = {
      "name": _userNameController.text,
      "DOB": DateFormat('yyyy-MM-dd').format(selectedDate!),
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
            showSnackBar(context, "${responseData["message"]}");
            // print("Something Went Wrong: ${responseData["message"]}");
          } else {
            setState(() {
              checkAPI = false;
            });
            print("everything is alright");
            pushReplacement(
                context,
                BottomNavView(
                  allergies: addAllergies.values,
                  dietaryRestrictions: addDietaryRestrictions,
                ));
          }
          break;
        default:
          setState(() {
            checkAPI = false;
          });
          // Handle other response codes here if needed.
          break;
      }

      // if (response.statusCode == responseCode400) {
      //   setState(() {
      //     checkAPI =false;
      //   });
      //   print("Bad Request.");
      // } else if (response.statusCode == responseCode401) {
      //   setState(() {
      //     checkAPI =false;
      //   });
      //   print("Unauthorized access.");
      // } else if (response.statusCode == responseCode404) {
      //   setState(() {
      //     checkAPI =false;
      //   });
      //   print(
      //       "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
      // } else if (response.statusCode == responseCode500) {
      //   setState(() {
      //     checkAPI =false;
      //   });
      //   print("Internal server error.");
      // } else if (response.statusCode == responseCode200) {
      //   if(responseData["status"] == false){
      //     setState(() {
      //       checkAPI =false;
      //     });
      //     print("Something Went Wrong: ${responseData["message"]}");
      //   } else {
      //     print("every thing is alright");
      //
      //     // pushReplacement(
      //     //     context,
      //     //     BottomNavView(
      //     //       allergies: addAllergies,
      //     //       dietaryRestrictions: addDietaryRestrictions,
      //     //     ));
      //   }
      //
      // }
    } catch (e) {
      setState(() {
        checkAPI = false;
      });
      print("Something went Wrong ${e}");
    }
  }

  StoreDatainSharedPref(allergies, dietryRestriction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_userNameController.text.isEmpty) {
      showSnackBar(context, "field cannot be empty");
      setState(() {
        checkAPI == false;
      });
    } else if (selectedDate == null) {
      showSnackBar(context, "select DOB");
      setState(() {
        checkAPI == false;
      });
    } else {
      prefs.setString(PrefKey.userName, _userNameController.text);
      prefs.setString(
          PrefKey.dateOfBirth, DateFormat('MM-dd-yyyy').format(selectedDate!));
    }
    prefs.setStringList(PrefKey.dataonBoardScreenAllergies, allergies);
    prefs.setStringList(
        PrefKey.dataonBoardScreenDietryRestriction, dietryRestriction);
    setState(() {
      checkAPI == false;
    });
  }

  loadselectParamsfromAPI() async {
    var response;
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500; // Internal server error.
    try {
      response = await dio.get(
        path: AppUrls.searchParameterUrl,
      );
      var responseData = response.data;
      switch (response.statusCode) {
        case responseCode400:
          print("Bad Request.");
          break;
        case responseCode401:
          print("Unauthorized access.");
          break;
        case responseCode404:
          print(
              "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            print("Something Went Wrong: ${responseData["message"]}");
          } else {
            var data = responseData["data"]["allergies"];
            var data2 = responseData["data"]["dietaryRestrictions"];
            setState(() {
              allergies = data;
              dietaryRestrictions = data2;
            });
            print("everything is alright");
          }
          break;
        default:
          // Handle other response codes here if needed.
          break;
      }
    } catch (e) {
      print("Something went Wrong ${e}");
    }
  }

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString(PrefKey.userName);
    setState(() {
      _userNameController.text = userName!;
    });
    print("profile_name $myName");
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
