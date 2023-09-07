import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Favorite Recipes",
          style:
              TextStyle(color: AppTheme.appColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
