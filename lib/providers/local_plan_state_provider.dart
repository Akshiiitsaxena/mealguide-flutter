import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class LocalPlanState {
  final String plan;

  const LocalPlanState({required this.plan});

  LocalPlanState copyWith({String? plan}) {
    return LocalPlanState(plan: plan ?? this.plan);
  }
}

class LocalPlanStateNotifier extends StateNotifier<LocalPlanState> {
  final Ref ref;

  LocalPlanStateNotifier(this.ref) : super(const LocalPlanState(plan: ''));

  void setPlan(String plan) {
    state = state.copyWith(plan: plan);
  }
}

final localPlanNotifierProvider =
    StateNotifierProvider<LocalPlanStateNotifier, LocalPlanState>(
  (ref) => LocalPlanStateNotifier(ref),
);
