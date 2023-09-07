import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/recipe_params_screen.dart';
import 'package:ai_food/View/HomeScreen/search_screen.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/allergies_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/dietary_restrictions_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/kitchenResources_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/preferredProtein_provider.dart';
import 'package:ai_food/View/HomeScreen/widgets/providers/regionalDelicacy_provider.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/View/recipe_info/recipe_info.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final allergies;
  final dietaryRestrictions;
  final data;
  final type;
  final offset;
  final totalResults;
  final foodStyle;
  final searchType;
  final query;
  const HomeScreen({
    Key? key,
    this.data,
    this.type,
    this.allergies,
    this.dietaryRestrictions,
    this.offset,
    this.totalResults,
    this.foodStyle,
    this.searchType,
    this.query,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppDio dio;
  AppLogger logger = AppLogger();
  var responseData;
  int type = 0;

  @override
  void initState() {
    print("bsjbdbd$type");
    dio = AppDio(context);
    logger.init();

    if (widget.type == 1) {
      type = widget.type;
    } else {
      print("bsjbdbd22222$type");

      getSuggestedRecipes(
        allergies: widget.allergies,
        dietaryRestrictions: widget.dietaryRestrictions,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("djvbwdbw3${widget.allergies}");
    print("djvbwdbw3uod${widget.dietaryRestrictions}");
    print("count_the offset ${widget.offset}");
    print("count_the totalResults ${widget.totalResults}");
    print("count_the foodStyle ${widget.foodStyle}");
    print("count_the_searchType ${widget.searchType}");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            push(context, const SearchScreen());
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
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xffb38ade),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100)),
                  ),
                  child: const Icon(Icons.search_outlined, size: 40),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: width,
        // color: Colors.blueGrey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.appText(
                            type == 0 ? "Recommended:" : "Search Result",
                            fontSize: 20,
                            textColor: AppTheme.appColor,
                            fontWeight: FontWeight.bold),
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
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppTheme.whiteColor,
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: AppTheme.appColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.autorenew,
                                          color: AppTheme.appColor,
                                        ),
                                        AppText.appText(
                                          "Regenerate",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          textColor: AppTheme.appColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  type == 0
                      ? responseData == null
                          // ? SizedBox()
                          ? Container(
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.appColor,
                                ),
                              ),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: width / (2.26 * 238),
                              ),
                              shrinkWrap: true,
                              itemCount: responseData.length,
                              itemBuilder: (context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RecipeInfo(
                                        recipeData: responseData[index],
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    width: width / 2.26,
                                    height: 238,
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
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "${responseData[index]["image"]}",
                                                    height: 130,
                                                    width: width,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: AppText.appText(
                                                "${responseData[index]["title"]}",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                textColor: AppTheme.whiteColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            textAlign: TextAlign.justify,
                                            maxLines: 3,
                                            "This is Product. This is Product. This is Product. This is Product. This is Product.",
                                            // "${responseData[index]["summary"]}",
                                            overflow: TextOverflow.ellipsis,
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
                      : widget.data.length == 0
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      "Don't find any Result",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
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
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    key: ValueKey<int>(index),
                                                    imageUrl:
                                                        "${widget.data[index]["image"]}",
                                                    height: 130,
                                                    width: width,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: AppText.appText(
                                                "${widget.data[index]["title"]}",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                textColor: AppTheme.whiteColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            textAlign: TextAlign.justify,
                                            maxLines: 3,
                                            "This is Product. This is Product. This is Product. This is Product. This is Product.",
                                            overflow: TextOverflow.ellipsis,
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

    // const apiKey = 'd9186e5f351240e094658382be62d948';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

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
  ////////////////////////////////////////////////////////////////////////////////////////////////////////

  getSuggestedRecipes({allergies, dietaryRestrictions}) async {
    // const apiKey = 'd9186e5f351240e094658382be62d948';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    final allergiesAre =
        allergies.isNotEmpty ? "${allergies.join(',').toLowerCase()}" : "";
    final dietaryRestrictionsAre = dietaryRestrictions.isNotEmpty
        ? "${dietaryRestrictions.join(',').toLowerCase()}"
        : "";
    String apiFinalUrl;
    if (allergies.isEmpty && dietaryRestrictions.isNotEmpty) {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&tags=${dietaryRestrictionsAre}&apiKey=$apiKey';
    } else if (allergies.isNotEmpty && dietaryRestrictions.isEmpty) {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&tags=${allergiesAre}&apiKey=$apiKey';
    } else if (allergies.isNotEmpty && dietaryRestrictions.isNotEmpty) {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&tags=${allergiesAre},${dietaryRestrictionsAre}&apiKey=$apiKey';
    } else {
      apiFinalUrl =
          'https://api.spoonacular.com/recipes/random?number=8&apiKey=$apiKey';
    }
    try {
      var response;
      response = await dio.get(path: apiFinalUrl);
      if (response.statusCode == 200) {
        setState(() {
          responseData = response.data["recipes"];
        });
      } else {
        showSnackBar(context, "Something Went Wrong!");
      }
    } catch (e) {
      print(e);
    }
  }

  //Here is the function for regenrating recipes
  Future reGenerateRecipe() async {
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
    // const apiKey = 'd9186e5f351240e094658382be62d948';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    // Keep track of the current offset value
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

      // Calculate the new offset for the next page
      // final newOffset = currentOffset + 8;
      // print("new_offset ${newOffset}");

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
    } else {
      if (response.statusCode == 402) {
        showSnackBar(context, "${response.statusMessage}");
      } else {
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }

  Future reGenerateRecipeQuery() async {
    // const apiKey = 'd9186e5f351240e094658382be62d948';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    // Keep track of the current offset value
    int currentOffset = widget.offset + 8;

    // Update the offset value in the API URL
    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?query=${widget.query}&number=8&offset=$currentOffset&apiKey=$apiKey';

    final response = await dio.get(path: apiUrl);

    if (response.statusCode == 200) {
      print("response_data_is  ${response.data}");

      // Calculate the new offset for the next page
      // final newOffset = currentOffset + 8;
      // print("new_offset ${newOffset}");

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
    } else {
      if (response.statusCode == 402) {
        showSnackBar(context, "${response.statusMessage}");
      } else {
        print('API request failed with status code: ${response.statusCode}');
        showSnackBar(context, "${response.statusMessage}");
      }
    }
  }
}
