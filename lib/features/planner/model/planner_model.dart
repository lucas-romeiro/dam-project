import 'package:dam_project/features/recipe/model/recipe_model.dart';

class Planner {
  final List<Recipe> recipes;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;

  Planner({
    required this.recipes,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  factory Planner.fromJson(Map<String, dynamic> json) {
    return Planner(
      recipes:
          (json['recipes'] as List<dynamic>)
              .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
              .toList(),
      calories: (json['calories'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
      'calories': calories,
      'carbs': carbs,
      'fat': fat,
      'protein': protein,
    };
  }
}
