import 'package:flutter/material.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/common/widgets/textfield.dart';
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
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final db = AuthReposity();

  signUp() async {
    var res = await db.createUser(
      User(
        fullName: fullName.text,
        email: email.text,
        username: userName.text,
        password: password.text,
      ),
    );

    if (res > 0) {
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {}
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Page Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
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

                  // InputField Area
                  InputField(
                    hint: "Full Name",
                    icon: Icons.person,
                    controller: fullName,
                  ),
                  const SizedBox(height: 6),
                  InputField(
                    hint: "Email",
                    icon: Icons.email,
                    controller: email,
                  ),
                  const SizedBox(height: 6),
                  InputField(
                    hint: "Username",
                    icon: Icons.account_circle,
                    controller: userName,
                  ),
                  const SizedBox(height: 6),
                  InputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    passwordInvisible: true,
                  ),
                  const SizedBox(height: 6),
                  InputField(
                    hint: "Confirm Password",
                    icon: Icons.lock,
                    controller: confirmPassword,
                    passwordInvisible: true,
                  ),
                  const SizedBox(height: 20),

                  Button(
                    label: "SIGN UP",
                    press: () {
                      signUp();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
