import 'package:dam_project/features/favorites/screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:dam_project/features/home/screens/home_screen.dart';
import 'package:dam_project/features/authentication/screen/profile_screen.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:iconsax/iconsax.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [HomeScreen(), FavoriteScreen(), const ProfileScreen()];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconSize: 28,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkGrey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2,
            ),
            label: "Settings",
          ),
        ],
      ),
      body: page[_selectedIndex],
    );
  }

  navBarPage(iconName) {
    return Center(child: Icon(iconName, size: 100, color: Color(0xffeff1f7)));
  }
}
