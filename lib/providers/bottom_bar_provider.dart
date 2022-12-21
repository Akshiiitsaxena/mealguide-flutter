import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class BottomBarState {
  final bool showBar;

  const BottomBarState(this.showBar);

  BottomBarState copyWith({bool? showBar}) {
    return BottomBarState(showBar ?? this.showBar);
  }
}

class BottomBarStateNotifier extends StateNotifier<BottomBarState> {
  BottomBarStateNotifier() : super(const BottomBarState(true));

  void showBar() {
    state = state.copyWith(showBar: true);
  }

  void hideBar() {
    state = state.copyWith(showBar: false);
  }
}

final bottomBarStateNotifierProvider =
    StateNotifierProvider<BottomBarStateNotifier, BottomBarState>(
  (_) => BottomBarStateNotifier(),
);
