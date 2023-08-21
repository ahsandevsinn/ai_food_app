import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_button.dart';
import 'package:ai_food/View/auth/ForgotPassword/forget_password.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<NewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppText.appText(
                        "Forget Password",
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        textColor: AppTheme.appColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppText.appText(
                      "Set new password",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: AppTheme.appColor,
                    ),
                  ),
                  sizedBox(height * .1, width),
                  Opacity(
                    opacity: 0.70,
                    child: Container(
                        width: width * .9,
                        height: height * .6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.appColor,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: 0.1,
                              child: Column(
                                children: [
                                  sizedBox(20, 0),
                                  Container(
                                    child: Image.asset(
                                      AppAssetsImage.appLogo,
                                      height: 350,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Column(
                                children: [
                                  sizedBox(height * .1, width),
                                  CustomAppFormField(
                                    controller: newPasswordController,
                                    texthint: "Enter new password",
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                          color: AppTheme.appColor,
                                        )),
                                  ),
                                  CustomAppFormField(
                                    controller: newPasswordController,
                                    texthint: "Confirm password",
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                          color: AppTheme.appColor,
                                        )),
                                  ),
                                  sizedBox(height * 0.28, width),
                                  const CustomButton(
                                    text: "Confirm",
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
