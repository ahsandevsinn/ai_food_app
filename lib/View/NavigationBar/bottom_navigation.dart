import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/View/AskMaida/ask_maida_screen.dart';
import 'package:ai_food/View/FavouriteScreen/favourite_screen.dart';
import 'package:ai_food/View/HomeScreen/home_screen.dart';
import 'package:ai_food/View/SettingScreen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavView extends StatefulWidget {
  final responseData;

  BottomNavView({super.key, this.responseData});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      HomeScreen(responseData: widget.responseData ?? ""),
      const FavouriteScreen(),
      const AskMaidaScreen(),
      const SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.appColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: GNav(
              tabMargin: const EdgeInsets.only(top: 8, bottom: 8),
              rippleColor: AppTheme.appColor,
              gap: 6,
              tabBorderRadius: 10,
              activeColor: AppTheme.appColor,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              duration: const Duration(milliseconds: 450),
              tabBackgroundColor: AppTheme.whiteColor,
              color: AppTheme.whiteColor,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border_outlined,
                  text: 'Favourite',
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Ask Maida',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
