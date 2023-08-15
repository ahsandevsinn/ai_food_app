import 'dart:convert';

import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoRecipie extends StatefulWidget {
  final infoData;
  final id;
  const InfoRecipie({Key? key, required this.infoData, this.id}) : super(key: key);
  @override
  State<InfoRecipie> createState() => _InfoRecipieState();
}

class _InfoRecipieState extends State<InfoRecipie> {
  var favouriteRecipes;
  var favouriteRecipesShow;
  var classIds;
  var sharedId;

  @override
  void initState() {
    print("initstae_calls${widget.id}");
    // getFavouriteRecipes();
    super.initState();
  }

  // void getFavouriteRecipes() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   favouriteRecipes = prefs.getString('favouriteRecipes');
  //   favouriteRecipesShow = jsonDecode(favouriteRecipes);
  //   // print("favod_iid${widget.infoData["extendedIngredients"][0]['id']}");
  //   // print("remove_data $favouriteRecipesShow");
  //   for(var ids3 in widget.infoData["extendedIngredients"]){
  //     print("lehgi_id ${ids3['id']}");
  //     classIds = ids3['id'];
  //   }
  //   print("----------------------------------------");
  //   for (var ids in favouriteRecipesShow) {
  //     for(var ids2 in ids['extendedIngredients']){
  //       print("lehgi_id ${ids2['id']}");
  //       sharedId = ids2['id'];
  //     }
  //     if(classIds == sharedId){
  //       print("class_id ${classIds}");
  //     }
  //     // print("getiting_data ${ids['extendedIngredients']["id"]}");
  //     // for (int i = 0; i < ids.length; i++) {
  //     //   for (int j = 0; j < ids.length; j++) {
  //     //     if(favouriteRecipesShow[i]["extendedIngredients"][j]["id"] == widget.infoData["extendedIngredients"][0]['id']){
  //     //       print("geti_receint_id ${widget.infoData["extendedIngredients"][i]['id']}");
  //     //     }
  //     //     print("data_is ${favouriteRecipesShow[i]["extendedIngredients"][j]["id"]}");
  //     //   }
  //     // }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider =
        Provider.of<RecipesParameterProvider>(context, listen: true);
    var ingredient = widget.infoData["extendedIngredients"];
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.infoData["title"]}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              favouriteProvider.favouriteRecipesAdded(favouriteRecipes: widget.infoData);
              favouriteProvider.changeIconType();
              // favouriteProvider.setFavouriteRecipes();
            },
            // icon: classIds == sharedId
            icon:
            // favouriteProvider.changeIcon
            //     ?
            const Icon(Icons.favorite)
                // : const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: CachedNetworkImage(
                imageUrl: "${widget.infoData["image"]}",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text(
                      "Ingredients",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    children: [
                      Column(
                        children: ingredient.map<Widget>((ingredientData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${ingredient.indexOf(ingredientData) + 1}.",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("${ingredientData["name"]}"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text(
                      "Preparation Steps",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    children: [
                      Column(
                        children: List.generate(
                          widget.infoData["analyzedInstructions"][0]["steps"]
                              .length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}.",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "${widget.infoData["analyzedInstructions"][0]["steps"][index]["step"]}",
                                        textAlign: TextAlign.justify,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text(
                      "Website Link",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final websiteUrl =
                                '${widget.infoData["spoonacularSourceUrl"]}';
                            if (await canLaunch(websiteUrl)) {
                              await launch(websiteUrl);
                            } else {
                              throw 'Could not launch $websiteUrl';
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                                "${widget.infoData["spoonacularSourceUrl"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
