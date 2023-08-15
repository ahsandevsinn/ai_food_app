import 'package:ai_food/spoonacular/recipies.dart';
import 'package:ai_food/spoonacular/screens/chat_bot.dart';
import 'package:ai_food/spoonacular/screens/chat_bot_talk.dart';
import 'package:ai_food/spoonacular/screens/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class BottomNavView extends StatelessWidget {
  BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersistentTabController(initialIndex: 0),
      child: Scaffold(
        body: Center(
          child: Consumer<PersistentTabController>(
            builder: (context, controller, child) {
              return PersistentTabView(
                context,
                controller: controller,
                screens: _widgetOptions,
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                hideNavigationBarWhenKeyboardShows: true,
                popAllScreensOnTapOfSelectedTab: true,
                navBarStyle: NavBarStyle.style6,
              );
            },
          ),
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Recipies(),
    const FavouriteScreen(),
    const ChatBotScreen(),
    const ChatBotTalkScreen(),
    // More(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          Icons.favorite_outline,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Favourite"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          Icons.rocket,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("Ask Maida"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          Icons.phone_in_talk,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("ChatBot"),
      ),
    ];
  }
}
