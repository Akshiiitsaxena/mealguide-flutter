import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/models/call_slot_model.dart';
import 'package:mealguide/providers/dio_provider.dart';

final slotProvider = Provider((ref) => SlotHandler(ref));

class SlotHandler {
  final ProviderRef ref;

  SlotHandler(this.ref);

  Future<CallSlot> getBookedSlot() async {
    try {
      final dio = await ref.watch(dioProvider(true).future);
      final response = await dio.get(MgUrls.getBookedSlot);

      if (response.data['data'] == null) {
        throw MgException(code: -2);
      }

      return CallSlot.fromDoc(response.data['data']);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw MgException();
    } on MgException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw MgException();
    }
  }

  Future<void> bookSlot(String eventId) async {
    try {
      final dio = await ref.watch(dioProvider(true).future);
      final timezone = await FlutterTimezone.getLocalTimezone();

      await dio.post(
        MgUrls.bookSlot,
        data: {'event_id': eventId, 'user_time_zone': timezone},
      );
    } on DioError catch (e) {
      debugPrint(e.message);
      throw MgException(message: e.message);
    } catch (_) {
      throw MgException();
    }
  }
}

final availableSlotProvider = FutureProvider<List<CallSlotTime>>(
  (ref) async {
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
      throw MgException(message: e.message);
    } catch (_) {
      throw MgException();
    }
  },
);
