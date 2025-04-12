import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
            child: Text('ĆaciLand Meni', style: dekkoTextStyle),
          ),
          ListTile(
            title: Text('Twitter', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://twitter.com/tvoj_nalog');
            },
          ),
          ListTile(
            title: Text('Instagram', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://instagram.com/tvoj_nalog');
            },
          ),
          ListTile(
            title: Text('Telegram', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://t.me/tvoj_kanal');
            },
          ),
          ListTile(
            title: Text('ĆaciCoin', style: dekkoTextStyle),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/cacicoin');
            },
          ),
          ListTile(
            title: Text('ne budi ćaci', style: dekkoTextStyle),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/nebudicaci');
            },
          ),
        ],
      ),
    );
  }
}
