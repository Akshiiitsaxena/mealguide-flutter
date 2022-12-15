import 'package:hive/hive.dart';

part 'added_items_hive_model.g.dart';

@HiveType(typeId: 0)
class AddedItem extends HiveObject {
  @HiveField(0)
  final String recipeId;

  @HiveField(1)
  final List<String> ingredientIds;

  AddedItem({required this.recipeId, required this.ingredientIds});

  @override
  int get hashCode => super.hashCode;
}
