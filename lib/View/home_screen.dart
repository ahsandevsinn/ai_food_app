import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/search_recipes_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          onTap: (){
            push(context, const SearchRecipesScreen());
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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: width,
        // color: Colors.blueGrey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppText.appText("Recommended:",
                  fontSize: 20, textColor: AppTheme.appColor),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: width / (2.26 * 238), // Width-to-height ratio
                ),
                shrinkWrap: true,
                itemCount: 11,
                itemBuilder: (context, int index) {
                  return Container(
                    width: width / 2.26,
                    height: 238,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
                                    height: 130,
                                    width: width,
                                    // placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while loading
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons
                                            .error), // Error widget if the image fails to load
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: AppText.appText("This is Product This is Product This is Product This is Product",
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
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
