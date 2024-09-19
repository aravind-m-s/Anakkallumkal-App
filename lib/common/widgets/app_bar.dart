import 'package:anakallumkal_app/common/theme/theme_bloc.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSize customAppbar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 60),
    child: CustomAppBar(scaffoldKey: scaffoldKey),
  );
}

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar({
    required this.scaffoldKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (MediaQuery.of(context).size.width <= 1120)
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu_rounded),
                  ),
                if (MediaQuery.of(context).size.width <= 1120)
                  const SizedBox(width: 16),
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  width: MediaQuery.of(context).size.width <= 920 ? 25 : 50,
                ),
                if (MediaQuery.of(context).size.width > 600)
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child:
                              SvgPicture.asset("assets/svgs/search_icon.svg"),
                        ),
                        hintText: "Search Brand, Products",
                        // ignore: prefer_const_constructors
                        hintStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusColor: AppColors.primaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (MediaQuery.of(context).size.width > 920)
              Row(
                children: [
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      if (state is SwitchThemeState) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ThemeBloc>().add(
                                  SwitchThemeEvent(
                                    isDarkMode: !state.isDarkMode,
                                  ),
                                );
                          },
                          child: Icon(
                            state.isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: Colors.grey,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  // Container(
                  //   height: 50,
                  //   width: 50,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //       image: CachedNetworkImageProvider(
                  //           "https://www.w3schools.com/howto/img_avatar.png"),
                  //     ),
                  //   ),
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Aravind",
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleMedium!
                  //           .copyWith(height: 0),
                  //     ),
                  //     const Text(
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
              )
          ],
        ),
      ),
    );
  }
}
