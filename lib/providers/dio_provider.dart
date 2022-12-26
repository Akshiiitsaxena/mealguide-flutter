import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/urls.dart';

final dioProvider = StateProvider<Dio>((ref) {
  final dio = Dio()..options.baseUrl = MgUrls.baseUrl;
  return dio;
});
