import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String updatedvalueM = "US";
  bool showMenu = false;
  bool measuringUnit = false;
  var responseData;
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
  DateTime? selectedDate;
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
    dio = AppDio(context);
    logger.init();
    // TODO: implement initState
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
              SizedBox(
                height: 20,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
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
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
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
                                          "DOB: ${selectedDate == null ? "MM/DD/YYYY" : DateFormat('MM-dd-yyyy').format(selectedDate!)}",
                                          fontSize: 15,
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
                                  thickness: 2,
                                  color: AppTheme.appColor,
                                )),
                            const SizedBox(
                              width: 40,
                            ),
                            Flexible(
                                fit: FlexFit.loose,
                                child: Divider(
                                  thickness: 2,
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
                          children: allergies.map((allergy) {
                            return CustomContainer(
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
                                    addDietaryRestrictions.remove(restriction);
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
                    Positioned(
                      top: 68,
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
              Center(
                child: AppButton.appButton(
                  "Save",
                  onTap: () {
                    SaveUnit();
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
            height: 160,
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
                          updatedvalueM =
                              measuringUnitListShow.elementAt(index);
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
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
        ),
      ],
    );
  }

  SaveUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefKey.unit, updatedvalueM);
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.appColor, width: 2)),
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
