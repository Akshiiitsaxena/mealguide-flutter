import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/diary_model.dart';
import 'package:mealguide/providers/dio_provider.dart';

final diaryProvider = FutureProvider<Diary>((ref) async {
  try {
    final response = await ref.watch(dioProvider(true)).get(MgUrls.getMealPlan);

    Diary diary = Diary.fromDoc(response.data['data']);
    return diary;
  } on DioError catch (e) {
    debugPrint(e.message);
    throw MgException(message: e.message);
  } catch (e) {
    debugPrint(e.toString());
    throw MgException();
  }
});
