import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLanguageChange;

  const CustomNavbar({super.key, required this.onLanguageChange});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/icons/3d-printer.png',
                  color: Colors.white,
                  height: screenWidth > 600 ? 38 : 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'printfy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth > 600 ? 30 : 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset(
              'lib/assets/icons/world.png',
              color: Colors.white,
              height: screenWidth > 600 ? 38 : 30,
              width: screenWidth > 600 ? 38 : 30,
            ),
            onPressed: () {
              if (context.locale == const Locale('it')) {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('it'));
              }
              onLanguageChange();
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
