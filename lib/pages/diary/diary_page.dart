import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/diary/calendar_row.dart';
import 'package:mealguide/widgets/mg_bar.dart';

class DiaryPage extends HookConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: MgAppBar(
        child: CalendarRow(),
      ),
    );
  }
}
