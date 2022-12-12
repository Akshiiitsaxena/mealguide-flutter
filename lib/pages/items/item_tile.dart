import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:sizer/sizer.dart';

class ItemTile extends HookConsumerWidget {
  final String id;
  final String name;
  final String? quantity;
  final bool isLast;

  const ItemTile({
    super.key,
    required this.id,
    required this.name,
    required this.quantity,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isTicked = useState(false);

    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () async {
                isTicked.value = true;
                await Future.delayed(const Duration(seconds: 1));
                ref
                    .read(pantryStateNotifierProvider.notifier)
                    .setPurchasedIems(id);
              },
              child: Container(
                height: 3.2.h,
                width: 3.2.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56),
                  color: theme.primaryColor
                      .withOpacity(isTicked.value ? 0.5 : 0.1),
                  border: Border.all(color: theme.primaryColor),
                ),
                child: isTicked.value
                    ? Icon(Icons.check, color: Colors.white70, size: 14.sp)
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
        ),
        isLast ? Container() : Divider(height: 3.h)
      ],
    );
  }
}
