import 'package:http/http.dart' as http;
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/data/recipe_mapper.dart';

class RecipeService {
  final String _baseUrl = "https://dummyjson.com/recipes";

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final Uri url = Uri.parse(_baseUrl);
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = recipesModelFromJson(res.body);
        return data.recipes;
      } else {
        throw Exception("Failed to load recipes: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching recipes: $e");
    }
  }
}
