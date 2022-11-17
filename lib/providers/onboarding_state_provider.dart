import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OnboardingQuizState {
  final int currentStep;
  final bool hasSelected;
  final int currentSelection;

  const OnboardingQuizState({
    this.currentStep = 0,
    this.hasSelected = false,
    this.currentSelection = -1,
  });

  OnboardingQuizState copyWith({
    int? currentStep,
    bool? hasSelected,
    int? currentSelection,
  }) {
    return OnboardingQuizState(
      currentStep: currentStep ?? this.currentStep,
      hasSelected: hasSelected ?? this.hasSelected,
      currentSelection: currentSelection ?? this.currentSelection,
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
}

final onboardingQuizStateNotifierProvider =
    StateNotifierProvider<OnboardingQuizStateNotifier, OnboardingQuizState>(
  (ref) => OnboardingQuizStateNotifier(),
);
