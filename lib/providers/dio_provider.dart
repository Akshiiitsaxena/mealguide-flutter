import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/urls.dart';
import 'package:mealguide/providers/token_provider.dart';

final dioProvider = FutureProvider.family<Dio, bool>((ref, withToken) async {
  final Dio dio;
  if (withToken) {
    String? token = await ref.read(tokenProvider).getToken();
    dio = Dio()
      ..options.baseUrl = MgUrls.baseUrl
      ..options.headers['Authorization'] = 'Bearer $token';
  } else {
    dio = Dio()..options.baseUrl = MgUrls.baseUrl;
  }
  return dio;
});
