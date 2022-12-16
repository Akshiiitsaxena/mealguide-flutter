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

  get getImage {
    switch (name) {
      case 'Vegetarian':
        return 'assets/plates/vegetarian_plate.png';
      case 'Low Carb':
        return 'assets/plates/low_carb_plate.png';
      case 'Mediterranean':
        return 'assets/plates/mediterranean_plate.png';
      case 'Keto':
        return 'assets/plates/keto_plate.png';
      case 'Diabetes Friendly':
        return 'assets/plates/diabetes_friendly_plate.png';
      case 'DASH':
        return 'assets/plates/dash_plate.png';
      case 'Paleo':
        return 'assets/plates/paleo_plate.png';
      case 'Vegan':
        return 'assets/plates/vegen_plate.png';
      case 'High Protein':
        return 'assets/plates/high_protein_plate.png';
      case 'Balanced Diet':
        return 'assets/plates/balanced_plate.png';
      case 'PCOD':
        return 'assets/plates/pcod_plate.png';
      case 'Gluten Free':
        return 'assets/plates/gluten_free_plate.png';
      case 'Intermittent Fasting':
        return 'assets/plates/if_plate.png';
      default:
    }
  }

  get getDisplayName {
    switch (name) {
      case 'Balanced Diet':
        return 'Balanced Plan';
      case 'Intermittent Fasting':
        return 'Intermittent Fasting';
      default:
        return '$name Diet';
    }
  }
}
