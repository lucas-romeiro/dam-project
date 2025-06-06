import 'package:flutter/material.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/services/recipe_service.dart';
import 'dart:async';

class RecipeController extends ChangeNotifier {
  final RecipeService _service;

  RecipeController(this._service);

  List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];

  List<Recipe> get recipes => _filteredRecipes;
  List<Recipe> get filteredRecipes => _filteredRecipes; // Adicionado aqui ✅

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int? _selectedRecipeId;
  Recipe? _selectedRecipe;
  int get selectedIndex => _selectedRecipeId ?? 0;
  Recipe? get selectedRecipeDetail => _selectedRecipe;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  Timer? _debounce;

  final List<String> menuItems = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    // 'Cheat Menu',
  ];

  List<String> get categories => menuItems;

  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allRecipes = await _service.fetchRecipes();
      _filterRecipes();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedRecipeId = index;

    if (_allRecipes.isNotEmpty && index < _allRecipes.length) {
      _selectedRecipe = _allRecipes[index];
    } else {
      _selectedRecipe = null;
    }

    _filterRecipes();
    notifyListeners();
  }

  void setSelectedRecipe(Recipe recipe) {
    _selectedRecipe = recipe;
    notifyListeners();
  }

  void searchRecipes(String query) {
    _searchQuery = query;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _filterRecipes();
      notifyListeners();
    });
  }

  void _filterRecipes() {
    final selectedCategory = menuItems[selectedIndex].toLowerCase();

    _filteredRecipes =
        _allRecipes.where((recipe) {
          final matchesCategory = recipe.mealType.any(
            (type) => type.toLowerCase() == selectedCategory,
          );

          final matchesSearch = recipe.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

          return matchesCategory && matchesSearch;
        }).toList();
  }

  List<Recipe> getFavoriteRecipes(List<int> favoriteIds) {
    return _allRecipes
        .where((recipe) => favoriteIds.contains(recipe.id))
        .toList();
  }
}
