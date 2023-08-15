import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String title;
  final String content;
  const ArticleDetailsScreen({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListTile(
        title: Text(widget.title),
        subtitle: Text(
          widget.content,
          textAlign: TextAlign.justify
        ),
      ),
    );
  }
}
