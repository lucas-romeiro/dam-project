import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/common/widgets/button.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    if (!auth.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = auth.loggedUser;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Ícone no canto superior direito
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: AppColors.softBlack,
                child: InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("onboarding", false);
                  },
                  child: const Icon(Icons.info, color: Colors.white),
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 78,
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/login/no-user.png",
                      ),
                      radius: 75,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nome e Email
                  Text(
                    user?.fullName ?? "",
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    user?.email ?? "",
                    style: const TextStyle(
                      fontSize: 17,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Botão de logout
                  Consumer<AuthController>(
                    builder: (context, notifier, child) {
                      return Button(
                        label: "SIGN OUT",
                        press: () {
                          notifier.logout(context);
                        },
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.person, size: 30),
                    subtitle: const Text("Full Name"),
                    title: Text(user?.fullName ?? ""),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email, size: 30),
                    subtitle: const Text("Email"),
                    title: Text(user?.email ?? ""),
                  ),
                  ListTile(
                    leading: const Icon(Icons.restaurant, size: 30),
                    subtitle: const Text("Diet"),
                    title: Text(user?.diet! ?? ""),
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_fire_department, size: 30),
                    subtitle: const Text("Target Calories"),
                    title: Text(user?.calories.toString() ?? ""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
