class Instruction {
  final String component;
  final List<String> steps;

  Instruction({required this.component, required this.steps});

  factory Instruction.fromDoc(Map<String, dynamic> doc) {
    List<String> items = [];

    doc['items'].forEach((item) {
      items.add(item.toString());
    });

    return Instruction(
      component: doc['component'],
      steps: items,
    );
  }
}
