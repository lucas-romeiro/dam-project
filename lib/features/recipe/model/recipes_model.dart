import 'recipe_model.dart';

class RecipesModel {
  final List<Recipe> recipes;
  final int total;
  final int skip;
  final int limit;

  RecipesModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "recipes": recipes.map((x) => x.toJson()).toList(),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}
