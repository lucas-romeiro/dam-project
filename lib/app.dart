import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/onboarding/screen/onboarding_screen.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/features/authentication/screen/auth_screen.dart';
import 'package:dam_project/features/home/screens/main_navigation.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class App extends StatelessWidget {
  final bool onboarding;

  const App({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        // Aguarda até que o SharedPreferences seja lido
        if (!auth.isInitialized) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp(
          title: 'Meal Planner',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          ),
          home: _buildInitialScreen(onboarding, auth),
        );
      },
    );
  }
}

Widget _buildInitialScreen(bool onboarding, AuthController authController) {
  if (!onboarding) return const OnBoardingScreen();
  if (authController.rememberMe && authController.isLoggedIn) {
    return const MainNavigation();
  }
  return const AuthScreen();
}
