import 'package:flutter/material.dart';
import 'package:mealguide/pages/onboarding/onboarding_quiz.dart';
import 'package:mealguide/widgets/rotating_plate.dart';
import 'package:sizer/sizer.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: theme.primaryColor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clean, mindful eating\nstarts here.',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Let\'s take a small quiz to personalise the app for you!',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OnboardingQuiz(),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 50.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text('Start',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.black, fontSize: 12.sp)),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 14.sp,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h)
              ],
            ),
            RotatingPlate('assets/plates/pcod_plate.png',
                size: 45.h, left: -35.w, top: -8.h),
          ],
        ),
      ),
    );
  }
}
