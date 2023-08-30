import 'dart:convert';
import 'dart:math';

import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/View/auth/forgot_password_screen.dart';
import 'package:ai_food/View/auth/set_password_screen.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';
import 'package:crypto/crypto.dart';

import 'GoogleSignIn/google_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;

  //final _formKey = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyLoginEmail = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyLoginPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  //sign in with apple code
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
//ends

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.93,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.appText(login == true ? "Sign In" : "Sign Up",
                            textColor: AppTheme.appColor,
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                        AppText.appText(
                            login == true
                                ? "Sign In to Continue"
                                : "Create your Account",
                            textColor: AppTheme.appColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                  Customcard(
                      childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                    child: Container(
                                      width: 90,
                                      child: AppText.appText("Sign In",
                                          textColor: login == true
                                              ? AppTheme.appColor
                                              : AppTheme.primaryColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    )),
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
                                    child: Container(
                                      width: 95,
                                      child: AppText.appText("Sign Up",
                                          textColor: login == false
                                              ? AppTheme.appColor
                                              : AppTheme.primaryColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    )),
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
                                  Form(
                                    key: _formKeyLoginEmail,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: CustomAppFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your email or mobile number";
                                          }
                                          final isEmailValid = RegExp(
                                                  r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]')
                                              .hasMatch(value);
                                          final isMobileValid =
                                              RegExp(r'^\d{10}$')
                                                  .hasMatch(value);

                                          if (!isEmailValid && !isMobileValid) {
                                            return "Please enter a valid email or mobile number";
                                          }
                                          return null;
                                        },
                                        texthint: "Email or Mobile number",
                                        controller: _loginEmailController),
                                  ),
                                  CustomAppPasswordfield(
                                    texthint: "Enter Password",
                                    controller: _loginPasswordController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordScreen(),
                                                ));
                                          },
                                          child: AppText.appText(
                                            "Forgot Password?",
                                            textColor: AppTheme.appColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _formKeyName,
                                    child: CustomAppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null; // Validation passed
                                        },
                                        height: 50,
                                        texthint: "Enter full name",
                                        controller: _nameController),
                                  ),
                                  Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _formKeyEmail,
                                    child: CustomAppFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        final emailRegex = RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                                        if (!emailRegex.hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      height: 50,
                                      texthint: "Enter email",
                                      controller: _emailController,
                                    ),
                                  ),
                                  Form(
                                    key: _formKeyPhone,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: CustomAppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your mobile number';
                                          }
                                          final isMobileValid = RegExp(
                                                  r'^\+?\d{1,3}[-.\s]?\d{1,12}$')
                                              .hasMatch(value);

                                          if (!isMobileValid) {
                                            return "Please enter a valid email or mobile number";
                                          }
                                          return null; // Validation passed
                                        },
                                        texthint: "Enter mobile number",
                                        controller: _phoneController),
                                  ),
                                  Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _formKeyPassword,
                                    child: CustomAppPasswordfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null; // Validation passed
                                      },
                                      texthint: "Enter password",
                                      controller: _passwordController,
                                    ),
                                  ),
                                  Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _formKeyConfirmPassword,
                                    child: CustomAppPasswordfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your confirm Password';
                                        }
                                        return null; // Validation passed
                                      },
                                      texthint: "Confirm password",
                                      controller: _confirmPasswordController,
                                    ),
                                  ),
                                ],
                              ),
                        AppButton.appButton(onTap: () {
                          if (login == true) {
                            if (_formKeyLoginEmail.currentState!.validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserProfileScreen(),
                                ),
                              );
                            }
                          } else {
                            if (_formKeyName.currentState!.validate() &&
                                _formKeyEmail.currentState!.validate() &&
                                _formKeyPhone.currentState!.validate() &&
                                _formKeyPassword.currentState!.validate() &&
                                _formKeyConfirmPassword.currentState!
                                    .validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            }
                          }
                        }, login == true ? "Sign In" : "Sign Up",
                            backgroundColor: AppTheme.appColor,
                            textColor: Colors.white,
                            width: 44.w,
                            height: 40,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)
                      ])),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: AppButton.appButtonWithLeadingIcon(
                            "Continue with Apple",
                            onTap: () {},
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.appColor,
                            icons: Icons.apple,
                            height: 48,
                            width: 79.w),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const GoogleSignInButton(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (login == true) {
                            setState(() {
                              login = false;
                            });
                          } else if (login == false) {
                            setState(() {
                              login = true;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.appText(
                                login == true
                                    ? "Don't have an Account? "
                                    : "Already have an Account? ",
                                textColor: AppTheme.appColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            AppText.appText(
                                login == true ? "Sign Up" : "Sign In",
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
      ),
    );
  }

  Future<void> handleAppleSignIn() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      print(result.user!.displayName.toString());
      print(result.user!.email.toString());
      print(result.user!.uid.toString());
      print(result.additionalUserInfo!.username.toString());
    } catch (e, stackTrace) {
      // Handle exceptions here
      print("Error during Apple Sign-In: $e");
      print("Stack trace: $stackTrace");
    }
  }
}
