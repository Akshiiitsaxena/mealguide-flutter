import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/diet_recipe_box.dart';
import 'package:mealguide/providers/recipe_type_state_provider.dart';
import 'package:sizer/sizer.dart';

class DietRecipesPage extends HookConsumerWidget {
  final Diet diet;
  final List<Recipe> recipes;

  const DietRecipesPage({
    super.key,
    required this.diet,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeWatcher = ref.watch(recipeTypeStateNotifierProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref
            .read(recipeTypeStateNotifierProvider.notifier)
            .setCurrentType(RecipeType.breakfast),
      );
      return null;
    }, []);

    List<Recipe> dietRecipes =
        recipes.where((recipe) => recipe.category == typeWatcher.type).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverToBoxAdapter(
            child: Container(
              height: 20.h,
              width: 50.w,
              color: Colors.red,
            ),
          ),
          SliverPersistentHeader(pinned: true, delegate: RanClass()),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 4 / 5,
              mainAxisSpacing: 2.h,
              crossAxisSpacing: 2.h,
              children: List.generate(dietRecipes.length, (index) {
                Recipe recipe = dietRecipes[index];
                return DietRecipeBox(recipe: recipe);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class RanClass extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        alignment: Alignment.center,
        height: 10.h,
        child: Consumer(
          builder: (context, ref, child) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => ref
                        .read(recipeTypeStateNotifierProvider.notifier)
                        .setCurrentType(RecipeType.breakfast),
                    child: const Text('breakfast'),
                  ),
                  InkWell(
                    onTap: () => ref
                        .read(recipeTypeStateNotifierProvider.notifier)
                        .setCurrentType(RecipeType.lunch),
                    child: const Text('lunch'),
                  ),
                  InkWell(
                    onTap: () => ref
                        .read(recipeTypeStateNotifierProvider.notifier)
                        .setCurrentType(RecipeType.snacks),
                    child: const Text('snacks'),
                  ),
                  InkWell(
                    onTap: () => ref
                        .read(recipeTypeStateNotifierProvider.notifier)
                        .setCurrentType(RecipeType.dinner),
                    child: const Text('dinner'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 10.h;

  @override
  double get minExtent => 10.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
