import 'package:ai_food/Constants/apikey.dart';
import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/logout.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/errordialogue.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/chat_bot_provider.dart';
import 'package:ai_food/View/recipe_info/recipe_info.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/dio/spoonacular_app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late AppDio dio;
  AppLogger logger = AppLogger();
  late SpoonAcularAppDio spoondio;
  var responseID;

  bool _isLoading = false;

  @override
  void initState() {
    dio = AppDio(context);
    spoondio = SpoonAcularAppDio(context);
    changeCondition();
    getFavouriteRecipes();
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: AppText.appText("Favourite Recipes",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textColor: AppTheme.appColor)),
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.appColor,
                ),
              )
            : responseID == null
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            scale: 0.5,
                            opacity: 0.25)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.heart,
                            size: 105,
                            color: AppTheme.appColor,
                          ),
                          const SizedBox(
                            width: 250,
                            child: Text(
                              "You don't have any Favorite recipe yet.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            scale: 0.5,
                            opacity: 0.25)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: width / (2.26 * 225),
                              ),
                              shrinkWrap: true,
                              itemCount: responseID.length,
                              itemBuilder: (context, int index) {
                                return Container(
                                  width: width / 2.26,
                                  height: 225,
                                  decoration: BoxDecoration(
                                    color: AppTheme.appColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 8),
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 130,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "${responseID[index]["image"]}",
                                                        height: 130,
                                                        width: width,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        unFavoriteAPI(
                                                            recpieid:
                                                                responseID[
                                                                        index]
                                                                    ["id"]);
                                                      },
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                .whiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: AppTheme
                                                                  .appColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: AppText.appText(
                                              "${responseID[index]["title"]}",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              textColor: AppTheme.whiteColor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(height: 14),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => RecipeInfo(
                                                recipeData: responseID[index],
                                                isFav: 1,
                                              ),
                                            )).then((value) {
                                              if (value == true) {
                                                setState(() {
                                                  getFavouriteRecipes();
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: AppTheme.whiteColor,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppText.appText(
                                                    "See details",
                                                    textColor:
                                                        AppTheme.appColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: AppTheme.appColor,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
  }

  void getFavouriteRecipes() async {
    setState(() {
      _isLoading = true;
    });
    var response;
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(path: AppUrls.getFavouriteRecipes);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        print("Bad Request.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode401) {
        print("Unauthorized access.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode404) {
        print(
            "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        showSnackBar(context, "${responseData["message"]}");
        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          if (responseData["data"]["statusCode"] == 403) {
            alertDialogErrorBan(
                context: context, message: "${responseData["message"]}");
            setState(() {
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
            alertDialogError(
                context: context, message: responseData["message"]);
            return;
          }
          setState(() {
            _isLoading = false;
          });
          alertDialogError(context: context, message: responseData["message"]);
          return;
        } else {
          // alertDialogError(context: context, message: responseData["message"]);
          var idBulk =
              "${responseData["data"]["recipe_ids"].toString().substring(1, responseData["data"]["recipe_ids"].toString().length - 1)}";
          if (idBulk.isNotEmpty) {
            getDataRecipe(ids: idBulk);
          } else {
            setState(() {
              _isLoading = false;
              responseID = null;
            });
          }
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      // showSnackBar(context, "Something went Wrong.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  getDataRecipe({ids}) async {
    String apiFinalUrl;
    String apiFinalUrl2;
    apiFinalUrl2 =
        'https://api.spoonacular.com/recipes/informationBulk?ids=$ids&apiKey=$apiKey2';
    apiFinalUrl =
        'https://api.spoonacular.com/recipes/informationBulk?ids=$ids&apiKey=$apiKey';

    try {
      var response;
      response = await spoondio.get(path: apiFinalUrl);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            responseID = response.data;
            print("jbefjbfkebfkbkfbe${responseID}");
          });
        }
      } else if (response.statusCode == 402) {
        response = await spoondio.get(path: apiFinalUrl2);
        if (response.statusCode == 402) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, "${response.statusMessage}");
        } else {
          if (mounted) {
            setState(() {
              _isLoading = false;
              responseID = response.data;
            });
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, response.statusMessage);
      }
    } catch (e) {
      print("jaklsjdklajsdkljaskldjaskldjlaksdjklajsdaskljdklajsdklj${e}");
    }
  }

  unFavoriteAPI({recpieid}) async {
    var response;
    setState(() {
      _isLoading = true;
    });

    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(
        path: AppUrls.unFavouriteURl + "/${recpieid}",
      );
      var responseData = response.data;
      switch (response.statusCode) {
        case responseCode400:
          print("Bad Request.");
          break;
        case responseCode401:
          print("Unauthorized access.");
          break;
        case responseCode404:
          print(
              "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            if (responseData["data"]["statusCode"] == 403) {
              showSnackBar(context, "${responseData["message"]}");
            } else {
              showSnackBar(context, "Something went wrong");
            }
          } else {
            print("everything is alright");
            getFavouriteRecipes();
          }
          break;
      }
    } catch (e) {
      //check if there is any other issue with the data from server

      print("Something went Wrong ${e}");
    }
  }

  void changeCondition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PrefKey.conditiontoLoad, 0);
  }
}
