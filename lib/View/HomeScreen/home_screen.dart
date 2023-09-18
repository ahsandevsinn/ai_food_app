import 'dart:convert';
import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/search_screen.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/recipe_info/recipe_info.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/dio/spoonacular_app_dio.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final allergies;
  final dietaryRestrictions;
  final data;
  final type;
  final offset;
  final totalResults;
  final foodStyle;
  final searchType;
  var query;
  HomeScreen(
      {Key? key,
      this.data,
      this.type,
      this.allergies,
      this.dietaryRestrictions,
      this.foodStyle,
      this.offset,
      this.query,
      this.searchType,
      this.totalResults})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppDio dio;
  late SpoonAcularAppDio spoondio;

  AppLogger logger = AppLogger();
  var responseData;
  bool randomData = false;
  var errorResponse;
  int type = 0;
  bool isLoading = false;
  @override
  void initState() {
    print("type$type");
    dio = AppDio(context);
    spoondio = SpoonAcularAppDio(context);
    logger.init();
    getUserCredentials();
    setRecipesParameters();
    if (widget.type == 1) {
      type = widget.type;
    } else {
      LoadingDataFromSharedPreffromProfile();
    }

    super.initState();
  }

  void LoadingDataFromSharedPreffromProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value;
    String? value2;
    List<String> finalValue = [];
    List<String> finalValue2 = [];
    List<String>? storedData =
        prefs.getStringList(PrefKey.dataonBoardScreenAllergies);
    List<String>? storedData2 =
        prefs.getStringList(PrefKey.dataonBoardScreenDietryRestriction);
    if (storedData != null && storedData2 != null) {
      for (String entry in storedData) {
        String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
        List<String> parts = result.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          value = parts[1].trim();
          finalValue.add(value);
        }
      }
      for (String entry in storedData2) {
        String result = entry.replaceAll(RegExp(r'^MapEntry\(|\)'), '');
        List<String> parts = result.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          value2 = parts[1].trim();
          finalValue2.add(value2);
        }
      }
    }
    print("value_is ${finalValue} data ${finalValue2}");
    getSuggestedRecipes(
      allergies: finalValue,
      dietaryRestrictions: finalValue2,
    );
  }

  void getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(PrefKey.authorization);
    String? name = prefs.getString(PrefKey.userName);
    print("home_token $token");
    print("home_name $name");
  }

  @override
  void dispose() {
    widget.query = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("allergies${widget.allergies}");
    print("dietaryRestrictions${widget.dietaryRestrictions}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            if (type == 1) {
              pushReplacement(context, const SearchScreen());
            } else {
              push(context, const SearchScreen());
            }
          },
          child: Container(
            width: width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffd9c4ef),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "${widget.query ?? "Search"}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB38ADE),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: SvgPicture.asset(
                          "assets/images/Search.svg",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppTheme.appColor,
              ),
            )
          : Container(
              width: width,
              // color: Colors.blueGrey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.appText(
                                  type == 0
                                      ? "Recommended:"
                                      : "Search results:",
                                  fontSize: 20,
                                  textColor: AppTheme.appColor,
                                  fontWeight: FontWeight.w600),
                              // REGENERATE RECIPE BUTTON
                              type == 1
                                  ? InkWell(
                                      onTap: () async {
                                        if (widget.searchType == 1) {
                                          await reGenerateRecipe();
                                        } else {
                                          await reGenerateRecipeQuery();
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: AppTheme.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: AppTheme.appColor),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.autorenew,
                                                color: AppTheme.appColor,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              AppText.appText(
                                                "Regenerate result",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                textColor: AppTheme.appColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        type == 0
                            ? responseData == null
                                ? randomData == false
                                    ? Container(
                                        height: 500,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppTheme.appColor,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Container(
                                          height: 500,
                                          child: Center(
                                              child: AppText.appText(
                                                  "${errorResponse}")),
                                        ),
                                      )
                                : responseData.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Container(
                                          height: 500,
                                          child: Center(
                                              child: AppText.appText(
                                                  "No results found according to your profile")),
                                        ),
                                      )
                                    : GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              width / (2.26 * 238),
                                        ),
                                        shrinkWrap: true,
                                        itemCount: responseData.length,
                                        itemBuilder: (context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeInfo(
                                                  recipeData:
                                                      responseData[index],
                                                ),
                                              ));
                                            },
                                            child: Container(
                                              width: width / 2.26,
                                              height: 238,
                                              decoration: BoxDecoration(
                                                color: AppTheme.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 12,
                                                                bottom: 8),
                                                        child: Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  "${responseData[index]["image"]}",
                                                              height: 130,
                                                              width: width,
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: AppText.appText(
                                                          "${responseData[index]["title"]}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textColor: AppTheme
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 3,
                                                      "This is Product. This is Product. This is Product. This is Product. This is Product.",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color:
                                                            AppTheme.whiteColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                            : widget.data.length == 0
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text(
                                        "Don't find any Result",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: width / (2.26 * 238),
                                    ),
                                    shrinkWrap: true,
                                    itemCount: widget.data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          getSearchResult(
                                              "${widget.data[index]["id"]}");
                                        },
                                        child: Container(
                                          width: width / 2.26,
                                          height: 238,
                                          decoration: BoxDecoration(
                                            color: AppTheme.appColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12, bottom: 8),
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          key: ValueKey<int>(
                                                              index),
                                                          imageUrl:
                                                              "${widget.data[index]["image"]}",
                                                          height: 130,
                                                          width: width,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: AppText.appText(
                                                      "${widget.data[index]["title"]}",
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textColor:
                                                          AppTheme.whiteColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  "This is Product. This is Product. This is Product. This is Product. This is Product.",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppTheme.whiteColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                      ]),
                ),
              ),
            ),
    );
  }

  getSearchResult(id) async {
    print("kjbjfejfbjefbefljeblf");

    const apiKey = 'd9186e5f351240e094658382be62d948';
    // const apiKey = '6fee21631c5c432dba9b34b9070a2d31';

    final apiUrl =
        'https://api.spoonacular.com/recipes/$id/information?includeNutrition=&apiKey=$apiKey';

    final response = await dio.get(path: apiUrl);

    if (response.statusCode == 200) {
      print("kwbdbkwk${response.data}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RecipeInfo(
          recipeData: response.data,
        ),
      ));
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
  ////////////////////////////////////get suggested recipe////////////////////////////////////////////////////////////////////

  getSuggestedRecipes({allergies, dietaryRestrictions}) async {
    // const apiKey = '6fee21631c5c432dba9b34b9070a2d31';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    final allergiesAre =
        allergies.isNotEmpty ? "${allergies.join(',').toLowerCase()}" : "";
    final dietaryRestrictionsAre = dietaryRestrictions.isNotEmpty
        ? "${dietaryRestrictions.join(',').toLowerCase()}"
        : "";
    String apiFinalUrl;
    if (allergiesAre.isEmpty && dietaryRestrictionsAre.isNotEmpty) {
      apiFinalUrl =
          '${AppUrls.spoonacularBaseUrl}/recipes/random?number=8&tags=${dietaryRestrictionsAre}&apiKey=$apiKey';
    } else if (allergiesAre.isNotEmpty && dietaryRestrictionsAre.isEmpty) {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&tags=${allergiesAre}&apiKey=$apiKey';
    } else if (allergiesAre.isNotEmpty && dietaryRestrictionsAre.isNotEmpty) {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&tags=${allergiesAre},${dietaryRestrictionsAre}&apiKey=$apiKey';
    } else {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&apiKey=$apiKey';
    }
    try {
      var response;
      response = await spoondio.get(path: apiFinalUrl);
      if (response.statusCode == 200) {
        setState(() {
          responseData = response.data["recipes"];
        });
      } else if (response.statusCode == 402) {
        setState(() {
          randomData = true;
          errorResponse = response.data["message"];
          print("l;nkwkdn${response.data["message"]}");
        });
      } else {
        showSnackBar(context, "Something Went Wrong!");
      }
    } catch (e) {
      print(e);
    }
  }

  //get recipes data api
  void setRecipesParameters() async {
    var response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const int responseCode200 = 200; // For successful request.
    const int responseCode400 = 400; // For Bad Request.
    const int responseCode401 = 401; // For Unauthorized access.
    const int responseCode404 = 404; // For For data not found
    const int responseCode405 = 405; // Method not allowed
    const int responseCode500 = 500; // Internal server error.

    try {
      response = await dio.get(path: AppUrls.searchParameterUrl);
      var responseData = response.data;
      if (response.statusCode == responseCode405) {
        print("For For data not found.");
        // showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode404) {
        print("For For data not found.");
        // showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode400) {
        print(" Bad Request.");
        // showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        print(" Unauthorized access.");
        // showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        // showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          print("Status code is false.");
          // showSnackBar(context, "${responseData["message"]}");
        } else {
          print("responseData${responseData}");
          var encodeData = jsonEncode(responseData);
          print("encoded_data is $encodeData");
          prefs.setString(PrefKey.parametersLists, encodeData);
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      // showSnackBar(context, "Something went Wrong.");
    }
  }

//////////////////////////////
//Here is the function for regenrating recipes
  Future reGenerateRecipe() async {
    setState(() {
      isLoading = true;
    });
    final allergiesProvider =
        Provider.of<AllergiesProvider>(context, listen: false);
    final restrictionsProvider =
        Provider.of<DietaryRestrictionsProvider>(context, listen: false);
    final proteinProvider =
        Provider.of<PreferredProteinProvider>(context, listen: false);
    final delicacyProvider =
        Provider.of<RegionalDelicacyProvider>(context, listen: false);
    final kitchenProvider =
        Provider.of<KitchenResourcesProvider>(context, listen: false);
    // const apiKey = '6fee21631c5c432dba9b34b9070a2d31';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    int currentOffset = widget.offset + 8;

    final style = widget.foodStyle.isNotEmpty
        ? "&cuisine=${widget.foodStyle.toString().substring(1, widget.foodStyle.toString().length - 1)}"
        : "";
    final kitchenResources = kitchenProvider.addKitchenResources.isNotEmpty
        ? "&equipment=${kitchenProvider.addKitchenResources.toString().substring(1, kitchenProvider.addKitchenResources.toString().length - 1)}"
        : "";
    final preferredProtein = proteinProvider.addProtein.isNotEmpty
        ? "&includeIngredients=${proteinProvider.addProtein.toString().substring(1, proteinProvider.addProtein.toString().length - 1)}"
        : "";
    final allergies = allergiesProvider.addAllergies.isNotEmpty
        ? "&intolerances=${allergiesProvider.addAllergies.toString().substring(1, allergiesProvider.addAllergies.toString().length - 1)}"
        : "";
    final dietaryRestrictions = restrictionsProvider
            .addDietaryRestrictions.isNotEmpty
        ? "&diet=${restrictionsProvider.addDietaryRestrictions.toString().substring(1, restrictionsProvider.addDietaryRestrictions.toString().length - 1)}"
        : "";
    final regionalDelicacy = delicacyProvider.addRegionalDelicacy.isNotEmpty
        ? "query=${delicacyProvider.addRegionalDelicacy.toString().substring(1, delicacyProvider.addRegionalDelicacy.toString().length - 1)}"
        : "";

    // Update the offset value in the API URL
    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?$regionalDelicacy$style$kitchenResources$preferredProtein$allergies$dietaryRestrictions&number=8&offset=$currentOffset&apiKey=$apiKey';

    final response = await dio.get(path: apiUrl);

    if (response.statusCode == 200) {
      print("response_data_is  ${response.data}");

      pushReplacement(
          context,
          BottomNavView(
            type: 1,
            data: response.data["results"],
            offset: currentOffset,
            totalResults: response.data["totalResults"],
            foodStyle: widget.foodStyle,
            searchType: 1,
          ));
      setState(() {
        isLoading = false;
      });
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

  Future reGenerateRecipeQuery() async {
    setState(() {
      isLoading = true;
    });
    const apiKey = '6fee21631c5c432dba9b34b9070a2d31';

    int currentOffset = widget.offset + 8;

    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?query=${widget.query}&number=8&offset=$currentOffset&apiKey=$apiKey';

    final response = await dio.get(path: apiUrl);

    if (response.statusCode == 200) {
      print("response_data_is  ${response.data}");

      pushReplacement(
          context,
          BottomNavView(
            type: 1,
            data: response.data["results"],
            offset: currentOffset,
            totalResults: response.data["totalResults"],
            query: widget.query,
            searchType: 0,
          ));
      setState(() {
        isLoading = false;
      });
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
