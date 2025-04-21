import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends ChangeNotifier {
  static const _favoritesKey = 'favorite_recipes';

  List<int> _favoriteRecipeIds = [];

  List<int> get favoriteRecipeIds => _favoriteRecipeIds;

  FavoritesController() {
    loadFavorites(); // Chama a função ao iniciar
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteRecipeIds =
        prefs.getStringList(_favoritesKey)?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorite(int recipeId) async {
    final prefs = await SharedPreferences.getInstance();

    if (_favoriteRecipeIds.contains(recipeId)) {
      _favoriteRecipeIds.remove(recipeId);
    } else {
      _favoriteRecipeIds.add(recipeId);
    }

    await prefs.setStringList(
      _favoritesKey,
      _favoriteRecipeIds.map((id) => id.toString()).toList(),
    );
    notifyListeners();
  }

  bool isFavorite(int recipeId) => _favoriteRecipeIds.contains(recipeId);
}
