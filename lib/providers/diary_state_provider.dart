import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@immutable
class DiaryState {
  final DateTime date;
  final int dailyWater;

  const DiaryState({required this.date, required this.dailyWater});

  DiaryState copyWith({
    DateTime? date,
    int? dailyWater,
  }) {
    return DiaryState(
      date: date ?? this.date,
      dailyWater: dailyWater ?? this.dailyWater,
    );
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
  DiaryStateNotifier() : super(DiaryState(date: DateTime.now(), dailyWater: 8));

  void setDate(DateTime dateTime) {
    state = state.copyWith(date: dateTime);
  }

  void setDailyWater(int value) {
    if (value <= 18 && value >= 4) {
      state = state.copyWith(dailyWater: value);
    }
  }
}

final diaryStateNotifierProvider =
    StateNotifierProvider<DiaryStateNotifier, DiaryState>(
  (_) => DiaryStateNotifier(),
);
