import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/recipe_box.dart';
import 'package:mealguide/providers/recipe_provider.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

class AllRecipesPage extends HookConsumerWidget {
  const AllRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeWatcher = ref.watch(recipeProvider);

    return Scaffold(
      body: SizedBox(
        height: 100.h,
        child: recipeWatcher.when(
          data: ((data) {
            return ListView.builder(
              itemCount: data.keys.length,
              itemBuilder: ((context, index) {
                Diet diet = data.keys.toList()[index];
                List<Recipe> showcaseRecipes = diet.showcaseRecipes
                    .map((e) => data.values
                        .toList()[index]
                        .firstWhere((recipe) => recipe.id == e))
                    .toList();

                return Container(
                  height: 33.h,
                  width: 100.w,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              diet.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            MgSecondaryButton('See More', onTap: () {}),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 4.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: showcaseRecipes.length,
                          itemBuilder: ((_, recipeIndex) =>
                              RecipeBox(recipe: showcaseRecipes[recipeIndex])),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      const Divider()
                    ],
                  ),
                );
              }),
            );
          }),
          error: (_, __) => Container(),
          loading: () => Container(),
        ),
      ),
    );
  }
}
