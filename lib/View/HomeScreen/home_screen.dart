import 'dart:convert';
import 'package:ai_food/Constants/apikey.dart';
import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/logout.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/errordialogue.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
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
import 'package:ai_food/providers/home_screen_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final allergies;
  final urlString;
  final dietaryRestrictions;
  final data;
  final type;
  final offset;
  final totalResults;
  final foodStyle;
  final searchType;
  var query;
  final searchList;
  HomeScreen(
      {Key? key,
      this.searchList,
      this.data,
      this.type,
      this.allergies,
      this.dietaryRestrictions,
      this.foodStyle,
      this.offset,
      this.query,
      this.searchType,
      this.totalResults, this.urlString})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppDio dio;
  late SpoonAcularAppDio spoonDio;

  AppLogger logger = AppLogger();
  var responseData;
  bool randomData = false;
  var errorResponse;
  int type = 0;
  bool isLoading = false;
  bool isHiting = false;
  bool recipeInfoLoader = false;
  bool regenerateResultLoader = false;
  List showProgressindicators = [];
  List apiRecipeIds = [];

  @override
  void initState() {
    dio = AppDio(context);
    spoonDio = SpoonAcularAppDio(context);
    logger.init();
    getFavouriteRecipes();
    storeValuetoAPI(data: widget.data);
    if (widget.type == 1) {
      type = widget.type;
      showProgressindicators = widget.searchList;
    } else {
      // LoadingDataFromSharedPreffromProfile();
    }
    super.initState();
  }


  void getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(PrefKey.authorization);
    String? name = prefs.getString(PrefKey.userName);
  }

  @override
  void dispose() {
    widget.query = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 120,
        leadingWidth: double.infinity,
        leading: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  // bottom: 19,
                  top: 20,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BottomNavView(),));
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: AppText.appText(
                        type == 0 ? "Recommended:" : "Generated results:",
                        fontSize: 20,
                        textColor: AppTheme.appColor,
                        fontWeight: FontWeight.w600),
                  ),
                  // REGENERATE RECIPE BUTTON
                  regenerateResultLoader == false ? InkWell(
                    onTap: () {
                      setState(() {
                        regenerateResultLoader = true;
                      });
                      if(type == 1 && widget.searchType == 1) {
                        reGenerateRecipe(context);
                      } else if (type == 1 && widget.searchType == 0){
                        reGenerateRecipeQuery(context);
                      }
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppTheme.appColor),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10),
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
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: AppTheme.appColor,
        ),
      )
          : Container(
        height: double.infinity,
        // color: Colors.red,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                scale: 0.5,
                opacity: 0.25)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  type == 0
                      ? responseData == null
                      ? randomData == false
                      ? Container(
                    height: 500,
                    width:
                    MediaQuery
                        .of(context)
                        .size
                        .width,
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
                              "No results found. Please try adjusting your profile parameters.")),
                    ),
                  )
                      : gridView(data: responseData)
                      : widget.data.length == 0
                      ? Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.6,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Center(
                      child: Text(
                        widget.searchType == 1
                            ? "No results found. Please try adjusting your search parameters."
                            : "No results found.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      : gridView(data: widget.data)
                ]),
          ),
        ),
      ),
    );
  }

  getSearchResult({id, index}) async {
    var response;
    print("kjbjfejfbjefbefljeblf$id");
    setState(() {
      isHiting = true;
      showProgressindicators[index] = true;
    });
    final apiUrl =
        'https://api.spoonacular.com/recipes/$id/information?includeNutrition=&apiKey=$apiKey';
    final apiUrl2 =
        'https://api.spoonacular.com/recipes/$id/information?includeNutrition=&apiKey=$apiKey2';
    response = await spoonDio.get(path: apiUrl);
    if (response.statusCode == 200) {
      setState(() {
        isHiting = false;
        showProgressindicators[index] = false;
        final idAsInt = int.tryParse(id.toString());
        final bool isFav = apiRecipeIds!.contains(idAsInt);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RecipeInfo(
                  recipeData: response.data,
                  isFav: isFav ? 1 : 0,
                ),
          ),
        ).then((value) {
          if (value == true) {
            setState(() {
              getFavouriteRecipes();
            });
          }
        }
        );
      });
    } else if (response.statusCode == 402) {
      response = await spoonDio.get(path: apiUrl2);
      if (response.statusCode == 402) {
        print('API request failed with status code: ${response.statusCode}');
      } else {
        setState(() {
          isHiting = false;
          showProgressindicators[index] = false;
          final idAsInt = int.tryParse(id.toString());
          final bool isFav = apiRecipeIds!.contains(idAsInt);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  RecipeInfo(
                    recipeData: response.data,
                    isFav: isFav ? 1 : 0,
                  ),
            ),
          ).then((value) {
            if (value == true) {
              setState(() {
                getFavouriteRecipes();
              });
            }
          });
        });
      }
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  Future reGenerateRecipe(context) async {
    var response;
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

    int currentOffset = widget.offset + 8;

    final style =
    widget.foodStyle.isNotEmpty ? "&cuisine=${widget.foodStyle}" : "";
    final kitchenResources = kitchenProvider.addKitchenResources.isNotEmpty
        ? "&equipment=${kitchenProvider.addKitchenResources.toString()
        .substring(1, kitchenProvider.addKitchenResources
        .toString()
        .length - 1)}"
        : "";
    final preferredProtein = proteinProvider.addProtein.isNotEmpty
        ? "&includeIngredients=${proteinProvider.addProtein.toString()
        .substring(1, proteinProvider.addProtein
        .toString()
        .length - 1)}"
        : "";
    final allergies = allergiesProvider.addAllergies.isNotEmpty
        ? "&intolerances=${allergiesProvider.addAllergies.toString().substring(
        1, allergiesProvider.addAllergies
        .toString()
        .length - 1)}"
        : "";
    final dietaryRestrictions = restrictionsProvider
        .addDietaryRestrictions.isNotEmpty
        ? "&diet=${restrictionsProvider.addDietaryRestrictions.toString()
        .substring(1, restrictionsProvider.addDietaryRestrictions
        .toString()
        .length - 1)}"
        : "";
    final regionalDelicacy = delicacyProvider.addRegionalDelicacy.isNotEmpty
        ? "query=${delicacyProvider.addRegionalDelicacy.toString().substring(
        1, delicacyProvider.addRegionalDelicacy
        .toString()
        .length - 1)}"
        : "";

    // Update the offset value in the API URL
    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?$regionalDelicacy$style$kitchenResources$preferredProtein$allergies$dietaryRestrictions&number=8&offset=$currentOffset&apiKey=$apiKey';
    final apiUrl2 =
        'https://api.spoonacular.com/recipes/complexSearch?$regionalDelicacy$style$kitchenResources$preferredProtein$allergies$dietaryRestrictions&number=8&offset=$currentOffset&apiKey=$apiKey2';
    response = await spoonDio.get(path: apiUrl);

    if (response.statusCode == 200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BottomNavView(
          urlString: apiUrl.split("&apiKey=$apiKey").toString().substring(1,apiUrl.split("&apiKey=$apiKey").toString().length - 3),
          type: 1,
          data: response.data["results"],
          offset: currentOffset,
          totalResults: response.data["totalResults"],
          foodStyle: widget.foodStyle,
          searchList:
          List.generate(response.data["results"].length, (index) => false),
          searchType: 1,
        );
      }));
      setState(() {
        isLoading = false;
      });
    } else {
      if (response.statusCode == 402) {
        response = await spoonDio.get(path: apiUrl2);
        if (response.statusCode == 402) {
          setState(() {
            isLoading = false;
            regenerateResultLoader = false;
          });
          print('API request failed with status code: ${response.statusCode}');
          showSnackBar(context, "${response.statusMessage}");
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return BottomNavView(
                  urlString: apiUrl2.split("&apiKey=$apiKey2").toString().substring(1,apiUrl2.split("&apiKey=$apiKey2").toString().length - 3),
                  type: 1,
                  data: response.data["results"],
                  offset: currentOffset,
                  totalResults: response.data["totalResults"],
                  foodStyle: widget.foodStyle,
                  searchList: List.generate(
                      response.data["results"].length, (index) => false),
                  searchType: 1,
                );
              }));
          setState(() {
            isLoading = false;
          });
        }
        // showSnackBar(context, "${response.statusMessage}");
      } else {
        setState(() {
          isLoading = false;
        });
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }

  Future reGenerateRecipeQuery(context) async {
    setState(() {
      isLoading = true;
    });

    int currentOffset = widget.offset + 8;

    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?query=${widget.query}&number=8&offset=$currentOffset&apiKey=$apiKey';

    final apiUrl2 =
        'https://api.spoonacular.com/recipes/complexSearch?query=${widget.query}&number=8&offset=$currentOffset&apiKey=$apiKey2';

    final response = await dio.get(path: apiUrl);

    if (response.statusCode == 200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BottomNavView(
          type: 1,
          data: response.data["results"],
          offset: currentOffset,
          totalResults: response.data["totalResults"],
          query: widget.query,
          searchType: 0,
          searchList:
              List.generate(response.data["results"].length, (index) => false),
        );
      }));
      setState(() {
        isLoading = false;
      });
    } else {
      if (response.statusCode == 402) {
        try{
          var responseApi2 = await spoonDio.get(path: apiUrl2);
          if (responseApi2.statusCode == 200) {
            setState(() {
              isLoading = false;
            });
            pushReplacement(
              context,
              BottomNavView(
                urlString: apiUrl2
                    .split("&apiKey=$apiKey2")
                    .toString()
                    .substring(
                    1,
                    apiUrl2.split("&apiKey=$apiKey2").toString().length -
                        3),
                searchType: 0,
                type: 1,
                data: responseApi2.data["results"],
                searchList: List.generate(responseApi2.data["results"].length, (index) => false),
                query: widget.query,
                offset: responseApi2.data["offset"],
              ),
            );
            print("status_code is ${responseApi2.statusCode}");
          } else if(responseApi2.statusCode == 402){
            setState(() {
              isLoading = false;
            });
            showSnackBar(context, "${responseApi2.statusMessage}");
          }
        }catch(e){
          print("Catch eroor"+e.toString());
        }
        setState(() {
          isLoading = false;
        });
        // showSnackBar(context, "${response.statusMessage}");
      } else {
        setState(() {
          isLoading = false;
        });
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }

  void getFavouriteRecipes() async {
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
      } else if (response.statusCode == responseCode401) {
        print("Unauthorized access.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode404) {
        print(
            "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          if(responseData["data"]["statusCode"] ==  403) {
            alertDialogError(context: context, message: responseData["message"]);
            return;

          }else{
            showSnackBar(context, "${responseData["message"]}");
          }

        } else {
          setState(() {
            apiRecipeIds = responseData["data"]["recipe_ids"];
          });
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }

  Widget gridView({data}) {
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: width / (2.26 * 225),
      ),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, int index) {
        bool recipeDataId = apiRecipeIds.contains(data[index]["id"]);

        return Container(
          width: width / 2.26,
          height: 225,
          decoration: BoxDecoration(
            color: AppTheme.appColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${data[index]["image"]}",
                              height: 130,
                              width: width,
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                          !recipeDataId ? SizedBox.shrink() : Padding(
                            padding:
                            const EdgeInsets.all(
                                8.0),
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
                                    color: AppTheme.appColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: AppText.appText("${data[index]["title"]}",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      textColor: AppTheme.whiteColor,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                showProgressindicators[index] == true
                    ? Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.whiteColor,
                  ),
                )
                    : InkWell(
                  onTap: () {
                    if (isHiting == false) {
                      getSearchResult(
                          id: "${data[index]["id"]}", index: index);
                    }
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: AppTheme.whiteColor,
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.appText(
                            "See details",
                            textColor: AppTheme.appColor,
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
    );
  }

  storeValuetoAPI({data}) async {
    var response;
    int index = 1;
    Map<String, dynamic> arrangeIndexParam = {};
    int responseCode200 = 200; // For successful request.
    int responseCode400 = 400; // For Bad Request.
    int responseCode401 = 401; // For Unauthorized access.
    int responseCode404 = 404; // For For data not found
    int responseCode500 = 500; // Internal server error.
    for (var values in data) {
      String title = values["title"].toString();
      int id = values["id"];
      String image = values["image"];
      String url = "";
      arrangeIndexParam.addAll({
        "recipes[${index}][recipe_id]": id,
        "recipes[${index}][title]": title,
        "recipes[${index}][image]": image,
        "recipes[${index}][url]": url,
      });
      index++;
    }
    try {
      Map<String,dynamic> finalData = {
        "search" : "${widget.urlString}",
     ...arrangeIndexParam
      };
      response = await dio.post(path: AppUrls.searchRecipe,data: finalData);
      var responseData = response.data;
      if (response.statusCode == responseCode400) {
        print("Bad Request.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode401) {
        print("Unauthorized access.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode404) {
        print(
            "The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode500) {
        print("Internal server error.");
        showSnackBar(context, "${responseData["message"]}");
      } else if (response.statusCode == responseCode200) {
        if (responseData["status"] == false) {
          if(responseData["data"]["statusCode"] ==  403) {
            alertDialogErrorBan(context: context,message:"${responseData["message"]}");
          }else{
            alertDialogError(context: context, message: responseData["message"]);
            return;
          }

        } else {
          print("done");
        }
      }
    } catch (e) {
      print("Something went Wrong ${e}");
      showSnackBar(context, "Something went Wrong.");
    }
  }
}
