import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_card_background.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_app_bar.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SetPasswordSreen extends StatefulWidget {
  const SetPasswordSreen({super.key});

  @override
  State<SetPasswordSreen> createState() => _SetPasswordSreenState();
}

class _SetPasswordSreenState extends State<SetPasswordSreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool passwordvisible = false;
  bool confirmPasswordvisible = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.appText("Forgot Password",
                  fontSize: 25.sp,
                  textColor: AppTheme.appColor,
                  fontWeight: FontWeight.w600),
              AppText.appText(
                "Enter email or number",
                fontSize: 12.sp,
                textColor: AppTheme.appColor,
              ),
              const SizedBox(
                height: 60,
              ),
              Customcard(
                  childWidget: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      obscureText: passwordvisible,
                      controller: _passwordController,
                      cursorColor: AppTheme.appColor,
                      style: TextStyle(color: AppTheme.appColor),
                      decoration: InputDecoration(
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passwordvisible = !passwordvisible;
                                });
                              },
                              child: Icon(
                                passwordvisible == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppTheme.appColor,
                              )),
                          contentPadding: EdgeInsets.only(left: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: AppTheme.appColor,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          hintText: "Enter new password",
                          hintStyle: TextStyle(color: AppTheme.appColor)),
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      obscureText: confirmPasswordvisible,
                      controller: _confirmPasswordController,
                      cursorColor: AppTheme.appColor,
                      style: TextStyle(color: AppTheme.appColor),
                      decoration: InputDecoration(
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  confirmPasswordvisible =
                                      !confirmPasswordvisible;
                                });
                              },
                              child: Icon(
                                confirmPasswordvisible == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppTheme.appColor,
                              )),
                          contentPadding: EdgeInsets.only(left: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: AppTheme.appColor,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: AppTheme.appColor)),
                    ),
                  )),
                  const SizedBox(
                    height: 140,
                  ),
                  AppButton.appButton("Confirm",
                      onTap: () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return Text("");
                          })),
                      width: 43.w,
                      height: 5.5.h,
                      border: false,
                      backgroundColor: AppTheme.appColor,
                      textColor: AppTheme.whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
