import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/planner/model/planner_model.dart';
import 'package:dam_project/utils/constants/app_api_keys.dart';

class PlannerService {
  PlannerService._instantiate();
  static final PlannerService instance = PlannerService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String _apiKey = SPOONACULAR_API_KEY;

  /// Gera o plano de refeições e preenche com Recipe completos
  Future<Planner> generateMealPlan({
    required int targetCalories,
    required String diet,
  }) async {
    final dietParam = diet == 'None' ? '' : diet;
    final params = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': dietParam,
      'apiKey': _apiKey,
    };

    final uri = Uri.https(_baseUrl, '/recipes/mealplans/generate', params);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode != 200) {
      throw Exception(
        'Erro ao gerar meal plan: ${resp.statusCode} ${resp.reasonPhrase}',
      );
    }
    final data = json.decode(resp.body) as Map<String, dynamic>;

    // 1) extrai nutrientes
    final nutrients = data['nutrients'] as Map<String, dynamic>;
    final calories = (nutrients['calories'] as num).toDouble();
    final carbs = (nutrients['carbohydrates'] as num).toDouble();
    final fat = (nutrients['fat'] as num).toDouble();
    final protein = (nutrients['protein'] as num).toDouble();

    // 2) extrai lista de IDs de meal
    final mealIds =
        (data['meals'] as List).map((meal) => meal['id'] as int).toList();

    // 3) busca cada receita completa (paralelamente)
    final recipes = await Future.wait(mealIds.map((id) => fetchRecipe(id)));

    // 4) retorna Planner com List<Recipe>
    return Planner(
      recipes: recipes,
      calories: calories,
      carbs: carbs,
      fat: fat,
      protein: protein,
    );
  }

  /// Busca informação completa da receita e mapeia para o modelo `Recipe`
  Future<Recipe> fetchRecipe(int id) async {
    final params = {'includeNutrition': 'true', 'apiKey': _apiKey};
    final uri = Uri.https(_baseUrl, '/recipes/$id/information', params);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode != 200) {
      throw Exception(
        'Erro na API Spoonacular: ${resp.statusCode} ${resp.reasonPhrase}',
      );
    }

    final data = json.decode(resp.body) as Map<String, dynamic>;
    return Recipe.fromSpoonacular(data);
  }
}
