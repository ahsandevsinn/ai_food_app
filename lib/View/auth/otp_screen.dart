import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_card.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sizer/sizer.dart';

import 'set_password_screen.dart';

class OTPScreen extends StatefulWidget {
  final email;
  const OTPScreen({
    super.key,
    this.email,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _smsCodeController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  String otpError = '';

  late AppDio dio;
  AppLogger logger = AppLogger();
  var responseData;
  bool isLoading = false;

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    print("otp${widget.email}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.appText("Forgot Password",
                    fontSize: 32,
                    textColor: AppTheme.appColor,
                    fontWeight: FontWeight.w600),
                AppText.appText(
                  "Enter OTP to continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textColor: AppTheme.appColor,
                ),
                const SizedBox(
                  height: 60,
                ),
                Customcard(
                    padding: 0,
                    childWidget: Column(
                      children: [
                        const SizedBox(
                          height: 125,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  // color: Colors.blueGrey,
                                  width: double.infinity,
                                  child:
                                      // OtpTextField(
                                      //   handleControllers: _handleControllers,
                                      //   textStyle: TextStyle(
                                      //       fontSize: 18,
                                      //       color: AppTheme.appColor,
                                      //       fontWeight: FontWeight.bold),
                                      //   numberOfFields: 6,
                                      //   showFieldAsBox: false,
                                      //   hasCustomInputDecoration: true,
                                      //   cursorColor: AppTheme.appColor,
                                      //   decoration: InputDecoration(
                                      //     counterText: "",
                                      //     isDense: true,
                                      //     // contentPadding: const EdgeInsets.all(10),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //         borderSide:
                                      //         BorderSide(color: AppTheme.appColor)),
                                      //     disabledBorder: const UnderlineInputBorder(
                                      //         borderSide: BorderSide.none),
                                      //     focusedBorder: UnderlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color: AppTheme.appColor,
                                      //         )),
                                      //     border: UnderlineInputBorder(
                                      //         borderSide:
                                      //         BorderSide(color: AppTheme.appColor)),
                                      //   ),
                                      // ),
                                      Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      6,
                                      (index) => SizedBox(
                                        width: 40.0,
                                        child: TextFormField(
                                          controller: otpControllers[index],
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          keyboardType: TextInputType.number,
                                          maxLength: 1,
                                          focusNode: focusNodes[index],
                                          style: TextStyle(
                                            fontSize: 18,
                                              color: AppTheme.appColor,
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.appColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppTheme.appColor),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            // Handle OTP input for each field
                                            if (value.isNotEmpty) {
                                              // Move focus to the next field if not the last field
                                              if (index < 5) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        focusNodes[index + 1]);
                                              }
                                            } else {
                                              // Move focus to the previous field if not the first field
                                              if (index > 0) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        focusNodes[index - 1]);
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (otpError.isNotEmpty)
                                    Text(
                                      otpError,
                                      style: const TextStyle(
                                        color: Colors.red, // You can choose your own color
                                      ),),
                                  SizedBox(),
                                  InkWell(
                                      onTap: () {
                                        resendOTP(text: widget.email);
                                      },
                                      child: AppText.appText("Resend OTP",
                                          textColor: AppTheme.appColor,
                                          underLine: true)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 180,
                        ),
                        isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.appColor,
                                  strokeWidth: 4,
                                ),
                              )
                            : Container(
                                child: AppButton.appButton("Continue",
                                    onTap: () {
                                  if (otpControllers.every((controller) =>
                                      controller.text.isNotEmpty)) {
                                    verfyOTP();
                                  } else {
                                   setState(() {
                                     otpError = "Fields can't be empty";
                                   });
                                  }
                                },
                                    width: 44.w,
                                    height: 40,
                                    border: false,
                                    blurContainer: true,
                                    backgroundColor: AppTheme.appColor,
                                    textColor: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleControllers(List<TextEditingController?> controllers) {
    final code = controllers.map((c) => c?.text).join('');
    _smsCodeController.text = code;
  }

  void verfyOTP() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> params = {
      "email": widget.email,
      "OTP": otpControllers.map((controller) => controller.text).join(),
    };

    final response = await dio.post(path: AppUrls.verifyUrl, data: params);

    if (response.statusCode == 200) {
      print("response_data_is  ${response.data}");

      if (response.data["status"] == false) {
        setState(() {
          isLoading = false;
          otpError = "Invalid OTP";
        });
        return;
      } else {
        setState(() {
          isLoading = false;
        });
        pushReplacement(
            context,
            SetPasswordScreen(
              email: widget.email,
              otp: otpControllers.map((controller) => controller.text).join(),
            ));
      }
    } else {
      if (response.statusCode == 402) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "${response.data["message"]}");
      } else {
        setState(() {
          isLoading = false;
        });
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.data["message"]}");
      }
    }
  }

  void resendOTP({text}) async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> params = {
      "email": text,
    };

    final response =
        await dio.post(path: AppUrls.forgetPasswordUrl, data: params);

    if (response.statusCode == 200) {
      var responseData = response.data;

      if (responseData["status"] == false) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "${responseData["message"]}");
        return;
      } else {
        // print("responseData${responseData["data"]["OTP"]}");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (response.statusCode == 402) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "${response.statusMessage}");
      } else {
        setState(() {
          isLoading = false;
        });
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }
}
