import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/models/diet_model.dart';

final dietProvider = FutureProvider<List<Diet>>((ref) async {
  final String dietsJsonString =
      await rootBundle.loadString('assets/data/diets.json');
  final dietsJson = jsonDecode(dietsJsonString);

  List<Diet> diets = [];

  for (var data in dietsJson['data'] as List) {
    diets.add(Diet.fromDoc(data));
  }

  diets.sort((a, b) => a.name.compareTo(b.name));
  return diets;
});
