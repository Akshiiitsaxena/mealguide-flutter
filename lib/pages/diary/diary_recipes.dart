import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/day_plan_model.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/meal_plan_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/recipe_page.dart';
import 'package:mealguide/providers/bottom_bar_provider.dart';
import 'package:mealguide/providers/recipe_provider.dart';
import 'package:mealguide/widgets/diary_container.dart';
import 'package:sizer/sizer.dart';

class DiaryRecipes extends HookConsumerWidget {
  final DayPlan dayPlan;

  const DiaryRecipes({super.key, required this.dayPlan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ...List.generate(
          dayPlan.mealPlan.length,
          (index) {
            MealPlan plan = dayPlan.mealPlan[index];

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: InkWell(
                onTap: () async {
                  Map<Diet, List<Recipe>> dietAllRecipes =
                      await ref.read(recipeProvider.future);

                  List<Recipe> allRecipes = dietAllRecipes.values
                      .fold([], (prev, element) => [...prev, ...element]);

                  final recipe = allRecipes.firstWhere(
                      (element) => element.identifier == plan.recipeIdentifier);

                  ref.read(bottomBarStateNotifierProvider.notifier).hideBar();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => RecipePage(recipe: recipe),
                        ),
                      )
                      .then(
                        (_) => ref
                            .read(bottomBarStateNotifierProvider.notifier)
                            .showBar(),
                      );
                },
                child: DiaryContainer(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.category.toString().toUpperCase(),
                        style: theme.textTheme.bodySmall!
                            .copyWith(letterSpacing: 1.5),
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        children: [
                          SizedBox(
                            height: 9.h,
                            width: 9.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: plan.recipeImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${plan.nutrition.calories.floor().toStringAsFixed(0)} kcal • 20 mins',
                                  style: theme.textTheme.bodySmall,
                                ),
                                Text(
                                  plan.recipeName,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 2.w),
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: theme.primaryColor, width: 1.5),
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: theme.primaryColor,
                                size: 12.sp,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
