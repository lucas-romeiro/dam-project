import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:dam_project/features/planner/model/planner_model.dart';
import 'package:dam_project/features/planner/service/planner_service.dart';

/// Controller para gestão do estado do Planner
class PlannerController extends ChangeNotifier {
  Planner? _mealPlan;
  bool _isLoading = false;
  String? _error;

  Planner? get mealPlan => _mealPlan;
  bool get isLoading => _isLoading;
  String? get error => _error;

  PlannerController() {
    _loadFromPrefs();
  }

  /// Gera o meal plan e notifica ouvintes
  Future<void> generateMealPlan({
    required int targetCalories,
    required String diet,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final plan = await PlannerService.instance.generateMealPlan(
        targetCalories: targetCalories,
        diet: diet,
      );
      _mealPlan = plan;
      await _saveToPrefs();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Salva o meal plan no SharedPreferences
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (_mealPlan != null) {
      prefs.setString('mealPlan', jsonEncode(_mealPlan!.toJson()));
    }
  }

  /// Carrega o meal plan do SharedPreferences
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('mealPlan');
    if (data != null) {
      _mealPlan = Planner.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }
}
