import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/recipe_info/shopping_list.dart';
import 'package:ai_food/config/keys/pref_keys.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeInfo extends StatefulWidget {
  final recipeData;

  const RecipeInfo({super.key, this.recipeData});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var unit;
  final List<Widget> _tabs = [
    AppText.appText("Preparation",
        // textColor: AppTheme.appColor,
        fontSize: 16,
        fontWeight: FontWeight.w700),
    AppText.appText("Ingredients",
        // textColor: AppTheme.appColor,
        fontSize: 16,
        fontWeight: FontWeight.w700),
    AppText.appText("Links",
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
    super.initState();
    getUnit();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var ingredient = widget.recipeData["extendedIngredients"];
    print("njefbkjbfjk${ingredient.length}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 10,
              top: 10,
            ),
            child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios,
                      size: 20, color: AppTheme.whiteColor),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 55.w,
                        child: AppText.appText("${widget.recipeData["title"]}",
                            textColor: AppTheme.appColor,
                            fontSize: 6.w,
                            maxlines: 2,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShoppingList(
                                        image: widget.recipeData["image"],
                                        name: widget.recipeData["title"],
                                        ingredient: widget
                                            .recipeData["extendedIngredients"],
                                      )));
                            },
                            child: Hero(
                              tag: "hero-shopping",
                              transitionOnUserGestures: true,
                              child: Card(
                                elevation: 6,
                                shadowColor: AppTheme.appColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: AppTheme.appColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Image.asset(
                                        "assets/images/shop_bag.png")),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: Card(
                              elevation: 6,
                              shadowColor: AppTheme.appColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: AppTheme.appColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Image.asset("assets/images/fav.png")),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 400,
              width: screenWidth,
              child: Stack(children: [
                Positioned(
                  top: 60,
                  child: Container(
                    height: 300,
                    width: 55.w,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.appColor.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 0.5,
                            offset: const Offset(-5, 8),
                          ),
                        ],
                        color: AppTheme.appColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 60,
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.black.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: 250,
                      width: 70.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: const Offset(8,
                                8), // This controls the vertical offset (bottom)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) {
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
                Positioned(
                  top: 295,
                  left: 60.w,
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/clock.png",
                              height: 15,
                              width: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AppText.appText("25-30 min",
                                textColor: AppTheme.appColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/person.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AppText.appText("2-3 Persons",
                                textColor: AppTheme.appColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 600,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: AppTheme.appColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3,
                    labelColor: AppTheme.appColor,
                    unselectedLabelColor: const Color(0xffd9c4ef),
                    tabs: _tabs,
                    labelPadding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                    controller: _tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget
                                  .recipeData["analyzedInstructions"].isEmpty
                              ? widget.recipeData["analyzedInstructions"].length
                              : widget
                                  .recipeData["analyzedInstructions"][0]
                                      ["steps"]
                                  .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                                                fontSize: 14,
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
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ingredient.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                                                  width: screenWidth * 0.65,
                                                  child: Text(
                                                    "${ingredient[index]["originalName"]}",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color:
                                                            AppTheme.appColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      unit == "Metric"
                                                          ? "${ingredient[index]["measures"]["metric"]["amount"]}"
                                                          : "${ingredient[index]["measures"]["us"]["amount"]}",
                                                      textAlign:
                                                          TextAlign.justify,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          color:
                                                              AppTheme.appColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                          color:
                                                              AppTheme.appColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () async {
                                final youtubeUrl =
                                    "${widget.recipeData["spoonacularSourceUrl"]}";

                                if (await canLaunch(youtubeUrl)) {
                                  await launch(youtubeUrl);
                                } else {
                                  throw 'Could not launch $youtubeUrl';
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "${widget.recipeData["spoonacularSourceUrl"]}",
                                  style: TextStyle(color: AppTheme.appColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
