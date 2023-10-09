import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShoppingList extends StatefulWidget {
  final ingredient;
  final String image;
  final name;
  const ShoppingList(
      {super.key, required this.image, this.ingredient, this.name});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  bool offer = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            child: Hero(
              tag: "hero-shopping",
              transitionOnUserGestures: true,
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
        title: AppText.appText(
          "Shopping list",
          textColor: AppTheme.appColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 340,
                  child: Stack(
                    children: [
                      Container(
                        height: 240,
                        width: screenWidth,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.appColor,
                              ),
                            );
                          },
                          imageUrl: widget.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Padding(
                            padding: EdgeInsets.only(bottom: 60.0),
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        child: Container(
                          height: 240,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: AppTheme.appColor, width: 2),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(70)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 25, right: 40),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: screenWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.appText(
                                          "${widget.name} ingredients:",
                                          textColor: AppTheme.appColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppText.appText(
                                          "Gather these components for culinary excellence",
                                          textColor: AppTheme.appColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            offerColumn()
          ],
        ),
      ),
    );
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  offerColumn() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/logo.png"),
              scale: 0.5,
              opacity: 0.25)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.ingredient.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Expanded(
                              child: Text(
                                capitalize(
                                    widget.ingredient[index]["originalName"]),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.appColor),
                                textAlign: TextAlign.justify,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: AppTheme.appColor,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ); // Add a large empty space for scrolling
  }
}
