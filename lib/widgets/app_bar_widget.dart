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
                  _buildNavItem(
                    'Twitter',
                    () => _launchURL('https://twitter.com/tvoj_nalog'),
                  ),
                  _buildNavItem(
                    'Instagram',
                    () => _launchURL('https://instagram.com/tvoj_nalog'),
                  ),
                  _buildNavItem(
                    'Telegram',
                    () => _launchURL('https://t.me/tvoj_kanal'),
                  ),
                  _buildNavItem(
                    'ĆaciCoin',
                    () => Navigator.pushNamed(context, '/cacicoin'),
                  ),
                  _buildNavItem(
                    'ne budi ćaci',
                    () => Navigator.pushNamed(
                      context,
                      '/nebudicaci',
                    ), //POGLEDAJ OVDE MI NIJE UVEZAO
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
