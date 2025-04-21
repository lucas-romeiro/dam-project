import 'package:dam_project/common/controllers/input_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/common/widgets/textfield.dart';
import 'package:dam_project/features/authentication/screen/widgets/diet_dropdown.dart';
import 'package:dam_project/features/authentication/screen/widgets/calorie_slider.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/features/authentication/screen/login_screen.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final input = Provider.of<InputController>(context);
    final localFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SafeArea(
          child: Form(
            key: localFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Register New Account",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),

                  InputField(
                    label: "Full Name",
                    icon: Icons.person,
                    controller: auth.fullName,
                    validator: input.validatorRequired("Full name"),
                  ),
                  const SizedBox(height: 6),

                  InputField(
                    label: "Email",
                    icon: Icons.email,
                    controller: auth.email,
                    validator: input.validatorEmail(),
                  ),
                  const SizedBox(height: 6),

                  DietDropdown(
                    diets: [
                      'None',
                      'Gluten Free',
                      'Ketogenic',
                      'Lacto-Vegetarian',
                      'Ovo-Vegetarian',
                      'Vegan',
                      'Pescetarian',
                      'Paleo',
                      'Primal',
                      'Whole30',
                    ],
                    controller: auth.diet,
                  ),
                  const SizedBox(height: 6),

                  CalorieSlider(controller: auth.calories),
                  const SizedBox(height: 6),

                  InputField(
                    label: "Password",
                    icon: Icons.lock,
                    controller: auth.password,
                    isVisible: input.isPasswordVisible,
                    validator: input.validatorPassword(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        input.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: input.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 6),

                  InputField(
                    label: "Confirm Password",
                    icon: Icons.lock,
                    controller: auth.confirmPassword,
                    isVisible: input.isPasswordVisible,
                    validator: input.validatorConfirmPassword(auth.password),
                    suffixIcon: IconButton(
                      icon: Icon(
                        input.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: input.togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Button(
                    label: "SIGN UP",
                    press: () async {
                      final success = await auth.register(localFormKey);
                      if (success && context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: AppColors.darkGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          auth.clearForm();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("LOGIN"),
                      ),
                    ],
                  ),

                  if (auth.isUserExist)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "User already exists. Try another email.",
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
