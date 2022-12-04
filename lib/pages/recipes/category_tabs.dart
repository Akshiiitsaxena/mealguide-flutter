import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/providers/recipe_type_state_provider.dart';
import 'package:mealguide/theme/mg_shadows.dart';
import 'package:sizer/sizer.dart';

class CategoryTabs extends SliverPersistentHeaderDelegate {
  final RecipeType recipeType;
  final Function() onChanged;

  CategoryTabs({required this.recipeType, required this.onChanged});

  List<String> types = ['breakfast', 'lunch', 'snacks', 'dinner'];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ThemeData theme = Theme.of(context);

    return Align(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.focusColor,
          borderRadius: BorderRadius.circular(250),
          boxShadow: mgShadow,
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        height: 8.h,
        child: Consumer(
          builder: (context, ref, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: List.generate(types.length, (index) {
                  RecipeType currType;

                  switch (types[index]) {
                    case 'breakfast':
                      currType = RecipeType.breakfast;
                      break;
                    case 'lunch':
                      currType = RecipeType.lunch;
                      break;
                    case 'snacks':
                      currType = RecipeType.snacks;
                      break;
                    case 'dinner':
                      currType = RecipeType.dinner;
                      break;
                    default:
                      currType = RecipeType.breakfast;
                  }

                  bool isSelected = recipeType == currType;

                  return InkWell(
                    onTap: () {
                      ref
                          .read(recipeTypeStateNotifierProvider.notifier)
                          .setCurrentType(currType);
                      onChanged();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 0.75.h),
                        Text(
                          types[index],
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: isSelected
                                ? theme.primaryColor
                                : theme.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeIn,
                          height: 0.2.h,
                          width: isSelected ? 6.w : 0,
                          color: theme.primaryColor,
                        )
                      ],
                    ),
                  );
                }),

                // children: [
                //   InkWell(
                //     onTap: () {
                //       ref
                //           .read(recipeTypeStateNotifierProvider.notifier)
                //           .setCurrentType(RecipeType.breakfast);
                //       onChanged();
                //     },
                //     child: Column(
                //       children: [
                //         Text(
                //           'breakfast',
                // style: TextStyle(
                //   color: recipeType == RecipeType.breakfast
                //       ? Colors.white
                //       : Colors.grey,
                // ),
                //         ),
                //         Container(
                //           height: 1.h,
                //           width: 5.w,
                //           color: Colors.white,
                //         )
                //       ],
                //     ),
                //   ),
                //   InkWell(
                //     onTap: () {
                //       ref
                //           .read(recipeTypeStateNotifierProvider.notifier)
                //           .setCurrentType(RecipeType.lunch);
                //       onChanged();
                //     },
                //     child: Text(
                //       'lunch',
                //       style: TextStyle(
                //         color: recipeType == RecipeType.lunch
                //             ? Colors.white
                //             : Colors.grey,
                //       ),
                //     ),
                //   ),
                //   InkWell(
                //     onTap: () {
                //       ref
                //           .read(recipeTypeStateNotifierProvider.notifier)
                //           .setCurrentType(RecipeType.snacks);
                //       onChanged();
                //     },
                //     child: Text(
                //       'snacks',
                //       style: TextStyle(
                //         color: recipeType == RecipeType.snacks
                //             ? Colors.white
                //             : Colors.grey,
                //       ),
                //     ),
                //   ),
                //   InkWell(
                //     onTap: () {
                //       ref
                //           .read(recipeTypeStateNotifierProvider.notifier)
                //           .setCurrentType(RecipeType.dinner);
                //       onChanged();
                //     },
                //     child: Text(
                //       'dinner',
                //       style: TextStyle(
                //         color: recipeType == RecipeType.dinner
                //             ? Colors.white
                //             : Colors.grey,
                //       ),
                //     ),
                //   ),
                // ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 8.h;

  @override
  double get minExtent => 8.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
