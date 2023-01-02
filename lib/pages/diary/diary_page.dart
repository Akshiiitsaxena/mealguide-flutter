import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/error_widget.dart';
import 'package:mealguide/pages/diary/calendar_row.dart';
import 'package:mealguide/providers/diary_provider.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:sizer/sizer.dart';

class DiaryPage extends HookConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryWatcher = ref.watch(diaryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: diaryWatcher.when(
        data: (data) {
          return Scaffold(
            appBar: MgAppBar(
              height: 12.h,
              child: CalendarRow(startDate: data.startTime),
            ),
            body: ListView(
              children: [],
            ),
          );
        },
        error: (_, __) => const MgError(
          title: 'Whoops! Something went wrong',
          subtitle: 'Please try again later.',
        ),
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
      ),
    );
  }
}
