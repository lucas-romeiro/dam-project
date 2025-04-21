import 'package:dam_project/common/controllers/input_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dam_project/app.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => AuthController()..initStorage()),
        ChangeNotifierProvider(create: (_) => InputController()),
      ],
      child: App(onboarding: onboarding),
    ),
  );
}
