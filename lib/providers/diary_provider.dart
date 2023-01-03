import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/diary_model.dart';
import 'package:mealguide/providers/dio_provider.dart';
import 'package:mealguide/providers/dummy_plan.dart';

final diaryProvider = FutureProvider<Diary>((ref) async {
  try {
    // final response = await ref.watch(dioProvider(true)).get(MgUrls.getMealPlan);
    // Diary diary = Diary.fromDoc(response.data['data']);
    Future.delayed(const Duration(seconds: 1));
    Diary diary = Diary.fromDoc(json_plan['data'] as Map<String, dynamic>);
    return diary;
  } on DioError catch (e) {
    debugPrint(e.message);
    throw MgException(message: e.message);
  } catch (e) {
    debugPrint(e.toString());
    throw MgException();
  }
});

final planConsumeProvider = Provider((ref) => PlanConsumer(ref));

class PlanConsumer {
  final ProviderRef ref;

  PlanConsumer(this.ref);

  Future<bool> consumeMeal({
    required String planId,
    required String mealId,
  }) async {
    final data = {
      "plan_id": planId,
      "meal_id": mealId,
    };

    try {
      await ref.watch(dioProvider(true)).post(MgUrls.consumeMeal, data: data);
      return true;
    } on DioError catch (e) {
      debugPrint(e.message);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> consumeWater({
    required String planId,
    required String dayPlanId,
    required int waterConsumed,
  }) async {
    final data = {
      "plan_id": planId,
      "day_plan_id": dayPlanId,
      "water_consumed": waterConsumed,
    };

    try {
      await ref.watch(dioProvider(true)).post(MgUrls.consumeMeal, data: data);
      return true;
    } on DioError catch (e) {
      debugPrint(e.message);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
