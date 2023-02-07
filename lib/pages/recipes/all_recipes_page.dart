import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/diet_recipes_page.dart';
import 'package:mealguide/pages/recipes/recipe_box.dart';
import 'package:mealguide/pages/recipes/search_page.dart';
import 'package:mealguide/providers/recipe_provider.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:mealguide/widgets/your_diet_box.dart';
import 'package:sizer/sizer.dart';

class AllRecipesPage extends HookConsumerWidget {
  const AllRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeWatcher = ref.watch(recipeProvider);
    final theme = Theme.of(context);

    return recipeWatcher.when(
      data: (data) {
        return Scaffold(
          appBar: MgAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diet Plans',
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 0.25.h),
                    Text(
                      'Explore 1500+ Healthy Recipes!',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.grey.shade100),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
                InkWell(
                  onTap: () {
                    List<Recipe> allRecipes = data.values.fold<List<Recipe>>(
                      [],
                      (previousValue, element) =>
                          [...previousValue, ...element],
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchPage(recipes: allRecipes),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.search,
                      color: theme.primaryColor,
                      size: 18.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SizedBox(
            height: 100.h,
            child: ListView.builder(
              itemCount: data.keys.length + 1,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              itemBuilder: ((context, ind) {
                if (ind == 0) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: YourDietBox(diets: data.keys.toList()),
                  );
                }

                int index = ind - 1;

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
                              diet.getDisplayName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            MgSecondaryButton(
                              'See More',
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DietRecipesPage(
                                    diet: diet,
                                    recipes: data.values.toList()[index],
                                  ),
                                ),
                              ),

                              // ==========================================================

                              // ==========================================================
                            ),
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
            ),
          ),
        );
      },
      error: (_, __) => Container(),
      loading: () => Center(
        child: Text(
          'Getting you some amazing recipes...',
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}
