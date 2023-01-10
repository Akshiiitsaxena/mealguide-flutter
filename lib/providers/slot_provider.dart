import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/call_slot_model.dart';
import 'package:mealguide/providers/dio_provider.dart';

class SlotHandler {
  final ProviderRef ref;

  SlotHandler(this.ref);

  Future<CallSlot> getBookedSlot() async {
    try {
      final dio = await ref.watch(dioProvider(true).future);
      final response = await dio.get(MgUrls.getBookedSlot);

      return CallSlot.fromDoc(response.data['data']);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw MgException();
    } catch (_) {
      throw MgException();
    }
  }

  Future<List<CallSlotTime>> getAvailableSlots() async {
    try {
      final dio = await ref.watch(dioProvider(true).future);
      final response = await dio.get(MgUrls.getAvailableSlots);

      List<CallSlotTime> slots = [];

      response.data['data'].forEach((doc) {
        slots.add(CallSlotTime.fromDoc(doc));
      });

      return slots;
    } on DioError catch (e) {
      debugPrint(e.message);
      return [];
    } catch (_) {
      return [];
    }
  }

  // Future<void> bookSlot(String eventId) async {
  //   try {
  //     final dio = await ref.watch(dioProvider(true).future);
  //     // final timezone = await FlutterNativeTimezone.getLocalTimezone();

  //     await dio.post(
  //       MgUrls.bookSlot,
  //       data: {'event_id': eventId, 'user_time_zone': timezone},
  //     );
  //   } on DioError catch (e) {
  //     debugPrint(e.message);
  //     throw MgException(message: e.message);
  //   } catch (_) {
  //     throw MgException();
  //   }
  // }
}
