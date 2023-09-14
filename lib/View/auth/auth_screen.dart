import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/auth/forgot_password_screen.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late AppDio dio;
  AppLogger logger = AppLogger();

  bool _isLoading = false;
  bool _appleLoading = false;

  //final _formKey = GlobalKey<FormState>();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyLoginEmail = GlobalKey<FormState>();
  final _formKeyLoginPassword = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
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
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

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
                const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      child: SizedBox(
                                        width: 90,
                                        child: AppText.appText("Sign in",
                                            textColor: login == true
                                                ? AppTheme.appColor
                                                : const Color(0xffBFBFBF),
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
                                          _nameController.text = '';
                                          _emailController.text = '';
                                          _passwordController.text = '';
                                          _confirmPasswordController.text = '';
                                        });
                                      },
                                      child: SizedBox(
                                        width: 95,
                                        child: AppText.appText("Sign up",
                                            textColor: login == false
                                                ? AppTheme.appColor
                                                // : Colors.black.withOpacity(0.25),
                                                : const Color(0xffBFBFBF),
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
                                            final isEmailValid = RegExp(
                                                    r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]')
                                                .hasMatch(value);
                                            final isMobileValid = RegExp(
                                                    r'^\+(?:[0-9] ?){6,14}[0-9]$')
                                                .hasMatch(value);
                                            if (value.isEmpty ||
                                                value == null) {
                                              return "Please enter your email";
                                            }
                                            if (!isEmailValid &&
                                                !isMobileValid) {
                                              return "Please enter a valid email";
                                            }
                                            return null;
                                          },
                                          texthint: "Email",
                                          hintStyle: TextStyle(
                                              color: AppTheme.appColor),
                                          controller: _loginEmailController),
                                    ),
                                    Form(
                                      key: _formKeyLoginPassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: CustomAppPasswordfield(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Field cannot be empty";
                                          } else if (value.length < 8) {
                                            return "password length should atleast 8";
                                          }
                                          return null;
                                        },
                                        texthint: "Password",
                                        controller: _loginPasswordController,
                                      ),
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
                                              "Forgot password?",
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null; // Validation passed
                                          },
                                          height: 50,
                                          texthint: "Enter full name",
                                          hintStyle: TextStyle(
                                              color: AppTheme.appColor),
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
                                            return 'Invalid Email';
                                          }
                                          return null;
                                        },
                                        // height: 50,
                                        texthint: "Enter email",
                                        hintStyle:
                                            TextStyle(color: AppTheme.appColor),
                                        controller: _emailController,
                                      ),
                                    ),
                                    Form(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      key: _formKeyPassword,
                                      child: CustomAppPasswordfield(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          } else if (value.length < 8) {
                                            return "password length should atleast 8";
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
                                          } else if (value.length < 8) {
                                            return "password length should atleast 8";
                                          } else if (_passwordController.text !=
                                              value) {
                                            return "password does not match";
                                          }
                                          return null; // Validation passed
                                        },
                                        texthint: "Confirm password",
                                        controller: _confirmPasswordController,
                                      ),
                                    ),
                                  ],
                                ),
                          _isLoading
                              ? CircularProgressIndicator(
                                  color: AppTheme.appColor,
                                )
                              : AppButton.appButton(onTap: () {
                                  if (login == true) {
                                    if (_formKeyLoginEmail.currentState!
                                            .validate() &&
                                        _formKeyLoginPassword.currentState!
                                            .validate()) {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const UserProfileScreen(),
                                      //   ),
                                      // );
                                      Login();
                                      print("Email:${_emailController.text}");
                                      print(
                                          "Password:${_passwordController.text}");
                                    }
                                  } else {
                                    if (_formKeyName.currentState!.validate() &&
                                        _formKeyEmail.currentState!
                                            .validate() &&
                                        _formKeyPassword.currentState!
                                            .validate() &&
                                        _formKeyConfirmPassword.currentState!
                                            .validate()) {
                                      SignUp();
                                    }
                                  }
                                }, login == true ? "Sign in" : "Sign Up",
                                  blurContainer: true,
                                  backgroundColor: AppTheme.appColor,
                                  textColor: Colors.white,
                                  width: 44.w,
                                  height: 40,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)
                        ]),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Platform.isIOS
                          ? _appleLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.appColor,
                                  ),
                                )
                              : Center(
                                  child: AppButton.appButtonWithLeadingIcon(
                                    "Continue with Apple",
                                    onTap: () async {
                                      await handleAppleSignIn();
                                    },
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppTheme.appColor,
                                    icons: Icons.apple,
                                    height: 48,
                                  ),
                                )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 6,
                      ),
                      const GoogleSignInButton(),
                    ],
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
                            fontWeight: FontWeight.w400),
                        AppText.appText(login == true ? "Sign up" : "Sign in",
                            textColor: AppTheme.appColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            underLine: true),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleAppleSignIn() async {
    setState(() {
      _appleLoading = true;
    });
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

      if (kDebugMode) {
        print(result.user!.displayName.toString());
      }
      String userId = result.user!.uid.toString();
      String naming = result.user!.displayName.toString();
      String displayName =
          "${appleCredential.givenName} ${appleCredential.familyName}";
      bool newUser = result.additionalUserInfo!.isNewUser;
      print(result.user!.email.toString());
      print(result.user!.uid.toString());
      print(result.additionalUserInfo!.username.toString());
      print(
          "apple_user_data id $userId email ${result.user!.email.toString()} username $displayName");
      print(
          "apple_user_data fullname ${appleCredential.givenName} ${appleCredential.familyName} newUser $newUser");

      // Check if the user is new or returning
      // if (result.additionalUserInfo != null && result.additionalUserInfo!.isNewUser) {
      //   // New user
      //   print("New user signed in with Apple.");
      // } else {
      //   // Returning user
      //   print("Returning user signed in with Apple.");
      // }

      appleLogin(userId: userId, name: displayName, isNewUser: newUser);
      setState(() {
        _appleLoading = true;
      });
    } catch (e, stackTrace) {
      // Handle exceptions here
      print("Error during Apple Sign-In: $e");
      print("Stack trace: $stackTrace");
      setState(() {
        _appleLoading = false;
      });
    }
  }

  void SignUp() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode500 = 500; // Internal server error.
    Map<String, dynamic> params = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "password_confirmation": _confirmPasswordController.text,
    };
    try {
      response = await dio.post(path: AppUrls.signUpUrl, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        print("Bad Request.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        print("Unauthorized access.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        print(
            "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, "${responseData["message"]}");
          return;
        } else {
          print("responseData${responseData}");
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });
          var token = responseData['data']['token'];
          var name = responseData['data']['user']['name'];
          print("username_is $name");
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString(PrefKey.authorization, token ?? '');
          prefs.setString(PrefKey.name, name ?? '');
          pushReplacement(context, const UserProfileScreen());
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  //simple sign in
  void Login() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    List<String> dietaryRestrictionsList = [];
    List<String> allergiesList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500; // Internal server error.

    Map<String, dynamic> params = {
      "email": _loginEmailController.text,
      "password": _loginPasswordController.text,
    };
    try {
      response = await dio.post(path: AppUrls.loginUrl, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode404) {
        print("For For data not found.");
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode400) {
        print(" Bad Request.");
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        print(" Unauthorized access.");
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, "${responseData["message"]}");
          return;
        } else {
          print("responseData${responseData}");
          showSnackBar(context, "${responseData["message"]}");
          setState(() {
            _isLoading = false;
          });
          var token = responseData['data']['token'];
          var name = responseData['data']['user']['name'];
          var dietary_restrictions =
              responseData['data']['user']['dietary_restrictions'];
          var allergies = responseData['data']['user']['allergies'];
          for (var data0 in dietary_restrictions) {
            dietaryRestrictionsList.add('${data0['id']}:${data0['name']}');
          }
          for (var data0 in allergies) {
            allergiesList.add('${data0['id']}:${data0['name']}');
          }
          prefs.setStringList(
              PrefKey.dataonBoardScreenAllergies, allergiesList);
          prefs.setStringList(PrefKey.dataonBoardScreenDietryRestriction,
              dietaryRestrictionsList);

          prefs.setString(PrefKey.authorization, token ?? '');
          prefs.setString(PrefKey.name, name ?? '');
          pushReplacement(context, BottomNavView());
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }

  //apple sign in
  void appleLogin(
      {required String userId,
      required bool isNewUser,
      required String name}) async {
    setState(() {
      _appleLoading = true;
    });
    var response;
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found.
    const int responseCode500 = 500; // Internal server error.

    Map<String, dynamic> params = {
      "apple": userId,
    };
    try {
      response = await dio.post(path: AppUrls.loginUrl, data: params);
      var responseData = response.data;
      if (response.statusCode == responseCode404) {
        print("For For data not found.");
        setState(() {
          _appleLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode400) {
        print(" Bad Request.");
        setState(() {
          _appleLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        print(" Unauthorized access.");
        setState(() {
          _appleLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        setState(() {
          _appleLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          setState(() {
            _appleLoading = false;
          });
          showSnackBar(context, "${responseData["message"]}");
          return;
        } else {
          if (isNewUser) {
            pushReplacement(context, const UserProfileScreen());
          } else {
            pushReplacement(context, BottomNavView());
          }
          print("responseData${responseData}");
          setState(() {
            _appleLoading = false;
          });
          var token = responseData['data']['token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString(PrefKey.authorization, token ?? '');
          prefs.setString(PrefKey.name, name ?? '');
          showSnackBar(context, "${responseData["message"]}");
        }
      }
    } catch (e) {
      setState(() {
        _appleLoading = false;
      });
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }

  alertDialogError(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.whiteColor,
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Center(
                child: Image.asset(
              "assets/images/done.gif",
              height: 120,
            )),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: AppText.appText(
                "User Created Successfully",
                fontSize: 24,
                textColor: AppTheme.appColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton.appButton("Okay",
                onTap: () => Navigator.of(context).pop(),
                height: 30,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                textColor: AppTheme.appColor,
                backgroundColor: AppTheme.whiteColor,
                border: false)
          ],
        );
      },
    );
  }
}
