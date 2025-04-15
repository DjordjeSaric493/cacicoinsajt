import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
          title: Text('ĆaciLend Meni', style: dekkoTextStyleWhite),
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
                  //TODO: NALEPI X,INSTAGRAM I DISCORD!!
                  _buildNavItemRed(
                    'ĆaciCoin',
                    () => Navigator.pushNamed(context, '/cacicoin'),
                  ),
                  _buildNavItemRed(
                    'ne budi ćaci',
                    () => Navigator.pushNamed(context, '/nebudicaci'),
                  ),
                  _buildNavItemRed(
                    'ĆACILEND',
                    () => Navigator.pushNamed(context, '/cacilend'),
                  ),
                  _buildNavItemRed(
                    //TODO: OPIS ĆACIJA PAGE
                    '"Ćaci"',
                    () => Navigator.pushNamed(context, '/opiscacija'),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildNavItem(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: dekkoTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildNavItemRed(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: dekkoTextStyleRed,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  static Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
