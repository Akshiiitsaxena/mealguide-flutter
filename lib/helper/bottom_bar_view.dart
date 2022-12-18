import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/added_items_hive_model.dart';
import 'package:mealguide/pages/items/items_page.dart';
import 'package:mealguide/pages/recipes/all_recipes_page.dart';
import 'package:mealguide/pages/upgrade/upgrade_page.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class BottomBarView extends HookConsumerWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    useEffect(() {
      path_provider.getApplicationDocumentsDirectory().then((dir) {
        Hive.init(dir.path);
        Hive.registerAdapter(AddedItemAdapter());
        ref.read(hiveProvider).getFromStorage();
      });
      return null;
    }, []);

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
        UpgradePage(),
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
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.upgrade_rounded),
          title: 'Upgrade',
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
      navBarStyle: NavBarStyle.style6,
    );
  }
}
