import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/recipe_provider.dart';
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
                  color: Colors.red.shade900,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(diet.name),
                          const Text('See More'),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: showcaseRecipes.length,
                          itemBuilder: ((context, recipeIndex) {
                            Recipe recipe = showcaseRecipes[recipeIndex];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              child: Text(recipe.name),
                            );
                          }),
                        ),
                      )
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
