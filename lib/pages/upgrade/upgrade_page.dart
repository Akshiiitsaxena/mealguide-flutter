import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/widgets/mg_faqs.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:mealguide/widgets/subscription_box.dart';
import 'package:mealguide/widgets/upgrade_button.dart';
import 'package:mealguide/widgets/upgrade_info_tile.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

class UpgradePage extends HookConsumerWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ItemScrollController();
    final theme = Theme.of(context);
    final chosenPlan = useState(0);

    List<Widget> widgets = [
      SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Image.asset('assets/upgrade_features/upgrade_header.png'),
      )),
      SizedBox(height: 3.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Text(
          'Unlock a healthier you.',
          style: theme.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w900, color: theme.primaryColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
        child: Text(
          'Unlock MealGuide to make meal planning and prepping effortless!',
          style: theme.textTheme.bodySmall,
        ),
      ),
      SizedBox(height: 1.h),
      UpgradeButton(
        child: Text(
          'View Plans',
          style: theme.textTheme.titleMedium!.copyWith(fontSize: 14.sp),
        ),
        onTap: () => controller.scrollTo(
          index: 9,
          duration: const Duration(milliseconds: 200),
        ),
      ),
      UpgradeButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/graphics/whatsapp-color.png',
              height: 22.sp,
              width: 22.sp,
            ),
            SizedBox(width: 2.w),
            Text(
              'Chat with us',
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
        onTap: () {},
      ),
      UpgradeButton(
        child: Text(
          'View FAQs',
          style: theme.textTheme.titleMedium!.copyWith(fontSize: 14.sp),
        ),
        onTap: () => controller.scrollTo(
          index: 15,
          duration: const Duration(milliseconds: 200),
        ),
      ),
      SizedBox(height: 1.h),
      const UpgradeInfoTile(
        content:
            'Unlimited calls with our nutritionists to help you receive the best guidance.',
        title: 'One on One Consultations',
        image: 'assets/upgrade_features/feature_1.png',
      ),
      const UpgradeInfoTile(
        content:
            'Fresh meal plans curated just for you by our nutritionists, post consultation.',
        title: 'Personalised Weekly Plans',
        image: 'assets/upgrade_features/feature_2.png',
      ),
      const UpgradeInfoTile(
        content:
            'Hundreds of easy to make, dietician-approved recipes for you to try.',
        title: 'Curated by Nutritionists',
        image: 'assets/upgrade_features/feature_3.png',
      ),
      SizedBox(height: 3.h),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SubcriptionBox(
              oldPrice: '₹ 2,698.50',
              newPrice: '₹ 1,799.00',
              duration: 'monthly',
              isSelected: chosenPlan.value == 0,
              onTap: () => chosenPlan.value = 0,
            ),
            SubcriptionBox(
              oldPrice: '₹ 6,748.50',
              newPrice: '₹ 4,499.00',
              duration: '3 months',
              isSelected: chosenPlan.value == 1,
              onTap: () => chosenPlan.value = 1,
            ),
            SubcriptionBox(
              oldPrice: '₹ 11,250.50',
              newPrice: '₹ 7,500.00',
              duration: '6 months',
              isSelected: chosenPlan.value == 2,
              onTap: () => chosenPlan.value = 2,
            ),
          ],
        ),
      ),
      SizedBox(height: 2.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: MgPrimaryButton(
          'GET STARTED',
          onTap: () {},
          isEnabled: true,
          height: 6.h,
        ),
      ),
      SizedBox(height: 2.h),
      const MgFaqs(),
      SizedBox(height: 2.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          'Still have more questions or not convinced if MealGuide Premium is for you? - Call or chat with us now and we\'ll answer all your queries!',
          style: theme.textTheme.bodySmall,
        ),
      ),
      SizedBox(height: 2.h),
      UpgradeButton(
        child: Text(
          'Chat with us',
          style: theme.textTheme.titleMedium!.copyWith(fontSize: 14.sp),
        ),
        onTap: () {},
      ),
      SizedBox(height: 10.h),
    ];

    return Scaffold(
      body: ScrollablePositionedList.builder(
        itemScrollController: controller,
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return widgets[index];
        },
      ),
    );
  }
}
