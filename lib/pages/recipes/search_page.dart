import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:sizer/sizer.dart';

import 'diet_recipe_box.dart';

class SearchPage extends HookConsumerWidget {
  final List<Recipe> recipes;

  const SearchPage({required this.recipes, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchController = useTextEditingController();

    final filter = useState('');

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 22.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(160),
                  ),
                  width: 100.w,
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: theme.indicatorColor.withOpacity(0.5),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: TextFormField(
                          cursorColor: theme.primaryColor,
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Recipes...',
                            hintStyle: theme.textTheme.bodySmall,
                          ),
                          style: theme.textTheme.bodyMedium,
                          onChanged: (value) => filter.value = value,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Builder(builder: (_) {
              if (filter.value.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Search in 1300+\nMealGuide Recipes!',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'You can search by recipe name,\ningredients or diet plans.',
                        style: theme.textTheme.bodySmall!,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              List<Recipe> filterRecipes = [];
              filterRecipes.addAll(
                recipes.where(
                  (element) => '${element.ingredientsSearch};${element.id}'
                      .toLowerCase()
                      .contains(filter.value.toLowerCase()),
                ),
              );

              if (filterRecipes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No recipes found for "${filter.value}"',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Try refining your search',
                        style: theme.textTheme.bodySmall!,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  mainAxisSpacing: 2.h,
                  crossAxisSpacing: 2.h,
                  children: List.generate(filterRecipes.length, (index) {
                    Recipe recipe = filterRecipes[index];
                    return DietRecipeBox(recipe: recipe);
                  }),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
