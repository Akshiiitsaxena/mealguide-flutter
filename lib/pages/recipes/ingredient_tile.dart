import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/ingredient_model.dart';
import 'package:sizer/sizer.dart';

class IngredientTile extends HookConsumerWidget {
  final IngredientItem ingredientItem;
  final int baseQuantity;
  final int index;

  const IngredientTile(
    this.ingredientItem, {
    super.key,
    required this.baseQuantity,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 3.w),
      padding: EdgeInsets.symmetric(vertical: 1.25.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: index.isEven
            ? theme.primaryColor.withOpacity(0.1)
            : theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ingredientItem.quantity != null
              ? Text(
                  '(${ingredientItem.quantity!.toStringAsFixed(0)} ${ingredientItem.ingredientComposition.unit})',
                  style:
                      theme.textTheme.bodySmall!.copyWith(color: Colors.black),
                )
              : Container(),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              ingredientItem.description?.toLowerCase() ??
                  ingredientItem.ingredientComposition.name.toLowerCase(),
              style: theme.textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
