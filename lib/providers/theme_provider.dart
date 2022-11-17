import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class ThemeState {
  final ThemeMode mode;

  const ThemeState({this.mode = ThemeMode.light});

  ThemeState copyWith({ThemeMode? mode}) => ThemeState(mode: mode ?? this.mode);
}

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier() : super(const ThemeState());

  void setTheme(ThemeMode value) => state = state.copyWith(mode: value);
}

final themeStateNotifierProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>(
  (ref) => ThemeStateNotifier(),
);
