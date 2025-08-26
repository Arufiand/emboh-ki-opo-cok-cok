import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      color: Colors.grey[400],
      activeColor: Colors.grey.shade700,
      tabActiveBorder: Border.all(color: Colors.white),
      tabBackgroundColor: Colors.grey.shade100,
      tabs: [
        GButton(icon: Icons.home, text: "Shop"),
        GButton(icon: Icons.shopping_bag_rounded, text: "Cart"),
      ],
    );
  }
}
