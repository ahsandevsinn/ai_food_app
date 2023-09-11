import 'package:ai_food/Utils/resources/res/app_assets.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/View/auth/GoogleSignIn/authentication.dart';
import 'package:ai_food/View/profile/user_profile_screen.dart';
import 'package:ai_food/providers/google_signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/widgets/others/app_button.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  // bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: googleSignInProvider.isSigningIn
          ? Center(
            child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffB38ADE)),
              ),
          )
          : Center(
              child: AppButton.appButtonWithLeadingImage(
                "Continue with Google",
                onTap: () async {
                  googleSignInProvider.setSigningIn(true);
                  // setState(() {
                  //   _isSigningIn = true;
                  // });

                  try {
                    await Authentication.initializeFirebase(context: context);
                    // User? user =
                        await Authentication.signInWithGoogle(context: context);
                    googleSignInProvider.setSigningIn(false);
                    // setState(() {
                    //   _isSigningIn = false;
                    // });
                    //
                    // if (user != null) {
                    //   Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(
                    //       builder: (context) => UserProfileScreen(
                    //           // user: user,
                    //           ),
                    //     ),
                    //   );
                    // }
                  } catch (e) {
                    googleSignInProvider.setSigningIn(false);
                    print("fbjkbfjeblfbekb$e");
                  }
                },
                fontSize: 20,
                fontWeight: FontWeight.w400,
                textColor: AppTheme.appColor,
                height: 48,
                imagePath: "assets/images/google_logo.png",
              ),
            ),
    );
  }
}