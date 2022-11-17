import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/onboarding/onboarding_quiz.dart';
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

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const OnboardingQuiz(),
        );
      },
    );
  }
}
