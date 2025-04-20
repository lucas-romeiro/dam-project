import 'package:flutter/material.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/common/widgets/textfield.dart';
import 'package:dam_project/features/authentication/screen/widgets/diet_dropdown.dart';
import 'package:dam_project/features/authentication/screen/widgets/calorie_slider.dart';
import 'package:dam_project/features/authentication/data/auth_reposity.dart';
import 'package:dam_project/features/authentication/model/user_model.dart';
import 'package:dam_project/features/authentication/screen/login_screen.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final diet = TextEditingController(text: 'None');
  final calories = TextEditingController(text: '2000');
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Key for form validation

  bool isUserExist = false;

  final db = AuthReposity();

  signUp() async {
    // Verifica se o formulário é válido
    if (_formKey.currentState?.validate() ?? false) {
      // Verifica se a senha e a confirmação da senha batem
      if (password.text != confirmPassword.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      // Verifica se o e-mail já existe
      bool userExist = await db.emailExists(email.text);

      if (userExist) {
        setState(() {
          isUserExist = true;
        });
      } else {
        var res = await db.createUser(
          User(
            fullName: fullName.text,
            email: email.text,
            password: password.text,
            diet: diet.text,
            calories: int.tryParse(calories.text) ?? 2000,
          ),
        );

        if (res > 0) {
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: DeviceUtils.getKeyboardHeight(context) + 16,
              ),
              child: Form(
                key: _formKey, // Linka o formulário com a chave
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Page Title
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Register New Account",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Input Fields
                    InputField(
                      hint: "Full Name",
                      icon: Icons.person,
                      controller: fullName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 6),

                    InputField(
                      hint: "Email",
                      icon: Icons.email,
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Validação básica de e-mail
                        String pattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 6),

                    // Diet Dropdown
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
                      controller: diet,
                    ),
                    const SizedBox(height: 6),

                    // Calories Slider
                    CalorieSlider(controller: calories),
                    const SizedBox(height: 6),

                    InputField(
                      hint: "Password",
                      icon: Icons.lock,
                      controller: password,
                      passwordInvisible: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 6),

                    InputField(
                      hint: "Confirm Password",
                      icon: Icons.lock,
                      controller: confirmPassword,
                      passwordInvisible: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != password.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    Button(label: "SIGN UP", press: signUp),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: AppColors.darkGrey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text("LOGIN"),
                        ),
                      ],
                    ),

                    if (isUserExist)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "User already exists, please enter another email",
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
