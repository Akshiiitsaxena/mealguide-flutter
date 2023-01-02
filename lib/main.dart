import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_bar_view.dart';
import 'package:mealguide/helper/brightness_notifier.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:mealguide/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
      return null;
    }, []);

    ThemeMode mode = ref.watch(themeStateNotifierProvider).mode;
    return BrightnessNotifier(
      onBrightnessChanged: () => handleTheme(ref),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              title: 'MealGuide',
              themeMode: mode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const BottomBarView(),
              debugShowCheckedModeBanner: false,
            ),
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
