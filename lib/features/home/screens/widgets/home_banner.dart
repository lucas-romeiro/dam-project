import 'package:flutter/material.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Cook Something New Everyday",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.white,
                        height: 1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "New and tasty recipes every minute",
                      style: TextStyle(color: AppColors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.soup_kitchen,
                          size: 16,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "95 recipes",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.person_3, size: 16, color: AppColors.white),
                        SizedBox(width: 10),
                        Text(
                          "10 chefs",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                "assets/images/recipes/recipes-card-image-1.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
