import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/models/diary_model.dart';
import 'package:mealguide/models/user_diary_states.dart';
import 'package:mealguide/providers/diary_provider.dart';
import 'package:mealguide/providers/slot_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';

final userDiaryProvider = FutureProvider<Map<String, dynamic>>(
  (ref) async {
    Map<String, dynamic> data = {};
    final userDiaryStateNotifier = ref.read(userStateNotifierProvider.notifier);
    final hasPremium = ref.read(userStateNotifierProvider).hasPremium;

    if (!hasPremium) {
      final String mockDiaryJsonString =
          await rootBundle.loadString('assets/data/plan.json');
      final mockJson = jsonDecode(mockDiaryJsonString);
      final mockDiary = Diary.fromDoc(mockJson['data'] as Map<String, dynamic>)
        ..setCustomStartTime = DateTime.now();
      data['mock'] = mockDiary;
      userDiaryStateNotifier.setDiaryState(UserDiaryState.mockPlan);
      return data;
    } else {
      try {
        final diary = await ref.watch(diaryProvider.future);
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
              userDiaryStateNotifier
                  .setDiaryState(UserDiaryState.noUpcomingSlot);
              return data;
            } else {
              rethrow;
            }
          }
        } else {
          rethrow;
        }
      }
    }
  },
);
