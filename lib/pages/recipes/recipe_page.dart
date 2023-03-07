import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/keys.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/ingredient_tile.dart';
import 'package:mealguide/pages/recipes/instruction_tile.dart';
import 'package:mealguide/pages/recipes/servings_tile.dart';
import 'package:mealguide/providers/recipe_state_provider.dart';
import 'package:mealguide/providers/tab_provider.dart';
import 'package:mealguide/providers/theme_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';
import 'package:mealguide/providers/viewed_recipes_provider.dart';
import 'package:mealguide/widgets/info_box.dart';
import 'package:sizer/sizer.dart';

class RecipePage extends HookConsumerWidget {
  final Recipe recipe;

  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final quantityNotifier = ref.read(recipeStateNotifierProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        quantityNotifier.setQuantity(recipe.id, recipe.serving.quantity);
        handleViewedRecipes(ref, context);
      });
      return null;
    }, []);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            backgroundColor:
                ref.read(themeStateNotifierProvider).mode == ThemeMode.light
                    ? theme.primaryColor
                    : const Color(0xff393868),
            expandedHeight: 20.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(right: 4.w),
                child: Text(
                  recipe.name,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 2.h),
                recipe.description != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(recipe.description!,
                            style: theme.textTheme.bodySmall!),
                      )
                    : Container(),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 100.w,
                  height: 8.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    children: [
                      InfoBox(
                        heading: 'calories',
                        title: recipe.nutrition.calories.toStringAsFixed(0),
                        trailing: 'kcal',
                      ),
                      SizedBox(width: 4.w),
                      InfoBox(
                        heading: 'total time',
                        title: getTimeString(recipe.time['total']),
                        trailing: 'mins',
                      ),
                      SizedBox(width: 4.w),
                      InfoBox(
                        heading: 'prep time',
                        title: getTimeString(recipe.time['prep']),
                        trailing: 'mins',
                      ),
                      SizedBox(width: 4.w),
                      InfoBox(
                        heading: 'cook time',
                        title: getTimeString(recipe.time['cook']),
                        trailing: 'mins',
                      ),
                    ],
                  ),
                ),
                ServingsTile(recipe: recipe),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
                  child: Text(
                    'INGREDIENTS',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 1.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    recipe.ingredients.length,
                    (ingredientIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          recipe.ingredients[ingredientIndex].component
                                  .isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(4.w, 1.h, 0, 1.h),
                                  child: Text(
                                    recipe
                                        .ingredients[ingredientIndex].component,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                )
                              : SizedBox(height: 1.h),
                          ...List.generate(
                            recipe.ingredients[ingredientIndex].items.length,
                            (itemIndex) {
                              return IngredientTile(
                                recipe.ingredients[ingredientIndex]
                                    .items[itemIndex],
                                recipeId: recipe.id,
                                baseQuantity: recipe.serving.quantity.floor(),
                                index: itemIndex,
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
                  child: Text(
                    'INSTRUCTIONS',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 1.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    recipe.instructions.length,
                    (instructionIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          recipe.instructions[instructionIndex].component
                                  .isNotEmpty
                              ? Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(4.w, 1.h, 0, 1.h),
                                  child: Text(
                                    recipe.instructions[instructionIndex]
                                        .component,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                )
                              : SizedBox(height: 1.h),
                          ...List.generate(
                            recipe.instructions[instructionIndex].steps.length,
                            (stepIndex) {
                              return InstructionTile(
                                  content: recipe.instructions[instructionIndex]
                                      .steps[stepIndex],
                                  step: stepIndex);
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  child: Text(
                    'NUTRITION (PER SERVING)',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 8.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 4.w),
                    children: List.generate(
                      recipe.nutrition.getMap.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: InfoBox(
                          heading: recipe.nutrition.getMap.keys.toList()[index],
                          title: recipe.nutrition.getMap.values.toList()[index]
                              ['amount'],
                          trailing: recipe.nutrition.getMap.values
                              .toList()[index]['unit'],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleViewedRecipes(WidgetRef ref, BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final hasPremium = ref.read(userStateNotifierProvider).hasPremium;

    if (!hasPremium) {
      final viewedRecipes = ref.read(viewedRecipeNotifierProvider).viewed;
      if (viewedRecipes <= Keys.maxViewedRecipes) {
        ref.read(viewedRecipeNotifierProvider.notifier).addViewedRecipes();
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        ref.read(tabControllerProvider).goToTab(tab: 4);
      }
    }
  }
}

String getTimeString(Map<String, dynamic> recipeTime) =>
    recipeTime['lower'] == recipeTime['upper']
        ? recipeTime['lower'].toString()
        : '${recipeTime['lower']} - ${recipeTime['upper']}';
