import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/View/auth/auth_screen.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SetPasswordScreen extends StatefulWidget {
  final email;
  final otp;
  const SetPasswordScreen({super.key, this.email, this.otp,});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool passwordvisible = false;
  bool confirmPasswordvisible = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  bool _isLoading = false;
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    print("knwdkn${widget.email}");
    print("otppppp${widget.otp}");

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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKeyPassword,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 8) {
                            return "password length should atleast 8";
                          }
                          return null; // Validation passed
                        },
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
                            contentPadding: const EdgeInsets.only(left: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.appColor)),
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: AppTheme.appColor,
                            )),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.appColor)),
                            hintText: "Enter new password",
                            hintStyle: TextStyle(color: AppTheme.appColor)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKeyConfirmPassword,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your confirm Password';
                          } else if (value.length < 8) {
                            return "password length should atleast 8";
                          } else if (_passwordController.text != value) {
                            return "password does not match";
                          }
                          return null; // Validation passed
                        },
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
                            contentPadding: const EdgeInsets.only(left: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.appColor)),
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: AppTheme.appColor,
                            )),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.appColor)),
                            hintText: "Confirm password",
                            hintStyle: TextStyle(color: AppTheme.appColor)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.appColor,
                          ),
                        )
                      : AppButton.appButton("Confirm", onTap: () {
                          if (_formKeyPassword.currentState!.validate() &&
                              _formKeyConfirmPassword.currentState!
                                  .validate()) {
                            resetPassword();
                          }
                        },
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

  void resetPassword() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500;
    const int responseCode503 = 503; // Internal server error.

    // Internal server error.

    Map<String, dynamic> params = {
      "email": widget.email,
      "password": _passwordController.text,
      "password_confirmation": _confirmPasswordController.text,
      "OTP": widget.otp,
    };
    try {
      response = await dio.post(path: AppUrls.resetPasswordUrl, data: params);
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
      } else if (response.statusCode == responseCode503) {
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
          setState(() {
            _isLoading = false;
          });
          pushReplacement(context, AuthScreen());
          showSnackBar(context, "${responseData["message"]}");
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }
}
