import 'package:dam_project/utils/constants/app_enums.dart';

class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final Difficulty difficulty;
  final String cuisine;
  final int caloriesPerServing;
  final List<String> tags;
  final int userId;
  final String image;
  final double rating;
  final int reviewCount;
  final List<String> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  /// Construtor para JSON genérico (DummyJSON)
  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    name: json["name"],
    ingredients: List<String>.from(json["ingredients"]),
    instructions: List<String>.from(json["instructions"]),
    prepTimeMinutes: json["prepTimeMinutes"],
    cookTimeMinutes: json["cookTimeMinutes"],
    servings: json["servings"],
    difficulty: difficultyValues.map[json["difficulty"]]!,
    cuisine: json["cuisine"],
    caloriesPerServing: json["caloriesPerServing"],
    tags: List<String>.from(json["tags"]),
    userId: json["userId"],
    image: json["image"],
    rating: json["rating"]?.toDouble() ?? 0.0,
    reviewCount: json["reviewCount"],
    mealType: List<String>.from(json["mealType"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "ingredients": ingredients,
    "instructions": instructions,
    "prepTimeMinutes": prepTimeMinutes,
    "cookTimeMinutes": cookTimeMinutes,
    "servings": servings,
    "difficulty": difficultyValues.reverse[difficulty],
    "cuisine": cuisine,
    "caloriesPerServing": caloriesPerServing,
    "tags": tags,
    "userId": userId,
    "image": image,
    "rating": rating,
    "reviewCount": reviewCount,
    "mealType": mealType,
  };

  factory Recipe.fromSpoonacular(Map<String, dynamic> json) {
    // Ingredientes
    final ingredients =
        (json['extendedIngredients'] as List<dynamic>?)
            ?.map((e) => e['originalString']?.toString() ?? '')
            .toList() ??
        [];

    // Instruções
    final rawInstr =
        json['analyzedInstructions'] as List<dynamic>? ?? <dynamic>[];
    final instructions =
        rawInstr.expand((instr) {
          final steps = instr['steps'] as List<dynamic>? ?? <dynamic>[];
          return steps.map((s) => s['step']?.toString() ?? '');
        }).toList();

    // Calorias
    final calories =
        ((json['nutrition']?['nutrients'] as List<dynamic>?)?.firstWhere(
                  (n) => n['name'] == 'Calories',
                  orElse: () => {'amount': 0},
                )['amount']
                as num?)
            ?.toInt() ??
        0;

    // Tags
    final tags = <String>[
      ...(json['dishTypes'] as List<dynamic>? ?? []).map((e) => e.toString()),
      ...(json['diets'] as List<dynamic>? ?? []).map((e) => e.toString()),
    ];

    // Dificuldade
    String difficultyKey(int minutes) {
      if (minutes < 30) return "Easy";
      if (minutes < 60) return "Medium";
      return "Hard";
    }

    final readyIn = json['readyInMinutes'] as int? ?? 0;
    final difficulty =
        difficultyValues.map[difficultyKey(readyIn)] ?? Difficulty.EASY;

    return Recipe(
      id: json['id'] as int? ?? 0,
      name: json['title']?.toString() ?? 'Sem nome',
      ingredients: ingredients,
      instructions: instructions,
      prepTimeMinutes: json['preparationMinutes'] as int? ?? 0,
      cookTimeMinutes: json['cookingMinutes'] as int? ?? readyIn,
      servings: json['servings'] as int? ?? 1,
      difficulty: difficulty,
      cuisine:
          (json['cuisines'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .join(', ') ??
          'Diversa',
      caloriesPerServing: calories,
      tags: tags,
      userId: 0,
      image: json['image']?.toString() ?? '',
      rating: (json['spoonacularScore'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['aggregateLikes'] as int? ?? 0,
      mealType:
          (json['dishTypes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
