import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MgFaqs extends StatelessWidget {
  const MgFaqs({super.key});

  static const List<String> titles = [
    'How does MealGuide Premium work?',
    'How will MealGuide Premium benefit me?',
    'What do I get on the free version?',
    'How can I upgrade?',
    'What if I got a meal plan but have some doubts, how do I clarify those?',
  ];

  static const List<String> content = [
    'Just Schedult another call with your nuritionist via the app and get all your doubts answered',
    'Wtih Mg Premium, you\'ll get access to the following:\n\n- A Deidicated Premiusn ieurhg  ieruhg iuerhgi wbew\n- Person shit',
    'Just Schedult another call with your nuritionist via the app and get all your doubts answered',
    'Just Schedult another call with your nuritionist via the app and get all your doubts answered',
    'Just Schedult another call with your nuritionist via the app and get all your doubts answered',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: List.generate(
          5,
          (index) => ExpansionTile(
            collapsedIconColor: Colors.grey,
            title: Padding(
              padding: EdgeInsets.fromLTRB(0, 1.h, 6.w, 1.h),
              child: Text(
                titles[index],
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
            ),
            iconColor: theme.primaryColor,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                child: Text(
                  content[index],
                  style: theme.textTheme.bodySmall,
                ),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}
