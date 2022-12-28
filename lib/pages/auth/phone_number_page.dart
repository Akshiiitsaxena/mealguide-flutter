import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_loading_blur.dart';
import 'package:mealguide/pages/auth/otp_verification_page.dart';
import 'package:mealguide/providers/auth_provider.dart';
import 'package:mealguide/providers/otp_state_provider.dart';
import 'package:mealguide/widgets/mg_bar.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class PhoneNumberPage extends HookConsumerWidget {
  const PhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberController = useTextEditingController();
    final theme = Theme.of(context);

    final isLoading = ref.watch(otpStateNotifierProvider).isLoading;
    final isNumberValid = useState(false);

    return Stack(
      children: [
        Scaffold(
          appBar: MgAppBar(
            height: 10.h,
            child: Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                'Enter your phone number',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Container(
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(160),
                ),
                width: 100.w,
                margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: theme.indicatorColor.withOpacity(0.5),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: TextFormField(
                        cursorColor: theme.primaryColor,
                        controller: numberController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '+XX XXXX XXX XXX',
                          hintStyle: theme.textTheme.bodySmall!,
                        ),
                        keyboardType: TextInputType.phone,
                        style: theme.textTheme.bodyMedium,
                        onChanged: (value) => isNumberValid.value =
                            value.startsWith('+') && value.length > 11,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        'Enter the phone number with the country code\ni.e if the number is from India, type +91 before the number',
                        style: theme.textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              MgPrimaryButton(
                'Get OTP',
                onTap: () {
                  ref
                      .read(authProvider)
                      .requestOtp(number: numberController.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) =>
                          OtpVerificationPage(number: numberController.text)),
                    ),
                  );
                },
                isEnabled: isNumberValid.value,
              ),
              SizedBox(height: 4.h),
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
