import 'package:flutter/material.dart';

class MgErrorDialog {
  static showErrorDialog(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> actions,
  }) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(title, style: theme.textTheme.titleMedium),
          content: Text(subtitle, style: theme.textTheme.bodySmall),
          actions: actions,
        );
      },
    );
  }
}
