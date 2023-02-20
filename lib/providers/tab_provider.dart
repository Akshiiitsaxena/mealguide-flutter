import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

final tabControllerProvider = Provider((ref) => TabControllerManager(ref));

class TabControllerManager {
  final ProviderRef ref;
  PersistentTabController? tabController;

  TabControllerManager(this.ref);

  void setTabController({required int tab}) {
    tabController = PersistentTabController(initialIndex: tab);
  }

  void goToTab({required int tab}) {
    tabController!.jumpToTab(tab);
  }
}
