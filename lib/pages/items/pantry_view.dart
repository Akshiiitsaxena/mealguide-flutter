import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/pages/items/item_tile.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:sizer/sizer.dart';

class PantryView extends HookConsumerWidget {
  const PantryView({super.key});

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

    List<IngredientItem> pantryIngredients = addedIngredients
        .where((element) => purchasedItems.contains(element.ingredientId))
        .toList();

    Map<String, List<IngredientItem>> categoryPurchasedIngredients = {};

    for (var item in pantryIngredients) {
      categoryPurchasedIngredients.update(
        item.ingredientComposition.category,
        (value) => [...value, item],
        ifAbsent: () => [item],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: pantryIngredients.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No items in Pantry',
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
                      'You can add more items to the pantry, by moving them from your shopping list',
                      style: theme.textTheme.bodySmall!,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: categoryPurchasedIngredients.length,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemBuilder: ((context, categoryIndex) {
                final categoryPurchasedIngredientIds =
                    categoryPurchasedIngredients.values
                        .toList()[categoryIndex]
                        .map((e) => e.ingredientId);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryPurchasedIngredients.keys
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
                        itemCount: categoryPurchasedIngredients.values
                            .toList()[categoryIndex]
                            .length,
                        itemBuilder: (context, ingredientIndex) {
                          IngredientItem item = categoryPurchasedIngredients
                              .values
                              .toList()[categoryIndex][ingredientIndex];

                          return ItemTile(
                            id: item.ingredientId,
                            name: item.ingredientComposition.name,
                            isLast: ingredientIndex ==
                                categoryPurchasedIngredients.values
                                        .toList()[categoryIndex]
                                        .length -
                                    1,
                            isForPantry: true,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              }),
            ),
    );
  }
}
