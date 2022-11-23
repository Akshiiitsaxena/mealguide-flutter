class Serving {
  final double quantity;
  final String? unit;

  Serving({required this.quantity, this.unit});

  factory Serving.fromDoc(Map<String, dynamic> doc) {
    return Serving(
      quantity: double.parse(doc['quantity'].toString()),
      unit: doc['unit'],
    );
  }
}
