import 'package:anakallumkal_app/modules/category/view/category_screen.dart';
import 'package:anakallumkal_app/modules/furniture/view/furniture_screen.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

int currentIndex = 0;

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              if (MediaQuery.of(context).size.width <= 1120)
                const Row(
                  children: [
                    SizedBox(height: 100),
                    // Container(
                    //   height: 40,
                    //   width: 40,
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       image: CachedNetworkImageProvider(
                    //           "https://www.w3schools.com/howto/img_avatar.png"),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 8),
                    // const Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Aravind",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //         height: 0,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Cashier",
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         height: 0,
                    //         color: Colors.blueGrey,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              Column(
                children: [
                  // SizedBox(height: 16),
                  // DrawerTile(icon: "dashboard", title: "Dashboard"),
                  const SizedBox(height: 24),
                  DrawerTile(
                      icon: "furniture",
                      title: "Furnitures",
                      isSelected: currentIndex == 1),
                  DrawerTile(
                      icon: "store",
                      title: "Categories",
                      isSelected: currentIndex == 0),
                  // SizedBox(height: 24),
                ],
              ),
            ],
          ),
          // const Column(
          //   children: [
          //     DrawerTile(icon: "settings", title: "Settings"),
          //     SizedBox(height: 24),
          //     DrawerTile(icon: "logout", title: "Logout"),
          //     SizedBox(height: 24),
          //   ],
          // )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (icon == "store" || icon == "furniture") {
          if (icon == "store") {
            currentIndex = 0;
          } else {
            currentIndex = 1;
          }
          Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  icon == "store"
                      ? const CategoryScreen()
                      : const FurnitureScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
            (route) => false,
          );
        }
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: !isSelected
              ? null
              : Border.all(
                  color: AppColors.primaryColor,
                ),
          color: !isSelected ? null : AppColors.primaryColor.withOpacity(0.05),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                "assets/svgs/${icon}_icon.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color ?? Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      ),
    );
  }
}
