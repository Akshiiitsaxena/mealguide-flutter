import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/providers/hive_provider.dart';
import 'package:mealguide/providers/notification_provider.dart';

@immutable
class ProfileState {
  final int dailyWater;
  final Map<String, dynamic> notifications;

  const ProfileState({
    required this.dailyWater,
    required this.notifications,
  });

  ProfileState copyWith({
    int? dailyWater,
    Map<String, dynamic>? notifications,
  }) {
    return ProfileState(
      dailyWater: dailyWater ?? this.dailyWater,
      notifications: notifications ?? this.notifications,
    );
  }

  bool get isBreakfastEnabled => notifications['breakfast']['enabled'] ?? false;
  bool get isLunchEnabled => notifications['lunch']['enabled'] ?? false;
  bool get isSnacksEnabled => notifications['snacks']['enabled'] ?? false;
  bool get isDinnerEnabled => notifications['dinner']['enabled'] ?? false;

  TimeOfDay get breakfastTime =>
      notifications['breakfast']['time'] ??
      const TimeOfDay(hour: 8, minute: 30);
  TimeOfDay get lunchTime =>
      notifications['lunch']['time'] ?? const TimeOfDay(hour: 12, minute: 30);
  TimeOfDay get snacksTime =>
      notifications['snacks']['time'] ?? const TimeOfDay(hour: 17, minute: 30);
  TimeOfDay get dinnerTime =>
      notifications['dinner']['time'] ?? const TimeOfDay(hour: 20, minute: 30);
}

class ProfileStateNotifer extends StateNotifier<ProfileState> {
  final Ref ref;

  ProfileStateNotifer(this.ref)
      : super(const ProfileState(
          dailyWater: 8,
          notifications: {
            'breakfast': {},
            'lunch': {},
            'snacks': {},
            'dinner': {},
          },
        ));

  void setDailyWater(int value, {bool initialCall = false}) {
    state = state.copyWith(dailyWater: value);
    if (!initialCall) {
      // TODO: Add method in hive provider
      ref.read(hiveProvider);
    }
  }

  void setNotification(NotificationType notificationType, TimeOfDay time,
      {bool initialCall = false}) {
    String key = notificationType.toString();

    Map<String, dynamic> map = {};
    map.addAll(state.notifications);
    map.update(key, (_) => {'enabled': true, 'time': time});
    state = state.copyWith(notifications: map);
    if (!initialCall) {
      // TODO: Add method in hive provider
      ref.read(hiveProvider);
    }
  }

  void cancelNotification(NotificationType notificationType,
      {bool initialCall = false}) {
    String key = notificationType.toString();

    Map<String, dynamic> map = {};
    map.addAll(state.notifications);
    map.update(key, (_) => {'enabled': false, 'time': null});
    state = state.copyWith(notifications: map);
    if (!initialCall) {
      // TODO: Add method in hive provider
      ref.read(hiveProvider);
    }
  }
}

final profileStateNotiferProvider =
    StateNotifierProvider<ProfileStateNotifer, ProfileState>(
        (ref) => ProfileStateNotifer(ref));
