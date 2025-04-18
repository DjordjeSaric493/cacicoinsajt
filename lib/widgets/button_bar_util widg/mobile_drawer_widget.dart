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
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 217, 217, 217), // Početna boja
                  Color.fromARGB(255, 180, 180, 180), // Krajnja boja
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              
              
            ),
            child: Image.asset(
              'assets/cacicoin.png', // Zamenite putanjom do vaše slike
              fit: BoxFit.contain, // Prilagodite kako se slika uklapa
            ),
          ),

          ListTile(
            title: Text('ĆaciCoin', style: darkerGrotesqueBlack),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/cacicoin');
            },
          ),
          ListTile(
            title: Text('Ćacilend', style: darkerGrotesqueRed),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/cacilend');
            },
          ),
          ListTile(
            title: Text('"Ćaci"', style: darkerGrotesqueBlack),
            onTap: () {
              Navigator.pop(context); // zatvara drawer
              Navigator.pushNamed(context, '/opiscacija');
            },
          ),
          ListTile(
            title: Text('Ne budi ćaci', style: darkerGrotesqueBlack),
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
