import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_bar_view.dart';
import 'package:mealguide/helper/brightness_notifier.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:mealguide/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode mode = ref.watch(themeStateNotifierProvider).mode;
    return BrightnessNotifier(
      onBrightnessChanged: () => handleTheme(ref),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'MealGuide',
            themeMode: mode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const BottomBarView(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  void handleTheme(WidgetRef ref) {
    switch (WidgetsBinding.instance.window.platformBrightness) {
      case Brightness.dark:
        ref.read(themeStateNotifierProvider.notifier).setTheme(ThemeMode.dark);
        break;
      case Brightness.light:
        ref.read(themeStateNotifierProvider.notifier).setTheme(ThemeMode.light);
        break;
      default:
    }
  }
}
