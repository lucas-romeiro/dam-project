import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/common/widgets/textfield.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/common/controllers/input_controller.dart'; // <-- Importa o InputController
import 'package:dam_project/features/home/screens/home_screen.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/features/authentication/screen/signup_screen.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final input = Provider.of<InputController>(
      context,
    ); // <-- Referência ao InputController
    final localFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SafeArea(
          child: Form(
            key: localFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset("assets/images/login/authentication-image-3.png"),
                  const SizedBox(height: 10),

                  // Email
                  InputField(
                    label: "Email",
                    icon: Icons.email,
                    controller: auth.email,
                    validator: input.validatorEmail(),
                  ),
                  const SizedBox(height: 6),

                  // Password com toggle de visibilidade
                  InputField(
                    label: "Password",
                    icon: Icons.lock,
                    controller: auth.password,
                    isVisible: input.isPasswordVisible,
                    validator: input.validatorPassword(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        input.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => input.togglePasswordVisibility(),
                    ),
                  ),

                  // Remember me
                  ListTile(
                    horizontalTitleGap: 2,
                    title: const Text("Remember me"),
                    leading: Checkbox(
                      activeColor: AppColors.primary,
                      value: auth.isChecked,
                      onChanged: (_) => auth.toogleChecked(),
                    ),
                  ),

                  // Botão
                  Button(
                    label: "Login",
                    press: () async {
                      final success = await auth.login(localFormKey);
                      if (success) {
                        if (auth.isChecked) auth.setRememberMe();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email or password is incorrect"),
                          ),
                        );
                      }
                    },
                  ),

                  // Redirecionar para o cadastro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: AppColors.darkGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          auth.clearForm();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text("SIGN UP"),
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
