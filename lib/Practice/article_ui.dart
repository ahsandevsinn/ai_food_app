import 'package:ai_food/Practice/article_class.dart';
import 'package:ai_food/Practice/article_details_screen.dart';
import 'package:ai_food/Practice/article_provider.dart';
import 'package:ai_food/Practice/sorting_books_screen.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Articles", size: 20),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
                CupertinoPageRoute(builder: (_) => const SortingBooksScreen()));
          }, icon: const Icon(Icons.navigate_next_sharp)),
        ],
      ),
      body: ListView.builder(
        itemCount: articleProvider.article.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final articleGet = articleProvider.article[index];
          return articleProvider.article == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  child: ListTile(
                    title: Text(articleGet.title),
                    subtitle: Text(
                      articleGet.content,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   CupertinoPageRoute(
                    //     builder: (_) => ArticleDetailsScreen(
                    //         title: articleGet.title,
                    //         content: articleGet.content),
                    //   ),
                    // );
                    articleProvider.showArticleDetails(context,
                        title: articleGet.title, content: articleGet.content);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          articleProvider.showArticle(
            const Article(
              title: "The Art of Culinary Fusion: Creative Cooking Techniques",
              content:
                  "Embark on a culinary journey that transcends traditional boundaries, where flavors, ingredients, and techniques from diverse cultures blend to create a harmonious symphony of tastes. Explore the art of culinary fusion, where innovation meets tradition, and chefs experiment with daring combinations to delight the palate. From sushi burritos to Indian-inspired tacos, discover how this gastronomic trend is redefining the dining experience and pushing the boundaries of culinary creativity.",
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
