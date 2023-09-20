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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 105),
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
                      OtpTextField(
                        handleControllers: _handleControllers,
                        textStyle:
                            TextStyle(fontSize: 18, color: AppTheme.appColor, fontWeight: FontWeight.bold),
                        numberOfFields: 6,
                        // margin: const EdgeInsets.only(left: 15, top: 15),
                        showFieldAsBox: false,
                        fieldWidth: 50,
                        hasCustomInputDecoration: true,
                        cursorColor: AppTheme.appColor,
                        decoration: InputDecoration(
                          counterText: "",
                          isDense: true,
                          // contentPadding: const EdgeInsets.all(10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                          disabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: AppTheme.appColor,
                          )),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.appColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 19.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                onTap: () {
                                  resendOTP(text: widget.email);
                                },
                                child: AppText.appText("Resend OTP",
                                    textColor: AppTheme.appColor,
                                    underLine: true))),
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
                              child: AppButton.appButton("Continue", onTap: () {
                                verfyOTP();
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
      "OTP": _smsCodeController.text
    };

    final response = await dio.post(path: AppUrls.verifyUrl, data: params);

    if (response.statusCode == 200) {
      print("response_data_is  ${response.data}");

      if (response.data["status"] == false) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "${response.data["message"]}");
        return;
      } else {
        setState(() {
          isLoading = false;
        });
        pushReplacement(
            context,
            SetPasswordScreen(
              email: widget.email,
              otp: _smsCodeController.text,
            ));
        showSnackBar(context, "${response.data["message"]}");
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
        print("responseData${responseData["data"]["OTP"]}");
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
