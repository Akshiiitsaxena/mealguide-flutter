class Diet {
  final String name;
  final String id;
  final List<String> showcaseRecipes;

  Diet({
    required this.id,
    required this.name,
    required this.showcaseRecipes,
  });

  factory Diet.fromDoc(Map<String, dynamic> doc) {
    List<String> docShowcase = [];

    doc['showcase_recipe_ids'].forEach((val) {
      docShowcase.add(val);
    });

    return Diet(
      id: doc['id'],
      name: doc['name'],
      showcaseRecipes: docShowcase,
    );
  }
}
