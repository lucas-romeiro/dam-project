import 'package:flutter/material.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/authentication/screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

              const Text(
                "John Doe",
                style: TextStyle(fontSize: 25, color: AppColors.primary),
              ),
              const Text(
                "john.doe@email.com",
                style: TextStyle(fontSize: 17, color: AppColors.darkGrey),
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

              const ListTile(
                leading: Icon(Icons.person, size: 30),
                subtitle: Text("Full Name"),
                title: Text("John Doe"),
              ),
              const ListTile(
                leading: Icon(Icons.email, size: 30),
                subtitle: Text("Email"),
                title: Text("john.doe@email.com"),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle, size: 30),
                subtitle: Text("Username"),
                title: Text("admin"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
