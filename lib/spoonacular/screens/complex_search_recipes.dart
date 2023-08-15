import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/spoonacular/screens/info_recipe_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComplexSearchedRecipes extends StatefulWidget {
  final List<dynamic> showRecipes;
  const ComplexSearchedRecipes({Key? key, required this.showRecipes})
      : super(key: key);

  @override
  State<ComplexSearchedRecipes> createState() => _ComplexSearchedRecipesState();
}

class _ComplexSearchedRecipesState extends State<ComplexSearchedRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Searched recipes"),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 16.0, // Spacing between columns
          mainAxisSpacing: 16.0,
        ),
        itemCount: widget.showRecipes.length,
        itemBuilder: (context, index) {
          final gettingRecipes = widget.showRecipes[index];
          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => InfoRecipie(
              //       infoData: gettingRecipes,
              //       id: gettingRecipes['id'],
              //     ),
              //   ),
              // );
              getFood(gettingRecipes['id']);
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
                        foregroundDecoration: const BoxDecoration(
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
  getFood(id) async {
    const apiKey = 'd9186e5f351240e094658382be62d948';
    final apiUrl =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';
    final response = await AppDio(context).get(path:apiUrl);
    if (response.statusCode == 200) {
      var data = response.data;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => InfoRecipie(infoData: data)));
      setState(() {});
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
}
