import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiManager {
  static loginUser(BuildContext context, {email, password}) async {
    Response? response;
    try {
      var url = AppUrls.baseUrl + AppUrls.loginUrl;
      response = await AppDio(context).post(path: url, data: {
        "info": email,
        "password": password,
      });
      var res = response.data;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res["message"]),
      ));
      return res;
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response!.data["message"]),
      ));
    }
  }
//////////// Login API //////////
}
