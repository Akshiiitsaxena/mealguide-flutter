import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class UserState {
  final bool isLoggedIn;

  const UserState({required this.isLoggedIn});

  UserState copyWith({bool? isLoggedIn}) {
    return UserState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }

  User? get getUser {
    return FirebaseAuth.instance.currentUser;
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  final Ref ref;

  UserStateNotifier(this.ref)
      : super(
          UserState(isLoggedIn: FirebaseAuth.instance.currentUser != null),
        );

  void setLoginState(bool value) {
    state = state.copyWith(isLoggedIn: value);
  }
}

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(ref),
);
