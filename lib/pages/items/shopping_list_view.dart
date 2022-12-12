import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/pages/items/item_tile.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:sizer/sizer.dart';

class ShoppingListView extends HookConsumerWidget {
  const ShoppingListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pantryState = ref.watch(pantryStateNotifierProvider);
    final purchasedItems =
        ref.watch(pantryStateNotifierProvider).purchasedItems;

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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: categoryIngredients.isEmpty ||
              !(addedIngredients.any(
                (element) => !purchasedItems.contains(element.ingredientId),
              ))
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      'You can add more food items to the shopping list from the recipes',
                      style: theme.textTheme.bodySmall!,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: categoryIngredients.length,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemBuilder: ((context, categoryIndex) {
                final categoryIngredientIds = categoryIngredients.values
                    .toList()[categoryIndex]
                    .map((e) => e.ingredientId);

                if (categoryIngredientIds
                    .any((element) => !purchasedItems.contains(element))) {
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

                            if (purchasedItems.contains(item.ingredientId)) {
                              return Container();
                            }

                            return ItemTile(
                              id: item.ingredientId,
                              name: item.ingredientComposition.name,
                              quantity: getQuantity(addedQuantity, item),
                              isLast: ingredientIndex ==
                                  categoryIngredients.values
                                          .toList()[categoryIndex]
                                          .length -
                                      1,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  );
                }
                return Container();
              }),
            ),
    );
  }

  String? getQuantity(Map<String, double> addedQuantity, IngredientItem item) =>
      addedQuantity.containsKey(item.ingredientId)
          ? (addedQuantity[item.ingredientId]! /
                  item.ingredientComposition.quantity *
                  item.ingredientComposition.servingWeight)
              .toStringAsFixed(0)
          : null;
}
