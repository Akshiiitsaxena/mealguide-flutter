import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/models/user_diary_states.dart';
import 'package:mealguide/pages/diary/diary_booked_slot_page.dart';
import 'package:mealguide/pages/diary/diary_mealplan_page.dart';
import 'package:mealguide/pages/diary/diary_no_slot_page.dart';
import 'package:mealguide/providers/user_diary_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';
import 'package:sizer/sizer.dart';

class DiaryPage extends HookConsumerWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDiaryState = ref.watch(userStateNotifierProvider).diaryState;
    final userDiaryWatcher = ref.watch(userDiaryProvider);
    final theme = Theme.of(context);

    useEffect(() {
      ref.refresh(userDiaryProvider);
      return null;
    }, []);

    return userDiaryWatcher.when(
      data: (data) {
        switch (userDiaryState) {
          case UserDiaryState.hasMealPlan:
            final diary = data['diary'];
            return DiaryMealPlanPage(diary: diary);
          case UserDiaryState.hasBookedSlot:
            final slot = data['slot'];
            return DiaryBookedSlotpage(slot: slot);
          case UserDiaryState.noUpcomingSlot:
            return const DiaryNoSlotPage();
          case UserDiaryState.mockPlan:
            final mockDiary = data['mock'];
            return DiaryMealPlanPage(diary: mockDiary, isMock: true);
          default:
            return Container();
        }
      },
      error: (err, _) {
        return Center(
          child: Text((err as MgException).message ?? 'Something went wrong'),
        );
      },
      loading: () {
        return Container(
          alignment: Alignment.center,
          height: 2.h,
          width: 2.h,
          child: CircularProgressIndicator(color: theme.primaryColor),
        );
      },
    );
  }
}
