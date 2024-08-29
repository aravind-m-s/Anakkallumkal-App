import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                if (MediaQuery.of(context).size.width <= 1120)
                  Row(
                    children: [
                      const SizedBox(height: 100),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "https://www.w3schools.com/howto/img_avatar.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aravind",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Cashier",
                            style: TextStyle(
                              fontSize: 12,
                              height: 0,
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                const Column(
                  children: [
                    SizedBox(height: 16),
                    DrawerTile(icon: "dashboard", title: "Dashboard"),
                    SizedBox(height: 24),
                    DrawerTile(icon: "store", title: "Shops"),
                    SizedBox(height: 24),
                    DrawerTile(icon: "furniture", title: "Furnitures"),
                  ],
                ),
              ],
            ),
            const Column(
              children: [
                DrawerTile(icon: "settings", title: "Settings"),
                SizedBox(height: 24),
                DrawerTile(icon: "logout", title: "Logout"),
                SizedBox(height: 24),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
