import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class BottomBarState {
  final bool showBar;
  final int selectedTab;

  const BottomBarState(this.showBar, this.selectedTab);

  BottomBarState copyWith({bool? showBar, int? selectedTab}) {
    return BottomBarState(
        showBar ?? this.showBar, selectedTab ?? this.selectedTab);
  }
}

class BottomBarStateNotifier extends StateNotifier<BottomBarState> {
  BottomBarStateNotifier() : super(const BottomBarState(true, 0));

  void showBar() {
    state = state.copyWith(showBar: true);
  }

  void hideBar() {
    state = state.copyWith(showBar: false);
  }

  void setSelectedTab(int value) {
    state = state.copyWith(selectedTab: value);
  }
}

final bottomBarStateNotifierProvider =
    StateNotifierProvider<BottomBarStateNotifier, BottomBarState>(
  (_) => BottomBarStateNotifier(),
);
