import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/providers/dio_provider.dart';
import 'package:mealguide/providers/otp_state_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';

final authProvider = Provider(
  (ref) => Authentication(
    ref,
    FirebaseAuth.instance,
    ref.read(otpStateNotifierProvider.notifier),
  ),
);

class Authentication {
  final ProviderRef ref;
  final FirebaseAuth auth;
  final OtpStateNotifier otpStateNotifier;

  Authentication(this.ref, this.auth, this.otpStateNotifier);

  Future<void> requestOtp({required String number, int? resendToken}) async {
    otpStateNotifier.setVerificationFailedReason('');
    otpStateNotifier.setOtp('');
    otpStateNotifier.setResendToken(-1);
    otpStateNotifier.setVerificationId('');

    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: handleCodeAutomatically,
      verificationFailed: verificationFailed,
      codeSent: receivedCodeOnPhone,
      codeAutoRetrievalTimeout: (_) {},
      forceResendingToken: resendToken,
    );
  }

  void handleCodeAutomatically(PhoneAuthCredential credential) async {
    otpStateNotifier.setOtp(credential.smsCode!);
  }

  void verificationFailed(FirebaseAuthException authException) {
    String errorMsg;

    switch (authException.code) {
      case 'too-many-requests':
        errorMsg =
            'You seem to have requested an OTP too many times, please try again later';
        break;
      case 'invalid-verification-id':
        errorMsg =
            'Please make sure the SIM of the number you entered is in this device';
        break;
      default:
        errorMsg = 'Please check the OTP you have entered or try again later';
    }

    print(authException.code);
    otpStateNotifier.setHasVerificationFailed(true);
    otpStateNotifier.setCodeSent(false);
    otpStateNotifier.setVerificationFailedReason(errorMsg);
  }

  void receivedCodeOnPhone(String verificationId, int? resendToken) {
    otpStateNotifier.setVerificationId(verificationId);
    if (resendToken != null) {
      otpStateNotifier.setResendToken(resendToken);
    }
  }

  Future<void> signInWithOtp() async {
    // ref.read(otpStateNotifierProvider.notifier).clearSettings();
    final otpState = ref.read(otpStateNotifierProvider);

    final smsCode = otpState.otp;
    final verId = otpState.verificationId;
    final credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);

    await signInUser(credential);
  }

  void resendOtp({required String number}) {
    final otpState = ref.read(otpStateNotifierProvider);
    int? resendToken = otpState.resendToken != -1 ? otpState.resendToken : null;

    requestOtp(number: number, resendToken: resendToken);
  }

  Future<void> signInUser(AuthCredential credential) async {
    try {
      otpStateNotifier.setIsLoading(true);
      final user = await auth.signInWithCredential(credential);
      ref.read(userStateNotifierProvider.notifier).setLoginState(true);
      otpStateNotifier.setIsSuccess(true);
    } on FirebaseAuthException catch (e) {
      print(e);
      verificationFailed(e);
    } finally {
      otpStateNotifier.setIsLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        String idToken = (await googleAccount.authentication).idToken!;
        final credential = GoogleAuthProvider.credential(idToken: idToken);
        await linkCredential(credential);
        // Sync user name/email
        final name = googleAccount.displayName;
        final email = googleAccount.email;
        await syncUserState({'name': name, 'email': email});
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> linkCredential(OAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          throw MgException(
              message: "This email has already been linked to the user.");
        case "invalid-credential":
          throw MgException(message: "These credential are not valid.");
        case "credential-already-in-use":
          throw MgException(message: "The account already exists.");
        default:
          throw MgException(message: 'Something went wrong');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      final googleSignIn = GoogleSignIn();
      final isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        googleSignIn.signOut();
      }
      ref.read(userStateNotifierProvider.notifier).setLoginState(false);
    } catch (e) {
      print('error signing out $e');
    }
  }

  Future<void> syncUserState(Map<dynamic, dynamic> data) async {
    try {
      final dio = await ref.watch(dioProvider(true).future);
      final response = await dio.post(MgUrls.userSync, data: data);
      print(response.data);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw MgException(message: e.message, code: e.response?.statusCode);
    } catch (e) {
      debugPrint(e.toString());
      throw MgException();
    }
    ref.refresh(dioProvider(true));
  }

  Future<void> refreshToken() async {
    await FirebaseAuth.instance.currentUser!.getIdToken(true);
  }
}


// email,
//     name,

//     notes,

//     active_diet_plan,
//     age,
//     height,
//     weight,
//     gender,
//     lifestyle,
//     medical_condition,
//     food_preference,
//     increase_intake,
//     allergic_items,
//     goal,

//     water_goal,

//     calories_goal,

//     premium,
//     original_purchase_date