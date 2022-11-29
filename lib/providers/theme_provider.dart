import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class ThemeState {
  final ThemeMode mode;

  const ThemeState(this.mode);

  ThemeState copyWith({ThemeMode? mode}) => ThemeState(mode ?? this.mode);
}

class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier()
      : super(ThemeState(
          SchedulerBinding.instance.window.platformBrightness ==
                  Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
        ));

  void setTheme(ThemeMode value) => state = state.copyWith(mode: value);
}

final themeStateNotifierProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>(
  (ref) => ThemeStateNotifier(),
);
