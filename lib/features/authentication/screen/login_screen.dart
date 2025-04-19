import 'package:flutter/material.dart';
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
  final userName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = AuthReposity();

  login() async {
    User? userDetails = await db.getUser(userName.text);

    final res = await db.authenticate(
      User(username: userName.text, password: password.text),
    );

    if (res == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(profile: userDetails),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
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
                  Image.asset("assets/images/login/authentication-image-3.png"),
                  const SizedBox(height: 10),

                  // Input text area
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

                  // Stay login
                  ListTile(
                    horizontalTitleGap: 2,
                    title: Text("Remember me"),
                    leading: Checkbox(
                      activeColor: AppColors.primary,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                  ),

                  // Action button
                  Button(
                    label: "Login",
                    press: () {
                      login();
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
                        "Username or Password is incorrect",
                        style: TextStyle(color: AppColors.error),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
