import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/providers/dio_provider.dart';

final onboardingProvider =
    FutureProvider<List<OnboardingQuestion>>((ref) async {
  try {
    final response = await ref.watch(dioProvider).get(MgUrls.getQuestionnaire);
    List<OnboardingQuestion> questions = [];

    response.data['data'].forEach((doc) {
      questions.add(OnboardingQuestion.fromDocument(doc));
    });

    return questions;
  } on DioError catch (e) {
    debugPrint(e.message);
    return [];
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
});
