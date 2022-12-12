import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/items/shopping_list_view.dart';
import 'package:mealguide/providers/pantry_state_provider.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class ItemsPage extends HookConsumerWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final int items =
        ref.watch(pantryStateNotifierProvider).getNumberOfFoodItems;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MgAppBar(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '${items > 0 ? items : ''} Food Items',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: theme.hoverColor,
                indicatorWeight: 3,
                tabs: [
                  Container(
                    padding: EdgeInsets.only(top: 1.6.h, bottom: 0.7.h),
                    child: Text(
                      'Shopping List',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.grey.shade200),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 1.2.h, bottom: 0.7.h),
                    child: Text(
                      'Pantry Storage',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.grey.shade200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ShoppingListView(),
            Container(),
          ],
        ),
      ),
    );
  }
}
