import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
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
  const SetPasswordScreen({
    super.key,
    this.email,
    this.otp,
  });

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
          padding: const EdgeInsets.only(left: 25, right: 25, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.appText("Forgot Password",
                  fontSize: 32,
                  textColor: AppTheme.appColor,
                  fontWeight: FontWeight.w600),
              AppText.appText(
                "Set new password",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textColor: AppTheme.appColor,
              ),
              const SizedBox(
                height: 60,
              ),
              Customcard(
                  childWidget: Stack(
                children: [
                  const SizedBox(
                    height: 80,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        key: _formKeyPassword,
                        child: CustomAppPasswordfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            } else if (value.length < 8) {
                              return "Password length should be at least 8 characters";
                            }
                            return null; // Validation passed
                          },
                          style: TextStyle(
                              color: AppTheme.appColor),
                          cursorColor:
                          AppTheme.appColor,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.appColor
                                  .withOpacity(0.6)),
                          texthint: "Enter new password",
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
                              return 'Enter your confirm password';
                            } else if (_passwordController.text != value) {
                              return "Password does not match";
                            }
                            return null; // Validation passed
                          },
                          style: TextStyle(
                              color: AppTheme.appColor),
                          cursorColor:
                          AppTheme.appColor,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.appColor
                                  .withOpacity(0.6)),
                          texthint: "Confirm password",
                          controller: _confirmPasswordController,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                  const SizedBox(
                    height: 170,
                  ),
                  _isLoading == true
                      ? Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                            color: AppTheme.appColor,
                          ),
                        )
                      : Align(
                    alignment: Alignment.bottomCenter,
                        child: AppButton.appButton("Confirm", onTap: () {
                            if (_formKeyPassword.currentState!.validate() &&
                                _formKeyConfirmPassword.currentState!
                                    .validate()) {
                              resetPassword();
                            }
                          },
                        width: 44.w,
                        height: 40,
                            blurContainer: true,
                            border: false,
                            backgroundColor: AppTheme.appColor,
                            textColor: AppTheme.whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      )
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
          pushReplacement(context, const AuthScreen());
          showSnackBar(context, "${responseData["message"]}");
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }
}
