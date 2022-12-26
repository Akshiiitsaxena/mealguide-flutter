import 'package:flutter/material.dart';

class MgError extends StatelessWidget {
  final String title;
  final String subtitle;

  const MgError({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Text(subtitle, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
