import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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
  var responseData;
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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.appColor, // Change the primary color
            colorScheme: ColorScheme.light(
                primary: AppTheme.appColor), // Change overall color scheme
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            measuringUnit = false;
          });
        });
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppAssetsImage.profile_text_background,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
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
                            hintStyle: TextStyle(color: AppTheme.appColor),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                          "DOB: ${selectedDate == null ? "${selectedDateFromPref == ""?"MM-DD-YYYY":selectedDateFromPref}" : DateFormat('MM-dd-yyyy').format(selectedDate!)}",
                                          fontSize: 11.sp,
                                          textColor: AppTheme.appColor),
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
                                          updatedvalueM == ""
                                              ? "Measuring Unit"
                                              : updatedvalueM,
                                          fontSize: 18,
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
                        Row(
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
                                )),
                          ],
                        ),
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
                          fontWeight: FontWeight.w800,
                          textColor: AppTheme.appColor,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: dietaryRestrictions.entries.map((restriction) {
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
                                    addDietaryRestrictions
                                        .remove(key);
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
                    Positioned(
                      top: 8.5.h,
                      right: 0,
                      child: measuringUnit
                          ? customMeasuringUnit()
                          : const SizedBox.shrink(),
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
                  onTap: ()async {
                    setState(() {
                      checkAPI = true;
                    });
                    SaveUnit();
                    List<String> allergiesList = addAllergies.entries
                        .map((value) => value.toString())
                        .toList();
                    List<String> dietaryRestrictionsList = addDietaryRestrictions.entries
                        .map((value) => value.toString())
                        .toList();
                   await StoreDatainSharedPref(allergiesList,dietaryRestrictionsList);
                    await UpdateSetupProfileOnUpdateAPI();
                  },
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  textColor: Colors.white,
                  height: 50,
                  width: 180,
                  backgroundColor: AppTheme.appColor,
                ),
              ): Center(child: CircularProgressIndicator(color: AppTheme.appColor),),
              const SizedBox(height: 30),
            ],
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
              borderRadius: BorderRadius.circular(5),
              color: AppTheme.whiteColor,
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
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: measuringUnitListShow.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          measuringUnit = false;
                          updatedvalueM = measuringUnitListShow.elementAt(index);
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppText.appText(
                              "${measuringUnitListShow[index]}",
                              fontSize: 18,
                              textColor: AppTheme.appColor,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.0,
                                    color: AppTheme.appColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SaveUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString(PrefKey.unit, updatedvalueM);
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
          path: AppUrls.searchParameterUrl,  queryParameters: {"search": 0});
      var responseData = response.data;
      switch (response.statusCode) {
        case responseCode400:
          print("Bad Request.");
          break;
        case responseCode401:
          print("Unauthorized access.");
          break;
        case responseCode404:
          print("The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            showSnackBar(context, "${responseData["message"]}");
          } else {
            var data = responseData["data"]["allergies"];
            var data2 = responseData["data"]["dietaryRestrictions"];
            //this condition is to make sure that if server didn;t work or server don't load the data.
            if (data == null &&data2 == null ) {
              showSnackBar(context, "Something went wrong reload the page");
            }
            //-----------------//
            //when data is loaded
            else {
              setState(() {
                allergies = data;
                dietaryRestrictions = data2;
              });
            }
            showSnackBar(context, "selection Loaded from API");
            //----------------------//

          }
          break;
        default:
        // Handle other response codes here if needed.
          break;
      }
    } catch (e) {
      showSnackBar(context, "Reload the page ${e}");
    }
  }
  LoadingSelectedDataFromSetupProfileScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedDateFromPref= prefs.getString(PrefKey.dateOfBirth);
      List<String> storedData =prefs.getStringList(PrefKey.dataonBoardScreenAllergies)!;
        for (String entry in storedData) {
          String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
          List<String> parts = result.split(':');
          if (parts.length == 2) {
            String key = parts[0].trim();
            String value = parts[1].trim();
           addAllergies[key] = value;
          }
        }
      List<String> storedData2 =prefs.getStringList(PrefKey.dataonBoardScreenDietryRestriction)!;
      for (String entry in storedData2) {
        String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
        List<String> parts = result.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          String value = parts[1].trim();
          addDietaryRestrictions[key] = value;
        }
      }
      _userNameController.text= prefs.getString(PrefKey.userName)!;
      updatedvalueM==""? "US": prefs.getString(PrefKey.unit);
    });
    showSnackBar(context, "Data is Loaded from SharedPreference");
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
    for (var data in addAllergies.entries) {
      String key = "allergies[${index}]";
      String key2 = data.key;
      dynamic value = data.value;
      arrangeIndexParam[key] = key2;
      index++;
    }
    for (var data in addDietaryRestrictions.entries) {
      String key = "dietary_restrictions[${index1}]";
      String key2 = data.key;
      dynamic value = data.value;
      arrangeIndexParam2[key] = key2;
      index1++;
    }
    //----------------------//
    //check if username is empty or not
    if (_userNameController.text.isEmpty) {
      showSnackBar(context, "field cannot be empty");
      setState(() {
        checkAPI = false;
      });
    }
    Map<String, dynamic> params = {
      "name": _userNameController.text,
      "DOB": selectedDateFromPref?? DateFormat('yyyy-MM-dd').format(selectedDate!),
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
          print("The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
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
    selectedDate == null?prefs.setString(PrefKey.dateOfBirth, selectedDateFromPref!):prefs.setString(PrefKey.dateOfBirth, DateFormat('MM-dd-yyyy').format(selectedDate!));
    prefs.setStringList(PrefKey.dataonBoardScreenAllergies, allergies);
    prefs.setStringList(PrefKey.dataonBoardScreenDietryRestriction, dietryRestriction);
    showSnackBar(context, "Data is saved in SharedPreference");
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
