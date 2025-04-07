import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;

  const CustomAppBar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final appBarWidth =
        isMobile
            ? MediaQuery.of(context).size.width * 0.90
            : MediaQuery.of(context).size.width * 0.7;

    return isMobile
        ? AppBar(
          backgroundColor: const Color(0xFFD9D9D9),
          elevation: 0,
          title: const Text('ĆaciLand Meni'),
        )
        : PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Center(
            child: Container(
              width: appBarWidth,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem('Twitter'),
                  _buildNavItem('Instagram'),
                  _buildNavItem('Telegram'),
                  _buildNavItem('ĆaciCoin'),
                  _buildNavItem('ne budi ćaci'),
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: dekkoTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
