import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OtpState {
  final bool isCodeSent;
  final bool hasVerificationFailed;
  final bool isLoading;
  final String error;
  final String otp;
  final String verificationId;
  final int resendToken;

  const OtpState({
    this.isCodeSent = false,
    this.hasVerificationFailed = false,
    this.isLoading = false,
    this.error = '',
    this.otp = '',
    this.verificationId = '',
    this.resendToken = -1,
  });

  OtpState copyWith({
    bool? isCodeSent,
    bool? hasVerificationFailed,
    bool? isLoading,
    String? error,
    String? otp,
    String? verificationId,
    int? resendToken,
  }) {
    return OtpState(
      isCodeSent: isCodeSent ?? this.isCodeSent,
      hasVerificationFailed:
          hasVerificationFailed ?? this.hasVerificationFailed,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
    );
  }
}

class OtpStateNotifier extends StateNotifier<OtpState> {
  OtpStateNotifier() : super(const OtpState());

  void setCodeSent(bool value) {
    state = state.copyWith(isCodeSent: true);
  }

  void setHasVerificationFailed(bool value) {
    state = state.copyWith(hasVerificationFailed: value);
  }

  void setIsLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setVerificationFailedReason(String value) {
    state = state.copyWith(error: value);
  }

  void setResendToken(int value) {
    state = state.copyWith(resendToken: value);
  }

  void setOtp(String value) {
    state = state.copyWith(otp: value);
  }

  void setVerificationId(String value) {
    state = state.copyWith(verificationId: value);
  }
}

final otpStateNotifierProvider =
    StateNotifierProvider<OtpStateNotifier, OtpState>(
  (ref) => OtpStateNotifier(),
);
