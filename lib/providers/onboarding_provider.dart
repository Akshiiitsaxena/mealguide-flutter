import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/onboarding_model.dart';
import 'package:mealguide/providers/dio_provider.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:mealguide/providers/onboarding_state_provider.dart';

final onboardingQuestionProvider = FutureProvider<List<OnboardingQuestion>>(
  (ref) async {
    try {
      final dio = await ref.watch(dioProvider(false).future);
      final response = await dio.get(MgUrls.getQuestionnaire);
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
  },
);

final onboardingAnswerProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>(
  (ref) async {
    try {
      final dio = await ref.watch(dioProvider(false).future);
      final answers = ref.read(onboardingQuizStateNotifierProvider).answers;
      // final answers = {
      //   "goal": "Lose Weight",
      //   "gender": "Male",
      //   "age": 23,
      //   "height": 173,
      //   "weight": 85,
      //   "lifestyle": "Very Active",
      //   "medical_condition": "None",
      //   "food_preference": "None",
      //   "increase_intake": "Protein",
      //   "allergic": ["shellfish"]
      // };

      final response = await dio.post(MgUrls.submitQuestionnair, data: answers);
      ref.read(hiveProvider).setOnboardingAnswers(answers);
      ref.read(hiveProvider).setCalorieGoal(response.data['data']['calories']);
      return response.data['data'];
    } on DioError catch (e) {
      if (e.response != null && e.response!.data is Map) {
        throw MgException(message: e.response!.data['message']);
      }
      throw MgException(message: 'Something went wrong');
    } catch (e) {
      debugPrint(e.toString());
      throw MgException();
    }
  },
);
