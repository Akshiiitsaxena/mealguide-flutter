import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/items/items_page.dart';
import 'package:mealguide/pages/recipes/all_recipes_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomBarView extends HookConsumerWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return PersistentTabView(
      context,
      stateManagement: true,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screens: const [
        AllRecipesPage(),
        ItemsPage(),
      ],
      backgroundColor: theme.canvasColor,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.food_bank_outlined),
          title: 'Recipes',
          activeColorPrimary: const Color(0xff7e79eb),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.menu),
          title: 'Items',
          activeColorPrimary: const Color(0xff7e79eb),
          inactiveColorPrimary: Colors.grey,
        ),
      ],
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10)
        ],
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 300),
      ),
      // itemAnimationProperties: const ItemAnimationProperties(
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 300),
      // ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
