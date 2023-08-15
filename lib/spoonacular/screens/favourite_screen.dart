import 'dart:convert';

import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:ai_food/spoonacular/screens/info_recipe_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var favouriteRecipes;
  var favouriteRecipesShow;
  @override
  void initState() {
    print("initstae_called");
    getFavouriteRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipesParameterProvider =
    Provider.of<RecipesParameterProvider>(context, listen: true);
    getFavouriteRecipes();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Favourites",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getFavouriteRecipes();
                  });
                },
                icon: const Icon(Icons.downloading))
          ],
        ),
        body:
        recipesParameterProvider.addFavouriteRecipes.length==0
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.heart_fill,
                      size: 105,
                      color: Colors.grey,
                    ),
                    SizedBox(
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
              )
            :
        ListView.builder(
                shrinkWrap: true,
                // itemCount: widget.showRecipes.length,
                itemCount: recipesParameterProvider.addFavouriteRecipes.length,
                itemBuilder: (context, index) {
                  // final gettingRecipes = jsonDecode(favouriteRecipes);
                  final gettingRecipes = recipesParameterProvider.addFavouriteRecipes;
                  // print("get_recipes $gettingRecipes");
                  // print("get_recipes ${jsonDecode(favouriteRecipes).length}");
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoRecipie(
                              infoData: gettingRecipes[index],
                            ),
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 235, 225, 225),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(-2, -2),
                                blurRadius: 12,
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                              ),
                              BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, 0.10),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Container(
                                  height: 160,
                                  foregroundDecoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    key: ValueKey<int>(index),
                                    imageUrl:
                                        "${gettingRecipes[index]["image"]}",
                                    // imageUrl: "https://spoonacular.com/recipeImages/633765-556x370.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(9),
                                child: Text(
                                  gettingRecipes[index]["title"],
                                  // "Very good recipes are here to see",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
  void getFavouriteRecipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favouriteRecipes = prefs.getString('favouriteRecipes');
    favouriteRecipesShow = jsonDecode(favouriteRecipes);
  }
}
