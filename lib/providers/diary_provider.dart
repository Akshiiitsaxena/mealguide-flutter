import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@immutable
class DiaryState {
  final DateTime date;

  const DiaryState(this.date);

  DiaryState copyWith({DateTime? date}) {
    return DiaryState(date ?? this.date);
  }

  get getDateTitle {
    String trailing = DateFormat(', dd MMM').format(date);
    String day;

    if (date.day == DateTime.now().day) {
      day = 'Today';
    } else if (date.day == DateTime.now().add(const Duration(days: 1)).day) {
      day = 'Tomorrow';
    } else {
      day = DateFormat('EEEE').format(date);
    }

    return '$day$trailing';
  }
}

class DiaryStateNotifier extends StateNotifier<DiaryState> {
  DiaryStateNotifier() : super(DiaryState(DateTime.now()));

  void setDate(DateTime dateTime) {
    state = state.copyWith(date: dateTime);
  }
}

final diaryStateNotifierProvider =
    StateNotifierProvider<DiaryStateNotifier, DiaryState>(
  (_) => DiaryStateNotifier(),
);
