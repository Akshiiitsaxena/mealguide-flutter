import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:sizer/sizer.dart';

class ItemTile extends HookConsumerWidget {
  final String id;
  final String name;
  final String? quantity;

  const ItemTile({
    super.key,
    required this.id,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isPurchased =
        ref.watch(pantryStateNotifierProvider).purchasedItems.contains(id);

    return Row(
      children: [
        InkWell(
          onTap: () => ref
              .read(pantryStateNotifierProvider.notifier)
              .setPurchasedIems(id),
          child: Container(
            height: 3.2.h,
            width: 3.2.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(56),
              color: theme.primaryColor.withOpacity(isPurchased ? 0.5 : 0.1),
              border: Border.all(color: theme.primaryColor),
            ),
            child: isPurchased
                ? Icon(Icons.check,
                    color: theme.scaffoldBackgroundColor, size: 14.sp)
                : Container(),
          ),
        ),
        SizedBox(width: 3.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: theme.textTheme.bodyMedium),
            quantity != null
                ? Text('$quantity grams', style: theme.textTheme.bodySmall)
                : Container(),
          ],
        )
      ],
    );
  }
}
