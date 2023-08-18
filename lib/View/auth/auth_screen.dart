import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:25, right: 25, bottom: 25, top: 40),
          child: Container(
            height: MediaQuery.of(context).size.height*0.93,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: login == true
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.appText("Sign In",
                          textColor: AppTheme.appColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                      AppText.appText("Sign In to Continue",
                          textColor: AppTheme.appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.appText("Sign Up",
                          textColor: AppTheme.appColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                      AppText.appText("Create your Account",
                          textColor: AppTheme.appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                ),
                Customcard(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  login = true;
                                });
                              },
                              child: AppText.appText("Sign In",
                                  textColor: login == true
                                      ? AppTheme.appColor
                                      : AppTheme.primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600)),
                          login == true
                              ? SizedBox(
                            height: 5,
                            width: 90,
                            child: Divider(
                              color: AppTheme.appColor,
                              thickness: 2.0,
                              height: 20.0,
                            ),
                          )
                              : const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  login = false;
                                });
                              },
                              child: AppText.appText("Sign Up",
                                  textColor: login == false
                                      ? AppTheme.appColor
                                      : AppTheme.primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600)),
                          login == false
                              ? SizedBox(
                            height: 5,
                            width: 95,
                            child: Divider(
                              color: AppTheme.appColor,
                              thickness: 2.0,
                              height: 20.0,
                            ),
                          )
                              : const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ],
                  ),
                  login == true
                      ? Column(
                    children: [
                      CustomAppFormField(
                          texthint: "Email or Mobile number",
                          controller: _nameController),
                      CustomAppFormField(
                        texthint: "Enter password",
                        controller: _passwordController,
                        suffix: Icon(Icons.visibility),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      CustomAppFormField(
                          height: 50,
                          texthint: "Enter full name",
                          controller: _nameController),
                      CustomAppFormField(
                          height: 50,
                          texthint: "Enter email",
                          controller: _emailController),
                      CustomAppFormField(
                          height: 50,
                          texthint: "Enter mobile number",
                          controller: _phoneController),
                      CustomAppFormField(
                        height: 50,
                        texthint: "Enter password",
                        controller: _passwordController,
                        obscureText: false,
                        suffix: Icon(
                          Icons.visibility,
                          color: AppTheme.appColor,
                        ),
                      ),
                      CustomAppFormField(
                        height: 50,
                        texthint: "Confirm password",
                        controller: _confirmPasswordController,
                        obscureText: false,
                        suffix: Icon(
                          Icons.visibility,
                          color: AppTheme.appColor,
                        ),
                      ),
                    ],
                  ),
                  login == true
                      ? AppButton.appButton("Sign In",
                      backgroundColor: AppTheme.appColor,
                      textColor: Colors.white,
                      width: 180,
                      height: 40,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)
                      : AppButton.appButton("Sign Up",
                      backgroundColor: AppTheme.appColor,
                      textColor: Colors.white,
                      width: 180,
                      height: 40,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)
                ]),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: AppButton.appButtonWithLeadingIcon(
                          "Continue with Apple",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          textColor: AppTheme.appColor,
                          icons: Icons.apple,
                          height: 48,
                          width: 320),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: AppButton.appButtonWithLeadingIcon(
                          "Continue with Google",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          textColor: AppTheme.appColor,
                          height: 48,
                          width: 320),
                    ),
                    SizedBox(height: 20,),
                    login == true
                        ? InkWell(
                      onTap: () {
                        setState(() {
                          login = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText.appText("Don't have an Account?",
                              textColor: AppTheme.appColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          AppText.appText("Sign Up",
                              textColor: AppTheme.appColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              underLine: true),
                        ],
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        setState(() {
                          login = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText.appText("Already have an Account?",
                              textColor: AppTheme.appColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          AppText.appText("Sign In",
                              textColor: AppTheme.appColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              underLine: true),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
