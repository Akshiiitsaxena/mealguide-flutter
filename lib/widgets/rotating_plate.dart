import 'package:flutter/material.dart';

class RotatingPlate extends StatefulWidget {
  final String image;
  final double size;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const RotatingPlate(
    this.image, {
    required this.size,
    super.key,
    this.left,
    this.right,
    this.bottom,
    this.top,
  });

  @override
  State<RotatingPlate> createState() => _RotatingPlateState();
}

class _RotatingPlateState extends State<RotatingPlate>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
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
    return Positioned(
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      top: widget.top,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, __) => Transform.rotate(
          angle: animation.value,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 4,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Image.asset(
              widget.image,
              height: widget.size,
              width: widget.size,
            ),
          ),
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
