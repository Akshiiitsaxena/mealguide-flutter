import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mealguide/models/recipe_model.dart';
import 'package:mealguide/pages/recipes/recipe_page.dart';
import 'package:sizer/sizer.dart';

class DietRecipeBox extends StatelessWidget {
  const DietRecipeBox({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: CachedNetworkImage(
              imageUrl: recipe.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RecipePage(recipe: recipe)),
          ),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.getCalories,
                  style: theme.textTheme.labelLarge
                      ?.copyWith(color: Colors.white70),
                ),
                Text(
                  recipe.name,
                  style:
                      theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
