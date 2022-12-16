import 'package:flutter/material.dart';
import 'package:mealguide/models/diet_model.dart';
import 'package:mealguide/widgets/secondary_button.dart';
import 'package:sizer/sizer.dart';

class DietBox extends StatefulWidget {
  final Diet diet;
  final int recipes;
  final bool isForHome;

  const DietBox({
    super.key,
    required this.diet,
    required this.recipes,
    this.isForHome = false,
  });

  @override
  State<DietBox> createState() => _DietBoxState();
}

class _DietBoxState extends State<DietBox> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    );
    animation = Tween<double>(
      begin: 0,
      end: 12.5664,
    ).animate(animationController);

    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.canvasColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        height: 18.h,
        width: 100.w,
        child: Stack(
          children: [
            Container(
              width: 50.w,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isForHome
                        ? 'Your Assigned Plan'
                        : '${widget.recipes}+ delicious recipes',
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    widget.diet.getDisplayName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  MgSecondaryButton('View Dietary Guidelines', onTap: () {})
                ],
              ),
            ),
            Positioned(
              right: -8.w,
              top: 1.h,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, __) => Transform.rotate(
                  angle: animation.value,
                  child: Image.asset(
                    widget.diet.getImage,
                    height: 16.h,
                    width: 16.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
