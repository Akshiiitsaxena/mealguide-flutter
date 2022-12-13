import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/diet_recipe_box.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/providers/recipe_provider.dart';
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

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: theme.hoverColor.withOpacity(0.1),
                ),
                height: 0.5.h,
                width: 20.w,
              ),
              SizedBox(height: 2.h),
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
                        isForPantry
                            ? 'Move to shopping list'
                            : 'Mark as completed',
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
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  static showRecipesBottomSheet(
    BuildContext context,
    WidgetRef ref, {
    required String ingredientId,
    required String name,
  }) async {
    final theme = Theme.of(context);

    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 70.h,
          child: ref.read(recipeProvider).when(
                data: (data) {
                  List<Recipe> allRecipes = data.values
                      .fold<List<Recipe>>([], (prev, ele) => [...prev, ...ele])
                      .toSet()
                      .toList();

                  List<Recipe> ingredientRecipes = [];

                  for (var recipe in allRecipes) {
                    for (var ing in recipe.ingredients) {
                      if (ing.items.any(
                          (element) => element.ingredientId == ingredientId)) {
                        ingredientRecipes.add(recipe);
                        break;
                      }
                    }
                  }

                  List<Recipe> uniqueRecipes =
                      ingredientRecipes.toSet().toList();

                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: theme.hoverColor.withOpacity(0.1),
                          ),
                          height: 0.5.h,
                          width: 20.w,
                        ),
                        SizedBox(height: 2.h),
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
                            children:
                                List.generate(uniqueRecipes.length, (index) {
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
              ),
        );
      },
    );
  }
}
