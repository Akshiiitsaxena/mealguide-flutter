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
  final bool isSuccess;

  const OtpState({
    this.isCodeSent = false,
    this.hasVerificationFailed = false,
    this.isLoading = false,
    this.error = '',
    this.otp = '',
    this.verificationId = '',
    this.resendToken = -1,
    this.isSuccess = false,
  });

  OtpState copyWith({
    bool? isCodeSent,
    bool? hasVerificationFailed,
    bool? isLoading,
    String? error,
    String? otp,
    String? verificationId,
    int? resendToken,
    bool? isSuccess,
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
      isSuccess: isSuccess ?? this.isSuccess,
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

  void setIsSuccess(bool value) {
    state = state.copyWith(isSuccess: value);
  }

  void clearSettings() {
    state = state.copyWith(
      isCodeSent: false,
      hasVerificationFailed: false,
      isLoading: false,
      error: '',
      otp: '',
      verificationId: '',
      resendToken: -1,
      isSuccess: false,
    );
  }
}

final otpStateNotifierProvider =
    StateNotifierProvider<OtpStateNotifier, OtpState>(
  (ref) => OtpStateNotifier(),
);
