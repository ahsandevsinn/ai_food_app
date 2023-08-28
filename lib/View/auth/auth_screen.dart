import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/View/auth/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'GoogleSignIn/google_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

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
    print("object$_autoValidateMode");
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
                                  CustomAppFormField(
                                      texthint: "Email or Mobile number",
                                      controller: _loginEmailController),
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
                            : Form(
                                key: _formKey,
                                autovalidateMode: _autoValidateMode,
                                child: Column(
                                  children: [
                                    CustomAppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your mobile number';
                                          }
                                          return null; // Validation passed
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _autoValidateMode =
                                                AutovalidateMode.disabled;
                                          });
                                        },
                                        height: 50,
                                        texthint: "Enter full name",
                                        controller: _nameController),
                                    CustomAppFormField(
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
                                      onChanged: (value) {
                                        setState(() {
                                          _autoValidateMode =
                                              AutovalidateMode.disabled;
                                        });
                                      },
                                      height: 50,
                                      texthint: "Enter email",
                                      controller: _emailController,
                                    ),
                                    CustomAppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your mobile number';
                                          }
                                          return null; // Validation passed
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _autoValidateMode =
                                                AutovalidateMode.disabled;
                                          });
                                        },
                                        texthint: "Enter mobile number",
                                        controller: _phoneController),
                                    CustomAppPasswordfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your mobile number';
                                        }
                                        return null; // Validation passed
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _autoValidateMode =
                                              AutovalidateMode.disabled;
                                        });
                                      },
                                      texthint: "Enter password",
                                      controller: _passwordController,
                                    ),
                                    CustomAppPasswordfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your mobile number';
                                        }
                                        return null; // Validation passed
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _autoValidateMode =
                                              AutovalidateMode.disabled;
                                        });
                                      },
                                      texthint: "Confirm password",
                                      controller: _confirmPasswordController,
                                    ),
                                  ],
                                ),
                              ),
                        login == true
                            ? AppButton.appButton("Sign In",
                                backgroundColor: AppTheme.appColor,
                                textColor: Colors.white,
                                width: 44.w,
                                height: 40,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)
                            : AppButton.appButton("Sign Up", onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, proceed with sign-up logic
                                  // ...
                                }
                              },
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
                      GestureDetector(
                        onTap: () {
                          handleAppleSignIn();

                          // final credential = await SignInWithApple.getAppleIDCredential(
                          //   scopes: [
                          //     AppleIDAuthorizationScopes.email,
                          //     AppleIDAuthorizationScopes.fullName,
                          //   ],
                          // );

                          // print("getting_credentials email: ${credential.email},givenName: ${credential.givenName},userIdentifier: ${credential.userIdentifier}");
                          // print("getting_credentials identityToken: ${credential.identityToken}");
                        },
                        child: Center(
                          child: AppButton.appButtonWithLeadingIcon(
                              "Continue with Apple",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              textColor: AppTheme.appColor,
                              icons: Icons.apple,
                              height: 48,
                              width: 79.w),
                        ),
                      ),

                      // const SizedBox(height: 10),
                      // GestureDetector(
                      //   onTap: () async {
                      //     // Sign the user out
                      //     // SignInWithApple;
                      //     //OR
                      //     await SignInWithApple.getAppleIDCredential(
                      //       scopes: [],
                      //     );
                      //
                      //     await FirebaseAuth.instance.signOut();
                      //
                      //     // You can optionally clear the user's session on your backend server as well.
                      //
                      //     // Add any additional logic you need after signing the user out.
                      //
                      //     print("User signed out from Apple Sign-In");
                      //   },
                      //   child: Center(
                      //     child: AppButton.appButtonWithLeadingIcon(
                      //       "Sign Out from Apple",
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w400,
                      //       textColor: AppTheme.appColor,
                      //       icons: Icons.apple,
                      //       height: 48,
                      //       width: 79.w,
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 6,
                      ),
                      FutureBuilder(
                        future: Authentication.initializeFirebase(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Error initializing Firebase');
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const GoogleSignInButton();
                          }
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                                  AppText.appText("Don't have an Account? ",
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
                                  AppText.appText("Already have an Account? ",
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
      ),
    );
  }

  // Function to handle Apple Sign-In and Firebase sign-in
  Future<void> handleAppleSignIn() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final result = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      // You can add code here to handle a successful sign-in.
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


//signout code for apple firebase signout
//await FirebaseAuth.instance.signOut();