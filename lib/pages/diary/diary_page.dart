import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/pages/diary/calendar_row.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class DiaryPage extends HookConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MgAppBar(
        height: 12.h,
        child: const CalendarRow(),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
