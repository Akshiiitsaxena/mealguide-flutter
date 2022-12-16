import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/category_tabs.dart';
import 'package:mealguide/pages/recipes/diet_recipe_box.dart';
import 'package:mealguide/providers/recipe_type_state_provider.dart';
import 'package:mealguide/widgets/diet_box.dart';
import 'package:mealguide/widgets/mg_bar.dart';
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
    final controller = useScrollController();

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
      appBar: MgAppBar(
        isEmpty: true,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 2.h),
            sliver: SliverToBoxAdapter(
              child: DietBox(diet: diet, recipes: recipes.length),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: CategoryTabs(
              recipeType: typeWatcher.type,
              onChanged: () => controller.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
