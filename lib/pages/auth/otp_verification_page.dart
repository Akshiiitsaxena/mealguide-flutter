import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_loading_blur.dart';
import 'package:mealguide/pages/auth/email_verification_page.dart';
import 'package:mealguide/providers/auth_provider.dart';
import 'package:mealguide/providers/otp_state_provider.dart';
import 'package:mealguide/widgets/error_dialog.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OtpVerificationPage extends HookConsumerWidget {
  final String number;
  const OtpVerificationPage({super.key, required this.number});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final otpController = useTextEditingController();

    final otpState = ref.watch(otpStateNotifierProvider);
    final authState = ref.read(authProvider);

    final isLoading = otpState.isLoading;

    ref.listen<OtpState>(
      otpStateNotifierProvider,
      (previousState, nextState) {
        if (previousState!.otp.isEmpty && nextState.otp.isNotEmpty) {
          otpController.text = nextState.otp;
        }

        if (previousState.error.isEmpty && nextState.error.isNotEmpty) {
          otpController.text = '';

          MgErrorDialog.showErrorDialog(
            context,
            title: 'Something went wrong!',
            subtitle: nextState.error,
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                child: Text(
                  'Okay',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.primaryColor),
                ),
              )
            ],
          );
        }

        if (!previousState.isSuccess && nextState.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const EmailVerificationPage(),
            ),
          );
        }
      },
    );

    return Stack(
      children: [
        Scaffold(
          appBar: MgAppBar(
            child: Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter the OTP',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 0.25.h),
                  Text(
                    'sms code has been sent to $number',
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: Colors.grey.shade100),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  length: 6,
                  autoFocus: true,
                  pinTheme: PinTheme(
                    fieldHeight: 12.w,
                    fieldWidth: 12.w,
                    inactiveColor: theme.canvasColor,
                    inactiveFillColor: theme.canvasColor,
                    activeFillColor: theme.primaryColor.withOpacity(0.15),
                    activeColor: theme.primaryColor,
                    selectedColor: theme.primaryColor,
                    selectedFillColor: theme.primaryColor.withOpacity(0.15),
                    shape: PinCodeFieldShape.circle,
                  ),
                  textStyle: TextStyle(fontSize: 18.sp),
                  cursorColor: theme.primaryColor,
                  enableActiveFill: true,
                  autoDismissKeyboard: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter OTP';
                    } else if (value.length != 6) {
                      return 'Enter valid OTP of 6 digits';
                    } else {
                      return null;
                    }
                  },
                  onCompleted: (String otp) async {
                    if (otpController.text.length == 6) {
                      if (otpState.otp.isEmpty) {
                        ref.read(otpStateNotifierProvider.notifier).setOtp(otp);
                      }
                      await authState.signInWithOtp();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => const EmailVerificationPage(),
                      //   ),
                      // );
                      // ignore: use_build_context_synchronously
                      // Navigator.of(context).pop();
                    }
                  },
                  controller: otpController,
                  onChanged: (_) {},
                ),
              ),
              Counter(
                onSend: () => ref.read(authProvider).requestOtp(number: number),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const MgLoadingBlur(),
        ),
      ],
    );
  }
}

class Counter extends StatefulWidget {
  final Function() onSend;
  const Counter({Key? key, required this.onSend}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Timer _timer;
  int _start = 30;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _start == 0
        ? TextButton(
            onPressed: () {
              _start = 30;
              startTimer();
              widget.onSend();
            },
            child: Text(
              'Resend Code',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.primaryColor),
            ),
          )
        : TextButton(
            onPressed: null,
            child: Text('Resend Code in $_start seconds',
                style: theme.textTheme.bodySmall),
          );
  }
}
