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
            child: Text('ĆaciLend Meni', style: dekkoTextStyle),
          ),
          ListTile(
            title: Text('X/Twitter', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://x.com/CaciCoin');
            },
          ),
          ListTile(
            title: Text('Instagram', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://www.instagram.com/cacicoin/');
            },
          ),
          ListTile(
            title: Text('Discord', style: dekkoTextStyle),
            onTap: () {
              _launchURL('https://discord.gg/x56vRV8N');
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
            title: Text('"Ćaci"', style: dekkoTextStyle),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/opiscacija');
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
