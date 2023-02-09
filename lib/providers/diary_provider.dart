import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/diary_model.dart';
import 'package:mealguide/providers/dio_provider.dart';

final diaryProvider = FutureProvider<Diary>((ref) async {
  try {
    final dio = await ref.watch(dioProvider(true).future);
    final response = await dio.get(MgUrls.getMealPlan);

    if (response.data['data'] == null) {
      throw MgException(code: -1);
    }

    Diary diary = Diary.fromDoc(response.data['data']);
    // Future.delayed(const Duration(seconds: 1));
    // final String diaryJsonString =
    //     await rootBundle.loadString('assets/data/plan.json');
    // final dietsJson = jsonDecode(diaryJsonString);
    // Diary diary = Diary.fromDoc(dietsJson['data'] as Map<String, dynamic>);
    return diary;
  } on DioError catch (e) {
    debugPrint(e.message);
    throw MgException(message: e.message, code: e.response?.statusCode);
  } on MgException {
    rethrow;
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
      final dio = await ref.watch(dioProvider(true).future);
      await dio.post(MgUrls.consumeMeal, data: data);
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
      final dio = await ref.watch(dioProvider(true).future);
      await dio.post(MgUrls.consumeMeal, data: data);
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
