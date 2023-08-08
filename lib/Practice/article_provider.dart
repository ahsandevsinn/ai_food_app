import 'package:ai_food/Practice/article_class.dart';
import 'package:ai_food/Practice/article_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ArticleProvider extends ChangeNotifier {
  final List<Article> _article = [];

  List<Article> get article => _article;

  List<Article> showArticle(Article articleData) {
    _article.add(articleData);
    notifyListeners();
    return article;
  }

  void showArticleDetails(context, {required String title, required String content}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => ArticleDetailsScreen(title: title, content: content),
      ),
    );
  }
}
