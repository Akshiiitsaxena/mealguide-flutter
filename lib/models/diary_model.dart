import 'package:mealguide/models/day_plan_model.dart';

class Diary {
  DateTime startTime;
  DateTime endTime;
  String masterPlanId;
  List<DayPlan> plans;

  Diary({
    required this.endTime,
    required this.plans,
    required this.startTime,
    required this.masterPlanId,
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
      masterPlanId: doc['_id'],
    );
  }

  set setCustomStartTime(DateTime dateTime) {
    startTime = dateTime;
  }
}
