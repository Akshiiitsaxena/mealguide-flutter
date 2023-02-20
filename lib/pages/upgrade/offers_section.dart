import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/providers/revenuecat_provider.dart';
import 'package:mealguide/widgets/error_dialog.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:mealguide/widgets/subscription_box.dart';
import 'package:purchases_flutter/models/package_wrapper.dart' as r;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sizer/sizer.dart';

class OfferSection extends HookConsumerWidget {
  const OfferSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenPlan = useState(0);
    final hasError = useState(false);
    final packagesFuture = ref.read(revenueCatProvider).getPackages();
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 3.h),
        FutureBuilder<List<r.Package>>(
          future: packagesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final packages = snapshot.data!;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(packages.length, (index) {
                        final package = packages.elementAt(index);
                        return SubcriptionBox(
                          newPrice: package.storeProduct.priceString,
                          duration: getStringFromType(package.packageType),
                          isSelected: chosenPlan.value == index,
                          onTap: () {
                            chosenPlan.value = index;
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: MgPrimaryButton(
                        'GET STARTED',
                        onTap: () async {
                          try {
                            await ref.read(revenueCatProvider).purchasePackage(
                                packages.elementAt(chosenPlan.value));
                          } on MgException catch (e) {
                            MgErrorDialog.showErrorDialog(
                              context,
                              title: 'Something went wrong',
                              subtitle: e.message ?? '',
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(),
                                  child: Text(
                                    'Okay',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                        isEnabled: !hasError.value,
                        height: 6.h,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              hasError.value = true;
              return Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                alignment: Alignment.center,
                child: Text(
                  snapshot.error.toString(),
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  String getStringFromType(PackageType type) {
    switch (type) {
      case PackageType.monthly:
        return 'Monthly';
      case PackageType.threeMonth:
        return '3 Months';
      case PackageType.sixMonth:
        return '6 Months';
      default:
        return '';
    }
  }
}
