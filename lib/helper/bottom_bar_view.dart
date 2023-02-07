import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/added_items_hive_model.dart';
import 'package:mealguide/pages/diary/diary_page.dart';
import 'package:mealguide/pages/items/items_page.dart';
import 'package:mealguide/pages/profile/profile_page.dart';
import 'package:mealguide/pages/recipes/all_recipes_page.dart';
import 'package:mealguide/pages/upgrade/upgrade_page.dart';
import 'package:mealguide/providers/bottom_bar_provider.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:mealguide/widgets/tab_bar_icon.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sizer/sizer.dart';

class BottomBarView extends HookConsumerWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bottomBarState = ref.watch(bottomBarStateNotifierProvider);

    useEffect(() {
      ref.read(hiveProvider).getPantryFromStorage();
      ref.read(hiveProvider).setLocalPlanFromStorage();
      return null;
    }, []);

    List<Widget> screens = [
      const AllRecipesPage(),
      const DiaryPage(),
      const ItemsPage(),
      const ProfilePage(),
      const UpgradePage(),
    ];

    return PersistentTabView(
      context,
      stateManagement: true,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screens: screens,
      backgroundColor: theme.canvasColor,
      hideNavigationBar: !bottomBarState.showBar,
      navBarHeight: kBottomNavigationBarHeight + 1.h,
      padding: NavBarPadding.symmetric(vertical: 0.5.h, horizontal: 2.w),
      items: [
        PersistentBottomNavBarItem(
          icon: const MgTabIcon(
            image: 'assets/tabs/recipes.png',
            title: 'Recipes',
            tab: 0,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const MgTabIcon(
            image: 'assets/tabs/dietplan.png',
            title: 'Meal Plan',
            tab: 1,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const MgTabIcon(
            image: 'assets/tabs/shopping.png',
            title: 'Items',
            tab: 2,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const MgTabIcon(
            image: 'assets/tabs/profile.png',
            title: 'Profile',
            tab: 3,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const MgTabIcon(
            image: 'assets/tabs/upgrade.png',
            title: 'Upgrade',
            tab: 4,
          ),
        ),
      ],
      onItemSelected: (value) => ref
          .read(bottomBarStateNotifierProvider.notifier)
          .setSelectedTab(value),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10)
        ],
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}
