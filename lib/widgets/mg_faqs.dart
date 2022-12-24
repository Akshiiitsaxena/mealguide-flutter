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
    ' MealGuide Premium helps you take control of your health.\nBased on the answers you provided in the app onboarding questionnaire, a nutritionist is assigned to you. You can then schedule a call with this nutritionist and explain all your needs to them.\n\nOnce they understand what you want, they will create the ideal diet plan for you. If you don’t like the plan, need changes or just need more clarifications and help, let them know by scheduling another call with them and and they’ll be happy to help!',
    'With MealGuide Premium, you’ll get access to the following:\n- A dedicated nutritionist for all your needs\n- Personalized diet plans\n- Accountability for your health\n- Guided weight loss and health improvement\n- Full access to all recipes listed on the app',
    'In the free version you only get access to a limited number of recipes listed on the app.',
    'Just simply click on any plan that intrigues you and make the payment, it’s really that simple.',
    'Just schedule another call with your nutritionist via the app and get all your doubts answered.'
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
