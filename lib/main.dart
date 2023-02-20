import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_bar_view.dart';
import 'package:mealguide/helper/brightness_notifier.dart';
import 'package:mealguide/models/added_items_hive_model.dart';
import 'package:mealguide/pages/auth/email_verification_page.dart';
import 'package:mealguide/pages/auth/phone_number_page.dart';
import 'package:mealguide/pages/onboarding/start_screen.dart';
import 'package:mealguide/providers/auth_provider.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:mealguide/providers/notification_provider.dart';
import 'package:mealguide/providers/revenuecat_provider.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:mealguide/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CountryCodes.init();

  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(AddedItemAdapter());

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
      ref.read(notificationProvider).initHandler();
      ref.read(revenueCatProvider).initPlatformState();
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
              home: Builder(builder: (context) {
                if (FirebaseAuth.instance.currentUser != null) {
                  final user = FirebaseAuth.instance.currentUser;
                  ref.read(authProvider).setUserToken();
                  if (user!.email == null || user.email!.isEmpty) {
                    return const EmailVerificationPage();
                  }
                  return const BottomBarView();
                }

                // if user is not signed in
                return FutureBuilder<String>(
                  future: ref.read(hiveProvider).getLocalMealPlan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? const StartScreen()
                          : const PhoneNumberPage();
                    } else {
                      return Container(
                        height: 100.h,
                        width: 100.w,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      );
                    }
                  },
                );
              }),
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
