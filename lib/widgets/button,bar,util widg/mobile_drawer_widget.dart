import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
            child: Text('ĆaciLand Meni', style: TextStyle(fontSize: 24)),
          ),
          ListTile(title: Text('Twitter', style: dekkoTextStyle), onTap: () {}),
          ListTile(
            title: Text('Instagram', style: dekkoTextStyle),
            onTap: () {},
          ),
          ListTile(
            title: Text('Telegram', style: dekkoTextStyle),
            onTap: () {},
          ),
          ListTile(
            title: Text('ĆaciCoin', style: dekkoTextStyle),
            onTap: () {},
          ),
          ListTile(
            title: Text('ne budi ćaci', style: dekkoTextStyle),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
