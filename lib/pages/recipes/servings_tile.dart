import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/recipe_state_provider.dart';
import 'package:sizer/sizer.dart';

class ServingsTile extends HookConsumerWidget {
  const ServingsTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final quantityNotifier = ref.watch(recipeStateNotifierProvider.notifier);

    final double currentQuantity =
        ref.watch(recipeStateNotifierProvider).servingQuantity[recipe.id] ??
            recipe.serving.quantity;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: theme.canvasColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (currentQuantity.floor() >= 2) {
                quantityNotifier.setQuantity(recipe.id, currentQuantity - 1);
              }
            },
            child: Text(
              'SERVINGS',
              style: theme.textTheme.bodySmall,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              buildChangeBox(
                () {
                  if (currentQuantity.floor() >= 2) {
                    quantityNotifier.setQuantity(
                        recipe.id, currentQuantity - 1);
                  }
                },
                theme,
                Icons.remove,
              ),
              SizedBox(width: 4.w),
              Text(currentQuantity.toStringAsFixed(0),
                  style: theme.textTheme.bodyMedium),
              SizedBox(width: 4.w),
              buildChangeBox(
                () {
                  quantityNotifier.setQuantity(recipe.id, currentQuantity + 1);
                },
                theme,
                Icons.add,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget buildChangeBox(Function() onTap, ThemeData theme, IconData icon) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 3.h,
      width: 3.h,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        color: theme.primaryColor,
        size: 14.sp,
      ),
    ),
  );
}
