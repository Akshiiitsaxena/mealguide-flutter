import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/user_diary_states.dart';

@immutable
class UserState {
  final bool isLoggedIn;
  final bool hasPremium;
  final UserDiaryState diaryState;

  const UserState({
    required this.isLoggedIn,
    required this.diaryState,
    required this.hasPremium,
  });

  UserState copyWith({
    bool? isLoggedIn,
    UserDiaryState? diaryState,
    bool? hasPremium,
  }) {
    return UserState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      diaryState: diaryState ?? this.diaryState,
      hasPremium: hasPremium ?? this.hasPremium,
    );
  }

  User? get getUser {
    return FirebaseAuth.instance.currentUser;
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  final Ref ref;

  UserStateNotifier(this.ref)
      : super(
          UserState(
            isLoggedIn: FirebaseAuth.instance.currentUser != null,
            diaryState: UserDiaryState.mockPlan,
            hasPremium: false,
          ),
        );

  void setLoginState(bool value) {
    state = state.copyWith(isLoggedIn: value);
  }

  void setDiaryState(UserDiaryState value) {
    state = state.copyWith(diaryState: value);
  }

  void setHasPremium(bool value) {
    state = state.copyWith(hasPremium: value);
  }
}

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(ref),
);
