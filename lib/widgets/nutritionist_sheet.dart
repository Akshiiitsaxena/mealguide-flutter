import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/mg_loading_blur.dart';
import 'package:mealguide/models/call_slot_model.dart';
import 'package:mealguide/providers/slot_provider.dart';
import 'package:mealguide/providers/user_diary_provider.dart';
import 'package:mealguide/widgets/error_dialog.dart';
import 'package:mealguide/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class NutritionistSheet extends HookConsumerWidget {
  const NutritionistSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedTime = useState(0);
    final selectedSlotId = useState('');
    final isLoading = useState(false);

    final availableSlotWatcher = ref.watch(availableSlotProvider);

    return availableSlotWatcher.when(
      data: (slots) {
        slots.sort((a, b) =>
            a.start.millisecondsSinceEpoch - b.start.millisecondsSinceEpoch);
        Map<int, List<CallSlotTime>> dayWiseSlots = {};

        for (var slot in slots) {
          dayWiseSlots.update(
            slot.start.day,
            (value) => [...value, slot],
            ifAbsent: () => [slot],
          );
        }

        final dayFormatter = DateFormat('EEEE, d MMM');
        final slotFormatter = DateFormat('jm');

        return SizedBox(
          height: 80.h,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Nutritionist Connect',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Our nutritionist has carefully created your personalised meal plan!\n\nIf you have any doubts or need to get any changes made, schedule another call with the nutritionist today. Select a suitable time from the available slots below',
                    style: theme.textTheme.bodySmall,
                  ),
                  SizedBox(height: 1.h),
                  const Divider(),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dayWiseSlots.length,
                      itemBuilder: (context, dayIndex) {
                        final slots = dayWiseSlots.values.elementAt(dayIndex);
                        String date = dayFormatter.format(slots.first.start);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(height: 2.h),
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2.h,
                              mainAxisSpacing: 2.h,
                              childAspectRatio: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                slots.length,
                                (slotIndex) {
                                  final slot = slots[slotIndex];

                                  String startTime =
                                      slotFormatter.format(slot.start);
                                  String endTime =
                                      slotFormatter.format(slot.end);

                                  bool isSelected = selectedTime.value ==
                                      slot.start.millisecondsSinceEpoch;

                                  return InkWell(
                                    onTap: () {
                                      selectedTime.value =
                                          slot.start.millisecondsSinceEpoch;
                                      selectedSlotId.value = slot.id;
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: theme.canvasColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected
                                              ? theme.primaryColor
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.5.h, horizontal: 2.w),
                                      child: Text(
                                        '$startTime - $endTime',
                                        style: isSelected
                                            ? theme.textTheme.bodyMedium!
                                                .copyWith(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                              )
                                            : theme.textTheme.bodySmall!
                                                .copyWith(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 4.h),
                          ],
                        );
                      },
                    ),
                  ),
                  MgPrimaryButton(
                    'Continue',
                    onTap: () async {
                      if (selectedSlotId.value.isNotEmpty) {
                        try {
                          isLoading.value = true;
                          final eventId = selectedSlotId.value;
                          await ref.read(slotProvider).bookSlot(eventId);
                        } on MgException catch (_) {
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () => MgErrorDialog.showErrorDialog(
                              context,
                              title: 'Oops!',
                              subtitle: 'Something went wrong.',
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
                            ),
                          );
                        } finally {
                          isLoading.value = false;
                          Navigator.of(context).pop();
                          ref.refresh(userDiaryProvider);
                        }
                      }
                    },
                    isEnabled: selectedTime.value != 0,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
              Visibility(
                visible: isLoading.value,
                child: const MgLoadingBlur(),
              ),
            ],
          ),
        );
      },
      error: (err, _) {
        return Text(err.toString());
      },
      loading: () => Center(
        child: CircularProgressIndicator(color: theme.primaryColor),
      ),
    );
  }
}
