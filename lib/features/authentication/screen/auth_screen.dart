import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header
                const Text(
                  "Authentication",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Text(
                  "Authenticate to start planning your meals",
                  style: TextStyle(color: AppColors.darkGrey),
                ),

                // Image
                Expanded(
                  child: Image.asset(
                    'assets/images/login/authentication-image-1.png',
                  ),
                ),

                // Buttons
                Button(label: "LOGIN", press: () {}),
                Button(label: "SIGN UP", press: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
