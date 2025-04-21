import 'package:flutter/material.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/services/recipe_service.dart';

class RecipeController extends ChangeNotifier {
  final RecipeService _service;

  RecipeController(this._service);

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> menuItems = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Cheat Menu',
  ];

  List<String> get categories => menuItems;

  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _service.fetchRecipes();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
