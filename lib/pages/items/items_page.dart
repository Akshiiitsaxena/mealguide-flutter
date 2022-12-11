import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/pages/items/item_tile.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:sizer/sizer.dart';

class ItemsPage extends HookConsumerWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pantryState = ref.watch(pantryStateNotifierProvider);

    List<IngredientItem> addedIngredients = pantryState.items.values
        .toList()
        .fold<List<IngredientItem>>([], (prev, ele) => [...prev, ...ele])
        .toSet()
        .toList();

    Map<String, double> addedQuantity = pantryState.addedQuantity;
    Map<String, List<IngredientItem>> categoryIngredients = {};

    for (var item in addedIngredients) {
      categoryIngredients.update(
        item.ingredientComposition.category,
        (value) => [...value, item],
        ifAbsent: () => [item],
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: categoryIngredients.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No more food items',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'You can add more food items to the\nshopping list from the recipes',
                      style: theme.textTheme.bodySmall!,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: categoryIngredients.length,
                itemBuilder: ((context, categoryIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryIngredients.keys
                            .toList()[categoryIndex]
                            .toUpperCase(),
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.focusColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 2.h,
                          horizontal: 4.w,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryIngredients.values
                              .toList()[categoryIndex]
                              .length,
                          itemBuilder: (context, ingredientIndex) {
                            IngredientItem item = categoryIngredients.values
                                .toList()[categoryIndex][ingredientIndex];

                            return Column(
                              children: [
                                ItemTile(
                                    id: item.ingredientId,
                                    name: item.ingredientComposition.name,
                                    quantity: addedQuantity
                                            .containsKey(item.ingredientId)
                                        ? (addedQuantity[item.ingredientId]! /
                                                item.ingredientComposition
                                                    .quantity *
                                                item.ingredientComposition
                                                    .servingWeight)
                                            .toStringAsFixed(0)
                                        : null),
                                ingredientIndex ==
                                        categoryIngredients.values
                                                .toList()[categoryIndex]
                                                .length -
                                            1
                                    ? Container()
                                    : Divider(height: 3.h)
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  );
                }),
              ),
      ),
    );
  }
}
