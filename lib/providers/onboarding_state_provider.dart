import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OnboardingQuizState {
  final int currentStep;
  final bool hasSelected;
  final int currentSelection;
  final Map<String, dynamic> answers;

  const OnboardingQuizState({
    this.currentStep = 0,
    this.hasSelected = false,
    this.currentSelection = -1,
    this.answers = const {},
  });

  OnboardingQuizState copyWith({
    int? currentStep,
    bool? hasSelected,
    int? currentSelection,
    Map<String, dynamic>? answers,
  }) {
    return OnboardingQuizState(
      currentStep: currentStep ?? this.currentStep,
      hasSelected: hasSelected ?? this.hasSelected,
      currentSelection: currentSelection ?? this.currentSelection,
      answers: answers ?? this.answers,
    );
  }
}

class OnboardingQuizStateNotifier extends StateNotifier<OnboardingQuizState> {
  OnboardingQuizStateNotifier() : super(const OnboardingQuizState());

  void setCurrentStep(int value) {
    state = state.copyWith(currentStep: value);
  }

  void setHasSelected(bool value) {
    state = state.copyWith(hasSelected: value);
  }

  void setCurrentSelection(int value) {
    state = state.copyWith(currentSelection: value);
  }

  void setAnswers(String key, dynamic val) {
    Map<String, dynamic> tempMap = {};
    tempMap.addAll(state.answers);
    tempMap.update(
      key,
      (value) => val,
      ifAbsent: () => val,
    );

    state = state.copyWith(answers: tempMap);
  }

  void clearAnswers() {
    state = state.copyWith(answers: {});
  }
}

final onboardingQuizStateNotifierProvider =
    StateNotifierProvider<OnboardingQuizStateNotifier, OnboardingQuizState>(
  (ref) => OnboardingQuizStateNotifier(),
);
