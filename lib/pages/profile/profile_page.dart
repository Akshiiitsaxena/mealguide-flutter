import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/profile/profile_tile.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MgAppBar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App settings',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 0.25.h),
            Text(
              'Have a great day ahead!',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: Colors.grey.shade100),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: MgPrimaryButton(
              'Sign In Now',
              onTap: () {},
              isEnabled: true,
              height: 6.h,
            ),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Connecting to your account helps us further personalise the app, suggest better diet plans and back-up your saved recipes and ingredients.',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: Colors.grey, fontSize: 10.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 4.h),
          Text('DIARY ACTIONS', style: theme.textTheme.bodySmall),
          SizedBox(height: 1.5.h),
          ProfileTile(
            title: 'Retake Onboarding Quiz',
            icon: Icons.question_answer_outlined,
            onTap: () {},
          ),
          ProfileTile(
            title: 'Recurate the Weekly Plan',
            icon: Icons.view_week_outlined,
            onTap: () {},
          ),
          ProfileTile(
            title: 'Daily Glasses of Water',
            icon: Icons.water_drop_outlined,
            trailing: '10',
            onTap: () {},
          ),
          Divider(height: 2.5.h),
          SizedBox(height: 1.5.h),
          Text('MEAL NOTIFICATIONS', style: theme.textTheme.bodySmall),
          SizedBox(height: 1.5.h),
          ProfileTile(
            title: 'Breakfast Notifications',
            icon: Icons.notifications_none,
            onTap: () {},
            trailing: 'Disabled',
          ),
          ProfileTile(
            title: 'Lunch Notifications',
            icon: Icons.notifications_off_outlined,
            onTap: () {},
            trailing: 'Disabled',
          ),
          ProfileTile(
            title: 'Snacks Notifications',
            icon: Icons.notifications_off_outlined,
            onTap: () {},
            trailing: 'Disabled',
          ),
          ProfileTile(
            title: 'Dinner Notifications',
            icon: Icons.notifications_none,
            onTap: () {},
            trailing: 'Disabled',
          ),
          Divider(height: 2.5.h),
          SizedBox(height: 1.5.h),
          Text('APP SETTINGS', style: theme.textTheme.bodySmall),
          SizedBox(height: 1.5.h),
          ProfileTile(
            title: 'Give Feedback',
            icon: Icons.feedback_outlined,
            onTap: () {},
          ),
          ProfileTile(
            title: 'Rate MealGuide on PlayStore',
            icon: Icons.star_border,
            onTap: () {},
          ),
          Divider(height: 2.5.h),
          ProfileTile(
            title: 'Sign Out',
            icon: Icons.logout,
            onTap: () {},
            isLogout: true,
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
