import '../../Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';
import '../../Utils/widgets/others/app_text.dart';

class ShoppingList extends StatefulWidget {
  final ingredient;
  final String image;
  final name;
  const ShoppingList(
      {super.key, this.ingredient, required this.image, this.name});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    print("kejfbjkfbe${widget.ingredient.length}");
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var screenHeight = constraints.maxHeight;
        var screenWidth = constraints.maxWidth;

        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 91.7,
              // color: Colors.black,
              child: Stack(
                children: [
                  Container(
                    height: 210,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${widget.image}"),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 150,
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppTheme.appColor, width: 2),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(70)),
                          color: AppTheme.whiteColor),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 25, right: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.appText("${widget.name} ingredients:",
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
                            Container(
                              height: screenHeight - 305,
                              child: SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: Column(
                                  children: List.generate(
                                    widget.ingredient.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    capitalize(
                                                        widget.ingredient[index]
                                                            ["originalName"]),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppTheme.appColor),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
