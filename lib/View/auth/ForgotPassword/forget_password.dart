import 'package:ai_food/Utils/resources/res/AppAssetsImage.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/custom_button.dart';
import 'package:ai_food/View/auth/ForgotPassword/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _phoneNumberController = TextEditingController();
  bool _verificationInProgress = false;
  String? verificationIdCheck;

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    setState(() {
      _verificationInProgress = true;
    });

    verificationCompleted(AuthCredential phoneAuthCredential) {
      setState(() {
        _verificationInProgress = false;
      });

      FirebaseAuth.instance
          .signInWithCredential(phoneAuthCredential)
          .then((userCredential) {
        setState(() {
          _verificationInProgress = false;
        });
      });
    }

    verificationFailed(FirebaseAuthException authException) {
      setState(() {
        _verificationInProgress = false;
      });
      print("exception_code ${authException.code}");
      print("exception_message ${authException.message}");
      if(authException.code == 'invalid-phone-number' && authException.message!.contains('TOO_SHORT')){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Phone number is Invalid. It is TOO SHORT'),
        ));
      } else if(authException.code == 'invalid-phone-number' && authException.message!.contains('TOO_LONG')){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Phone number is Invalid. It is TOO LONG'),
        ));
      }else if (authException.code == 'missing-client-identifier'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Invalid captcha. Try again.'),
        ));
      } else if(authException.code == 'too-many-requests'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'You have been blocked due to unusual activity. Try again later.'),
        ));
      } else if (authException.code == 'quota-exceeded'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'The SMS quota for the project has been exceeded.'),
        ));
      } else if(authException.code == 'user-disabled'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'The user account has been disabled by an administrator.'),
        ));
      }  else if (authException.code == 'invalid-phone-number'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Please enter the phone number in correct format.'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '${authException.message}'),
        ));
      }
    }

    codeSent(String verificationId, [int? forceResendingToken]) async {
      setState(() {
        verificationIdCheck = verificationId;
        _verificationInProgress = false;
        print("Check_phone $phoneNumber and verification id $verificationIdCheck");
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Verification code sent to $phoneNumber'),
      ));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) =>OTPScreen(verificationId: verificationId, mobileNumber: phoneNumber)));
      // {
      //   return OtpScreen(verificationId: verificationIdCheck!, mobileNumber: phoneNumber);}));
        // return const OtpScreen();}));
    }

    codeAutoRetrievalTimeout(String verificationId) {
      setState(() {
        verificationIdCheck = verificationId;
        print("Check_phone $phoneNumber and verification id $verificationIdCheck");
      });
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 80),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (error) {
      setState(() {
        _verificationInProgress = false;
      });
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

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
                    child: GestureDetector(
                      onTap: () {
                        // pushScreen(context, SignInScreen());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: AppTheme.appColor,
                          ),
                          AppText.appText(
                            "Back",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.appColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppText.appText(
                      "Forget Password",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      textColor: AppTheme.appColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppText.appText(
                      "Enter email or number",
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
                                    texthint: "Email or Mobile number",
                                    controller: _phoneNumberController,
                                  ),
                                  sizedBox(height * 0.32, width),
                                  _verificationInProgress
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.appColor,
                                      strokeWidth: 4,
                                    ),
                                  )
                                      : CustomButton(
                                    text: "Send OTP",
                                    onTap: () {
                                      // push(context, const OtpScreen());
                                      if (!_verificationInProgress) {
                                        String phoneNumber = _phoneNumberController.text.trim();
                                        if (phoneNumber.isNotEmpty) {
                                          print("Check_phone ${phoneNumber} and verification id $verificationIdCheck");
                                          _verifyPhoneNumber(phoneNumber);
                                        }
                                      }
                                    },
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


sizedBox(double height, double width) {
  return SizedBox(
    height: height,
    width: width,
  );
}