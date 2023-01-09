class CallSlot {
  final String id;
  final String nutritionistId;
  final DateTime createdAt;
  final DateTime startAt;
  final DateTime endAt;
  final String timezone;
  final String link;
  final String feedback;

  CallSlot({
    required this.id,
    required this.nutritionistId,
    required this.createdAt,
    required this.startAt,
    required this.timezone,
    required this.endAt,
    required this.feedback,
    required this.link,
  });

  factory CallSlot.fromDoc(Map<String, dynamic> doc) {
    return CallSlot(
      id: doc['_id'],
      nutritionistId: doc['nutritionist'],
      createdAt: DateTime.parse(doc['createdAt']).toLocal(),
      startAt: DateTime.parse(doc['start_time']).toLocal(),
      timezone: doc['user_time_zone'],
      endAt: DateTime.parse(doc['end_time']).toLocal(),
      feedback: doc['feedback'],
      link: doc['location'],
    );
  }
}

class CallSlotTime {
  final String id;
  final DateTime start;
  final DateTime end;

  CallSlotTime({
    required this.id,
    required this.start,
    required this.end,
  });

  factory CallSlotTime.fromDoc(Map<String, dynamic> doc) {
    return CallSlotTime(
      id: doc['_id'],
      start: DateTime.parse(doc['start_time']).toLocal(),
      end: DateTime.parse(doc['end_time']).toLocal(),
    );
  }
}
