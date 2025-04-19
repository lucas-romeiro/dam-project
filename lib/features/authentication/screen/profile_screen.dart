import 'package:dam_project/features/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/authentication/screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User? profile;

  const ProfileScreen({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 78,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/login/no-user.png",
                  ),
                  radius: 75,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                profile?.fullName ?? "",
                style: const TextStyle(fontSize: 25, color: AppColors.primary),
              ),
              Text(
                profile?.email ?? "",
                style: const TextStyle(fontSize: 17, color: AppColors.darkGrey),
              ),
              const SizedBox(height: 10),

              Button(
                label: "SIGN UP",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.person, size: 30),
                subtitle: const Text("Full Name"),
                title: Text(profile?.fullName ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.email, size: 30),
                subtitle: const Text("Email"),
                title: Text(profile?.email ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle, size: 30),
                subtitle: const Text("Username"),
                title: Text(profile?.username ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
