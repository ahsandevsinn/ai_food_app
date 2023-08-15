import 'package:ai_food/spoonacular/screens/info_recipe_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchedRecipes extends StatefulWidget {
  final List<dynamic> showRecipes;
  const SearchedRecipes({Key? key, required this.showRecipes})
      : super(key: key);

  @override
  State<SearchedRecipes> createState() => _SearchedRecipesState();
}

class _SearchedRecipesState extends State<SearchedRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Searched recipes"),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 16.0, // Spacing between columns
          mainAxisSpacing: 16.0,
        ),
        itemCount: widget.showRecipes.length,
        itemBuilder: (context, index) {
          final gettingRecipes = widget.showRecipes[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InfoRecipie(
                infoData: gettingRecipes,
                id: gettingRecipes['extendedIngredients'][index]['id'],
              ),));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
                        height: 120,
                        foregroundDecoration:
                        const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        width: double.infinity,
                        child: CachedNetworkImage(
                          key: ValueKey<int>(index),
                          imageUrl: "${gettingRecipes["image"]}",
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
                        gettingRecipes["title"],
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
          );
        },
      ),
    );
  }
}
