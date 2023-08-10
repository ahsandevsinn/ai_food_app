import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class InfoRecipie extends StatefulWidget {
  final infoData;
  const InfoRecipie({Key? key, required this.infoData}) : super(key: key);
  @override
  State<InfoRecipie> createState() => _InfoRecipieState();
}
class _InfoRecipieState extends State<InfoRecipie> {
  @override
  Widget build(BuildContext context) {
    var ingredient = widget.infoData["extendedIngredients"];
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.infoData["title"]}"),
        centerTitle: true,
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
                                  SizedBox(width: 5),
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
                            const youtubeUrl =
                                'https://spoonacular.com/chicken-adobo-coconut-ginger-rice-637883';
                            if (await canLaunch(youtubeUrl)) {
                              await launch(youtubeUrl);
                            } else {
                              throw 'Could not launch $youtubeUrl';
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