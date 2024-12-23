import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/paints.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: PaintColors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomNav(context, icon: Iconsax.home_2, index: 0, label: "Home"),
            _bottomNav(context,
                icon: Iconsax.archive_book, index: 1, label: "News"),
            _bottomNav(context,
                icon: Iconsax.user_square, index: 2, label: "Search"),
          ],
        ),
      ),
    );
  }

  Widget _bottomNav(BuildContext context,
      {required IconData icon, required int index, required String label}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: currentIndex == index
                ? PaintColors.paralexpurple
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: currentIndex == index
                  ? PaintColors.paralexpurple
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
