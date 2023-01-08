import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/urls.dart';

final dioProvider = StateProvider.family<Dio, bool>((ref, withToken) {
  final Dio dio;
  if (withToken) {
    dio = Dio()
      ..options.baseUrl = MgUrls.baseUrl
      ..options.headers['Authorization'] = 'Bearer $token';
  } else {
    dio = Dio()..options.baseUrl = MgUrls.baseUrl;
  }
  return dio;
});
