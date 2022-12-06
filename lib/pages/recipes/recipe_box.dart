import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/recipe_page.dart';
import 'package:mealguide/theme/mg_shadows.dart';
import 'package:sizer/sizer.dart';

class RecipeBox extends StatelessWidget {
  const RecipeBox({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RecipePage(recipe: recipe)),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          width: 35.w,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: mgShadow,
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28)),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.getCalories,
                      style: theme.textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(recipe.name, style: theme.textTheme.bodyMedium),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
