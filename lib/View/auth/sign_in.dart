import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/View/auth/GoogleSignIn/custom_colors.dart';
import 'package:ai_food/View/auth/GoogleSignIn/google_sign_in_button.dart';
import 'package:flutter/material.dart';

class SignInScreenDuplicate extends StatefulWidget {
  const SignInScreenDuplicate({super.key});

  @override
  _SignInScreenDuplicateState createState() => _SignInScreenDuplicateState();
}

class _SignInScreenDuplicateState extends State<SignInScreenDuplicate> {
  bool login = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Row(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Customcard(children: [
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
                                height: 20,
                                width: 90,
                                child: Divider(
                                  color: AppTheme.appColor,
                                  thickness: 2.0,
                                  height: 20.0,
                                ),
                              )
                                  : const SizedBox(
                                height: 20,
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
                                height: 20,
                                width: 95,
                                child: Divider(
                                  color: AppTheme.appColor,
                                  thickness: 2.0,
                                  height: 20.0,
                                ),
                              )
                                  : const SizedBox(
                                height: 20,
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
                            suffix: const Icon(Icons.visibility),
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
                  ),
                  // const SizedBox(height: 20),
                  // const Text(
                  //   'FlutterFire',
                  //   style: TextStyle(
                  //     color: CustomColors.firebaseYellow,
                  //     fontSize: 40,
                  //   ),
                  // ),
                  // const Text(
                  //   'Authentication',
                  //   style: TextStyle(
                  //     color: CustomColors.firebaseOrange,
                  //     fontSize: 40,
                  //   ),
                  // ),
                ],
              ),
            ),
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
                      icons: Icons.apple,
                      height: 48,
                      width: 320),
                ),
                const SizedBox(height: 20,),
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
            // FutureBuilder(
            //   future: Authentication.initializeFirebase(context: context),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Error initializing Firebase');
            //     } else if (snapshot.connectionState == ConnectionState.done) {
            //       return const GoogleSignInButton();
            //     }
            //     return const CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(
            //         CustomColors.firebaseOrange,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}