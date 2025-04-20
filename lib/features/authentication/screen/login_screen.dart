import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/features/authentication/data/auth_reposity.dart';
import 'package:dam_project/features/authentication/model/user_model.dart';
import 'package:dam_project/common/widgets/textfield.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/authentication/screen/signup_screen.dart';
import 'package:dam_project/features/authentication/screen/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey para o formulário

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = AuthReposity();

  login() async {}

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
                // Wrap o conteúdo com o Form
                key: _formKey, // Atribua a chave do formulário
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      "assets/images/login/authentication-image-3.png",
                    ),
                    const SizedBox(height: 10),

                    // Input text area
                    InputField(
                      hint: "Email",
                      icon: Icons.email,
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        // Verificar se o email tem um formato válido
                        String pattern =
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 6),
                    InputField(
                      hint: "Password",
                      icon: Icons.lock,
                      controller: password,
                      passwordInvisible: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),

                    // Stay login
                    Consumer<AuthController>(
                      builder: (context, AuthController notifier, child) {
                        return ListTile(
                          horizontalTitleGap: 2,
                          title: Text("Remember me"),
                          leading: Checkbox(
                            activeColor: AppColors.primary,
                            value: notifier.isChecked,
                            onChanged: (value) => notifier.toogleCheck(),
                          ),
                        );
                      },
                    ),

                    // Action button
                    Consumer<AuthController>(
                      builder: (context, AuthController notifier, child) {
                        return Button(
                          label: "Login",
                          press: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Validação dos campos
                              User? userDetails = await db.getUser(email.text);

                              final res = await db.authenticate(
                                User(
                                  fullName: "",
                                  email: email.text,
                                  password: password.text,
                                ),
                              );

                              if (res == true) {
                                if (notifier.isChecked == true) {
                                  notifier.setRememberMe();
                                }

                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ProfileScreen(profile: userDetails),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isLoginTrue = true;
                                });
                              }
                            }
                          },
                        );
                      },
                    ),

                    // Create account area
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: AppColors.darkGrey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text("SIGN UP"),
                        ),
                      ],
                    ),

                    // Error message
                    isLoginTrue
                        ? const Text(
                          "Email or Password is incorrect",
                          style: TextStyle(color: AppColors.error),
                        )
                        : const SizedBox(),
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
