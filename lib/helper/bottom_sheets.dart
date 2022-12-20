import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/diet_recipe_box.dart';
import 'package:mealguide/pages/recipes/servings_tile.dart';
import 'package:mealguide/providers/diary_provider.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/providers/recipe_provider.dart';
import 'package:mealguide/widgets/bottom_sheet_template.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class MgBottomSheet {
  static showItemBottomSheet(
    BuildContext context,
    WidgetRef ref, {
    required bool isForPantry,
    required String title,
    required String id,
    Function()? markCompleted,
    Function()? showRecipes,
    Function()? moveToShopping,
    Function()? updateExpiry,
  }) async {
    final theme = Theme.of(context);

    Widget child = Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
        SizedBox(height: 1.h),
        const Divider(),
        InkWell(
          onTap: () {
            isForPantry ? moveToShopping!() : markCompleted!();
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              children: [
                Icon(
                  isForPantry
                      ? Icons.shopping_cart_outlined
                      : Icons.check_circle_outline,
                  size: 16.sp,
                  color: theme.indicatorColor.withOpacity(0.5),
                ),
                SizedBox(width: 2.w),
                Text(
                  isForPantry ? 'Move to shopping list' : 'Mark as completed',
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            isForPantry ? updateExpiry!() : showRecipes!();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              children: [
                Icon(
                  isForPantry ? Icons.restore_outlined : Icons.list,
                  size: 16.sp,
                  color: theme.indicatorColor.withOpacity(0.5),
                ),
                SizedBox(width: 2.w),
                Text(
                  isForPantry ? 'Update exipry date' : 'Show Recipes',
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () {
            ref
                .read(pantryStateNotifierProvider.notifier)
                .removeIngredients(id);
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              children: [
                Icon(Icons.delete, size: 16.sp, color: Colors.redAccent),
                SizedBox(width: 2.w),
                Text(
                  'Delete item',
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );

    return showSheet(context, child: child);
  }

  static showRecipesBottomSheet(
    BuildContext context,
    WidgetRef ref, {
    required String ingredientId,
    required String name,
  }) async {
    final theme = Theme.of(context);

    Widget child = ref.read(recipeProvider).when(
          data: (data) {
            List<Recipe> allRecipes = data.values
                .fold<List<Recipe>>([], (prev, ele) => [...prev, ...ele])
                .toSet()
                .toList();

            List<Recipe> ingredientRecipes = [];

            for (var recipe in allRecipes) {
              for (var ing in recipe.ingredients) {
                if (ing.items
                    .any((element) => element.ingredientId == ingredientId)) {
                  ingredientRecipes.add(recipe);
                  break;
                }
              }
            }

            List<Recipe> uniqueRecipes = ingredientRecipes.toSet().toList();

            return SizedBox(
              height: 70.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text('$name Recipes',
                        style: theme.textTheme.titleMedium),
                  ),
                  SizedBox(height: 1.h),
                  const Divider(),
                  SizedBox(height: 1.h),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      mainAxisSpacing: 2.h,
                      crossAxisSpacing: 2.h,
                      children: List.generate(uniqueRecipes.length, (index) {
                        Recipe recipe = uniqueRecipes[index];
                        return DietRecipeBox(recipe: recipe);
                      }),
                    ),
                  )
                ],
              ),
            );
          },
          error: (_, __) => Container(),
          loading: () => Container(),
        );

    return showSheet(context, child: child);
  }

  static showDailyGlassBotterSheet(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    Widget child = Consumer(builder: (context, ref, _) {
      int currentGlasses = ref.watch(diaryStateNotifierProvider).dailyWater;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose the number of glasses of\nwater you want to consume in a day.',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color: theme.canvasColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildChangeBox(
                  () => ref
                      .read(diaryStateNotifierProvider.notifier)
                      .setDailyWater(currentGlasses - 1),
                  theme,
                  Icons.remove,
                ),
                SizedBox(width: 4.w),
                Text(
                  currentGlasses.toString(),
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 4.w),
                buildChangeBox(
                  () => ref
                      .read(diaryStateNotifierProvider.notifier)
                      .setDailyWater(currentGlasses + 1),
                  theme,
                  Icons.add,
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          MgPrimaryButton(
            'Save',
            onTap: () => Navigator.of(context).pop(),
            isEnabled: true,
            height: 6.h,
            width: 62.w,
          ),
          SizedBox(height: 3.h),
          Text(
            'We suggest having at-least 8 glasses daily.',
            style: theme.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
        ],
      );
    });

    showSheet(context, child: child);
  }
}
