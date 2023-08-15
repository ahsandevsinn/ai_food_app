import 'package:ai_food/Controller/service/api_manager.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PracticeProvider extends ChangeNotifier{
  String _userName = "Hamza";
  String get userName => _userName;
  String showPrints(String myUserName){
    _userName = myUserName;
    print("provider_print is this $userName");
    notifyListeners();
    return _userName;
  }



  bool isLoading = false;
  Map<String, dynamic> responseData = <String, dynamic>{};
  login(context, {email, password})async{
    if(email.isEmpty){
      showSnackBar(context, "Please enter email");
    } else if(password.isEmpty){
      showSnackBar(context, "Please enter password");
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        showSnackBar(context, "Please check your internet connection and try again.");
        return;
      }
      isLoading = true;
      notifyListeners();
      var res = await ApiManager.loginUser(context, email: email, password: password);
      responseData = res;
      // if(res["data"] != null){
      //   push(context, const MyHomePage(title: "Home Page"));
      // }
      isLoading = false;
      notifyListeners();
    }
  }

}