import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dam_project/app.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/common/controllers/input_controller.dart';
import 'package:dam_project/features/recipe/services/recipe_service.dart';
import 'package:dam_project/features/recipe/controller/recipe_controller.dart';
import 'package:dam_project/features/favorites/controller/favorites_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Carrega Onboarding flag do SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  // 2️⃣ Cria e inicializa o AuthController antes do runApp
  final authController = AuthController();
  await authController.initStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        // 3️⃣ Reutiliza a instância pré‑inicializada de AuthController
        ChangeNotifierProvider<AuthController>.value(value: authController),
        ChangeNotifierProvider(create: (_) => InputController()),
        ChangeNotifierProvider(
          create: (_) => RecipeController(RecipeService())..loadRecipes(),
        ),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
      ],
      child: App(onboarding: onboarding),
    ),
  );
}
