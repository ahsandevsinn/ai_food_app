import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Forgot password
  Future<String> forgotPassword({
    required String sendEmail
  }) async {
    String res = 'Some error occurred';

    try {
      if (sendEmail.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: sendEmail);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}