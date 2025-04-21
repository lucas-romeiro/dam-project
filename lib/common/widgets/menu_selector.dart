import 'package:flutter/material.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class MenuItemSelector extends StatelessWidget {
  final List<String> menuItems;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const MenuItemSelector({
    super.key,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          menuItems.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                onItemSelected(index); // Chama a função passada
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      selectedIndex == index
                          ? AppColors.primary
                          : AppColors.white,
                      selectedIndex == index
                          ? AppColors.warning
                          : AppColors.white,
                    ],
                  ),
                ),
                child: Text(
                  menuItems[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.w500,
                    color: selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
