import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/View/HomeScreen/Models/recipes_parameters_model.dart';
import 'package:ai_food/config/dio/app_dio.dart';

import '../../config/app_urls.dart';

class GetRecipes {
  void getRecipesParameters(context, dio) async {
    var response;
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode405 = 405; // Method not allowed
    const int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(path: AppUrls.searchParameterUrl);
      var responseData = response.data;
      if(response.statusCode == responseCode405){
        print("For For data not found.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode404) {
        print("For For data not found.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode400) {
        print(" Bad Request.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        print(" Unauthorized access.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          showSnackBar(context, "${responseData["message"]}");
        } else {
          print("responseData${responseData}");
          showSnackBar(context, "${responseData["message"]}");
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }
}
