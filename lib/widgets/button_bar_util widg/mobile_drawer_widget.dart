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
            title: Text('ĆaciCoin', style: dekkoTextStyle),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/cacicoin');
            },
          ),
          ListTile(
            title: Text('Ćacilend', style: dekkoTextStyleRed),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/cacilend');
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
            title: Text('Ne budi ćaci', style: dekkoTextStyle),
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
