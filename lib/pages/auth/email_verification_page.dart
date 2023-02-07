import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/bottom_bar_view.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/mg_loading_blur.dart';
import 'package:mealguide/providers/auth_provider.dart';
import 'package:mealguide/widgets/error_dialog.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class EmailVerificationPage extends HookConsumerWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isLoading = useState(false);

    return Stack(
      children: [
        Scaffold(
          appBar: MgAppBar(
            height: 10.h,
            child: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                'Verify your Email',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  'Your phone number is verified. Just one more step and you\'re all set to start a healthy lifestyle!',
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Connecting to your email helps us further personalise the app, send invitations for your calls with our certified nutritionists.',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    try {
                      isLoading.value = true;
                      await ref.read(authProvider).refreshToken();
                      await ref.read(authProvider).signInWithGoogle();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const BottomBarView(),
                        ),
                      );
                    } on MgException catch (e) {
                      MgErrorDialog.showErrorDialog(
                        context,
                        title: 'Oops!',
                        subtitle: e.message ?? 'Something went wrong',
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                            child: Text(
                              'Okay',
                              style: theme.textTheme.bodySmall!
                                  .copyWith(color: theme.primaryColor),
                            ),
                          )
                        ],
                      );
                    } finally {
                      isLoading.value = false;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.indicatorColor,
                    ),
                    width: 100.w,
                    height: 6.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/logo/google-icon.svg',
                          height: 2.5.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Sign in with Google',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.focusColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isLoading.value,
          child: const MgLoadingBlur(),
        ),
      ],
    );
  }
}
