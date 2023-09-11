import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_field.dart';
import 'package:flutter/material.dart';

import '../../../View/auth/forgot_password_screen.dart';

showCustomAlert(BuildContext context, {controller}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: SingleChildScrollView(
          child: Container(
            // width: 100,
            // height: 500,
            decoration: BoxDecoration(
              color: const Color(0xFFB38ADE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    // color: Color(0xFFB38ADE),
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(
                    //       8.0,
                    //     ),
                    //     topRight: Radius.circular(8.0)),
                  ),
                  height: 56,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                        color: AppTheme.appColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  // height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          style: TextStyle(color: AppTheme.whiteColor),
                          cursorColor: AppTheme.whiteColor,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: AppTheme.whiteColor),
                              hintText: "jessica hanson",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.whiteColor)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.whiteColor))),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(color: AppTheme.whiteColor),
                        cursorColor: AppTheme.whiteColor,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: AppTheme.whiteColor),
                            hintText: "jessicahanson@gmail.com",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.whiteColor)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.whiteColor))),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLines: 3,
                    style: TextStyle(color: AppTheme.whiteColor),
                    cursorColor: AppTheme.whiteColor,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: AppTheme.whiteColor),
                        hintText: "Your message",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppTheme.whiteColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: AppTheme.whiteColor))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: AppButton.appButton("Send message ",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      textColor: AppTheme.appColor,
                      height: 50,
                      width: 180,
                      backgroundColor: AppTheme.whiteColor, onTap: () {
                    push(context, ForgotPasswordScreen());
                    // push(context, const ForgotPasswordPage());
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
