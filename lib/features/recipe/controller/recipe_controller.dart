import 'package:flutter/material.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/services/recipe_service.dart';

class RecipeController extends ChangeNotifier {
  final RecipeService _service;

  RecipeController(this._service);

  List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];

  List<Recipe> get recipes => _filteredRecipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

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
      _filterRecipes(); // Aplica filtro inicial
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    _filterRecipes();
    notifyListeners();
  }

  void searchRecipes(String query) {
    _searchQuery = query;
    _filterRecipes();
    notifyListeners();
  }

  void _filterRecipes() {
    final selectedCategory = menuItems[_selectedIndex].toLowerCase();

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
}
