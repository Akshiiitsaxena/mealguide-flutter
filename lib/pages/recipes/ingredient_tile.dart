import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/providers/recipe_state_provider.dart';
import 'package:sizer/sizer.dart';

class IngredientTile extends HookConsumerWidget {
  final IngredientItem ingredientItem;
  final String recipeId;
  final int baseQuantity;
  final int index;

  const IngredientTile(
    this.ingredientItem, {
    super.key,
    required this.recipeId,
    required this.baseQuantity,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final recipeQuantityWatcher = ref.watch(recipeStateNotifierProvider);
    final pantryStateWatcher = ref.watch(pantryStateNotifierProvider);

    String ingredientQuantity = '';
    double? qty;

    if (ingredientItem.quantity != null) {
      if (recipeQuantityWatcher.servingQuantity.containsKey(recipeId)) {
        qty = ((ingredientItem.quantity! / baseQuantity) *
            recipeQuantityWatcher.servingQuantity[recipeId]!.toDouble());
      } else {
        qty = ingredientItem.quantity!;
      }

      if (qty.toFraction().isFractionGlyph) {
        ingredientQuantity = qty.toFraction().toStringAsGlyph();
      } else {
        if (qty.toMixedFraction().fractionalPart.isFractionGlyph) {
          ingredientQuantity = qty.toMixedFraction().toStringAsGlyph();
        } else {
          ingredientQuantity = qty.toStringAsFixed(0);
        }
      }
    }

    bool isAdded = pantryStateWatcher.items.containsKey(recipeId) &&
        pantryStateWatcher.items[recipeId]!.contains(ingredientItem);

    return InkWell(
      onTap: () => ref
          .read(pantryStateNotifierProvider.notifier)
          .setIngredients(recipeId, ingredientItem, qty),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 3.w),
        padding: EdgeInsets.symmetric(vertical: 1.25.h, horizontal: 3.w),
        decoration: BoxDecoration(
          color: index.isEven
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ingredientItem.quantity != null
                ? Text(
                    '($ingredientQuantity ${ingredientItem.ingredientComposition.unit})',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.indicatorColor,
                    ),
                  )
                : Container(),
            SizedBox(width: 1.w),
            Expanded(
              child: Text(
                ingredientItem.description?.toLowerCase() ??
                    ingredientItem.ingredientComposition.name.toLowerCase(),
                style: theme.textTheme.bodySmall,
              ),
            ),
            Container(
              height: 2.h,
              width: 2.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: theme.primaryColor),
                borderRadius: BorderRadius.circular(56),
                color: isAdded ? theme.primaryColor : Colors.transparent,
              ),
              child: isAdded
                  ? Icon(
                      Icons.check,
                      color: theme.scaffoldBackgroundColor,
                      size: 10.sp,
                    )
                  : Icon(
                      Icons.add,
                      color: theme.primaryColor,
                      size: 10.sp,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
