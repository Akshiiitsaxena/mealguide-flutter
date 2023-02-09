import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/models/user_diary_states.dart';
import 'package:mealguide/providers/diary_provider.dart';
import 'package:mealguide/providers/slot_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';

final userDiaryProvider = FutureProvider<Map<String, dynamic>>(
  (ref) async {
    Map<String, dynamic> data = {};
    final userDiaryStateNotifier = ref.read(userStateNotifierProvider.notifier);
    try {
      final diary = await ref.read(diaryProvider.future);
      data['diary'] = diary;
      userDiaryStateNotifier.setDiaryState(UserDiaryState.hasMealPlan);
      return data;
    } on MgException catch (e) {
      if (e.code == -1) {
        try {
          final slot = await ref.read(slotProvider).getBookedSlot();
          data['slot'] = slot;
          userDiaryStateNotifier.setDiaryState(UserDiaryState.hasBookedSlot);
          return data;
        } on MgException catch (es) {
          if (es.code == -2) {
            userDiaryStateNotifier.setDiaryState(UserDiaryState.noUpcomingSlot);
            return data;
          } else {
            rethrow;
          }
        }
      } else {
        rethrow;
      }
    }
  },
);
