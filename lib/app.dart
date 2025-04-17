import 'package:dam_project/features/authentication/screen/auth_screen.dart';
import 'package:dam_project/features/onboarding/screen/onboarding_screen.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final bool onboarding;

  const App({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: AuthScreen(),
      // onboarding
      //     ? Scaffold(
      //       body: Center(
      //         child: TextButton(
      //           onPressed: () async {
      //             final prefs = await SharedPreferences.getInstance();
      //             prefs.setBool("onboarding", false);
      //           },
      //           child: Text('Enable OnBoarding'),
      //         ),
      //       ),
      //     )
      //     : const OnBoardingScreen(),
    );
  }
}
