import 'package:mealguide/models/day_plan_model.dart';

class Diary {
  final DateTime startTime;
  final DateTime endTime;
  final List<DayPlan> plans;

  Diary({
    required this.endTime,
    required this.plans,
    required this.startTime,
  });

  factory Diary.fromDoc(Map<String, dynamic> doc) {
    List<DayPlan> docPlans = [];
    doc['plans'].forEach((plan) {
      docPlans.add(DayPlan.fromDoc(plan));
    });

    return Diary(
      endTime: DateTime.parse(doc['end_date']).toLocal(),
      plans: docPlans,
      startTime: DateTime.parse(doc['start_date']).toLocal(),
    );
  }
}
