import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/logout.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/Utils/widgets/others/errordialogue.dart';
import 'package:ai_food/View/recipe_info/shopping_list.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:ai_food/providers/home_screen_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RecipeInfo extends StatefulWidget {
  final recipeData;
  final isFav;
  final urlLinkFromAskMaida;

  const RecipeInfo({super.key, this.recipeData, this.isFav, this.urlLinkFromAskMaida});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo>
    with SingleTickerProviderStateMixin {
  late AppDio dio;
  AppLogger logger = AppLogger();
  late TabController _tabController;
  var unit;
  bool favoriteTap = false;
  final List<Widget> _tabs = [
    AppText.appText("Preparation",
        // textColor: AppTheme.appColor,
        fontSize: 16,
        fontWeight: FontWeight.w700),
    AppText.appText("Ingredients",
        // textColor: AppTheme.appColor,
        fontSize: 16,
        fontWeight: FontWeight.w700),
  ];

  getUnit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      unit = pref.getString(PrefKey.unit);
    });
  }

  var data;

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    if (widget.isFav == 1) {
      favoriteTap = true;
    }
    getUnit();
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;


    var ingredient = widget.recipeData["extendedIngredients"];

    // print("njefbkjbfjk${favoriteTap}");

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 68,
          leadingWidth: double.infinity,
          leading: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    // bottom: 19,
                    top: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context,true);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppTheme.appColor,
                      radius: 18,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(Icons.arrow_back_ios,
                            size: 20, color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  opacity: 0.20,
                  scale: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                // color: Colors.deepPurple,
                                width: 55.w,
                                child: AppText.appText(
                                    "${widget.recipeData["title"]}",
                                    textColor: AppTheme.appColor,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    // maxlines: 2,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ShoppingList(
                                                    image: widget
                                                        .recipeData["image"],
                                                    name: widget
                                                        .recipeData["title"],
                                                    ingredient: widget.recipeData[
                                                        "extendedIngredients"],
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 6,
                                      shadowColor: AppTheme.appColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: AppTheme.appColor,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SvgPicture.asset(
                                            "assets/images/shopping_cart.svg",
                                            color: AppTheme.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  favoriteTap == false
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              favoriteTap = true;
                                            });
                                            widget.recipeData["spoonacularSourceUrl"]==null?
                                            favoriteAPI(
                                                recpieid: widget.recipeData["id"],
                                                title: widget.recipeData["title"],
                                                image: widget.recipeData["image"],
                                                link: widget.urlLinkFromAskMaida):
                                            favoriteAPI(
                                                recpieid: widget.recipeData["id"],
                                                title: widget.recipeData["title"],
                                                image: widget.recipeData["image"],
                                                link: widget.recipeData["spoonacularSourceUrl"]);
                                          },
                                          child: Card(
                                            elevation: 6,
                                            shadowColor: AppTheme.appColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.appColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10.0),
                                                  child: SvgPicture.asset(
                                                    "assets/images/Favorite Icon.svg",
                                                    color: AppTheme.whiteColor,
                                                  ),
                                                )),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              favoriteTap = false;
                                            });
                                            unFavoriteAPI(
                                                recpieid:
                                                    widget.recipeData["id"]);
                                          },
                                          child: Card(
                                            elevation: 6,
                                            shadowColor: AppTheme.appColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.appColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10.0),
                                                  child: SvgPicture.asset(
                                                    "assets/images/Fill heart icon.svg",
                                                    color: AppTheme.whiteColor,
                                                  ),
                                                )),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: 230,
                    // color: Colors.red,
                    width: screenWidth,
                    child: Stack(children: [
                      Positioned(
                        top: 60,
                        child: Container(
                          height: screenHeight * 0.18,
                          width: screenWidth * 0.30,
                          // height: 180,

                          // width: 140,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.appColor.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 0.5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              color: AppTheme.appColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                  bottomRight: Radius.circular(22))),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 80,
                        child: Hero(
                          tag: "hero-shopping",
                          transitionOnUserGestures: true,
                          child: Card(
                            elevation: 20,
                            shadowColor: Colors.black.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: screenHeight * 0.16,
                              width: screenWidth * 0.42,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    // spreadRadius: 3,
                                    blurRadius: 1,
                                    offset: const Offset(4,
                                        4), // This controls the vertical offset (bottom)
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppTheme.appColor,
                                      ),
                                    );
                                  },
                                  imageUrl: "${widget.recipeData["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.18,
                        left: screenWidth * 0.34,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/Timer Icon.svg",
                                    width: 16, height: 16),
                                const SizedBox(
                                  width: 15,
                                ),
                                AppText.appText(
                                    "${widget.recipeData["readyInMinutes"]} minutes",
                                    textColor: AppTheme.appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/Persons Icon.svg",
                                    width: 14, height: 14),
                                const SizedBox(
                                  width: 10,
                                ),
                                AppText.appText(
                                    "${widget.recipeData["servings"]} persons",
                                    textColor: AppTheme.appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 3.0, color: AppTheme.appColor),
                            insets: EdgeInsets.symmetric(horizontal: 30.0)),
                        indicatorColor: AppTheme.appColor,
                        indicatorWeight: 3,
                        labelColor: AppTheme.appColor,
                        unselectedLabelColor: AppTheme.appColor,
                        tabs: _tabs,
                        labelPadding: const EdgeInsets.only(top: 0, bottom: 8.0),
                        controller: _tabController,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget
                                      .recipeData["analyzedInstructions"].isEmpty
                                  ? widget
                                      .recipeData["analyzedInstructions"].length
                                  : widget
                                      .recipeData["analyzedInstructions"][0]
                                          ["steps"]
                                      .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 8, bottom: 8, right: 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              height: 4,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                color: AppTheme.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                widget
                                                        .recipeData[
                                                            "analyzedInstructions"]
                                                        .isEmpty
                                                    ? "steps"
                                                    : "${widget.recipeData["analyzedInstructions"][0]["steps"][index]["step"]}",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: AppTheme.appColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ingredient.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 8, bottom: 8, right: 30),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: Container(
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.appColor,
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: screenWidth * 0.55,
                                                      child: Text(
                                                        capitalize(
                                                            ingredient[index]
                                                                ["originalName"]),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            color:
                                                                AppTheme.appColor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          unit == "Metric"
                                                              ? "${ingredient[index]["measures"]["metric"]["amount"]}"
                                                              : "${ingredient[index]["measures"]["us"]["amount"]}",
                                                          textAlign:
                                                              TextAlign.justify,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .appColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          unit == "Metric"
                                                              ? "${ingredient[index]["measures"]["metric"]["unitShort"]}"
                                                              : "${ingredient[index]["measures"]["us"]["unitShort"]}",
                                                          textAlign:
                                                              TextAlign.justify,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .appColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  favoriteAPI({recpieid, title, image, link}) async {
    var response;

    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode500 = 500; // Internal server error.

    Map<String, dynamic> params = {
      "recipe_id": recpieid,
      "title": title,
      "image": image,
      "url": link,
    };
    try {
      response = await dio.post(
        path: AppUrls.favouriteURl,
        data: params,
      );
      var responseData = response.data;
      switch (response.statusCode) {
        case responseCode400:
          setState(() {
            favoriteTap = false;
          });
          print("Bad Request.");
          break;
        case responseCode401:
          setState(() {
            favoriteTap = false;
          });
          print("Unauthorized access.");
          break;
        case responseCode404:
          setState(() {
            favoriteTap = false;
          });
          print(
              "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          setState(() {
            favoriteTap = false;
          });
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            if (responseData["data"]["statusCode"] == 403) {
              alertDialogErrorBan(context: context,message:"${responseData["message"]}");
              setState(() {
                favoriteTap = false;
              });
            }else{
              setState(() {
                favoriteTap = false;
              });
              showSnackBar(context, "Something went wrong");
            }

          } else {}
          break;
        default:
          setState(() {
            favoriteTap = false;
          });
          // Handle other response codes here if needed.
          break;
      }
    } catch (e) {
      //check if there is any other issue with the data from server
      setState(() {
        favoriteTap = false;
      });
      print("Something went Wrong ${e}");
    }
  }

  unFavoriteAPI({recpieid}) async {
    var response;

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
          setState(() {
            favoriteTap = false;
          });
          print("Bad Request.");
          break;
        case responseCode401:
          setState(() {
            favoriteTap = false;
          });
          print("Unauthorized access.");
          break;
        case responseCode404:
          setState(() {
            favoriteTap = false;
          });
          print(
              "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
          break;
        case responseCode500:
          setState(() {
            favoriteTap = false;
          });
          print("Internal server error.");
          break;
        case responseCode200:
          if (responseData["status"] == false) {
            if (responseData["data"]["statusCode"] == 403) {
              alertDialogErrorBan(context: context,message:"${responseData["message"]}");
              setState(() {
                favoriteTap = false;
              });
            }else{
              setState(() {
                favoriteTap = false;
              });
              showSnackBar(context, "Something went wrong");
            }

          } else {
            print("everything is alright");
          }
          break;
        default:
          setState(() {
            favoriteTap = false;
          });
          // Handle other response codes here if needed.
          break;
      }
    } catch (e) {
      //check if there is any other issue with the data from server
      setState(() {
        favoriteTap = false;
      });
      print("Something went Wrong ${e}");
    }
  }
}
