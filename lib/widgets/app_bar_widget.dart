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
            : MediaQuery.of(context).size.width * 1;

    return isMobile
        ? AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 233, 233, 233), // Početna boja
                  Color.fromARGB(255, 176, 176, 176), // Krajnja boja
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // Blaga senka ispod
                ),
              ],
            ),
          ),
          title: Text('ĆaciLend Meni', style: darkerGrotesqueBlack),
        )
        : PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Center(
            child: Container(
              width: appBarWidth,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(119, 0, 0, 0),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 232, 232, 232), // Početna boja
                    Color.fromARGB(255, 168, 168, 168), // Krajnja boja
                  ],
                  begin: Alignment.centerLeft, // Počinje sa leve strane
                  end: Alignment.centerRight, // Završava sa desne strane
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceEvenly, // Color.fromARGB(255, 217, 217, 217)
                children: [
                  const SizedBox(
                    width: 260,
                  ), // Dodajemo malo prostora sa leve strane
                  // Logo i tekst ĆaciCoin (skroz levo)
                  Row(
                    mainAxisSize:
                        MainAxisSize.min, // Da zauzme samo potreban prostor
                    children: [
                      Image.asset(
                        'assets/cacicoin.png', // Zamenite putanjom do vašeg logoa
                        height: 60, // Podesite visinu logoa
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ĆaciCoin',
                        style: deliciousTextStyle, // Prilagodite stil teksta
                      ),
                    ],
                  ),

                  const Spacer(), // Gura ostale elemente na desnu stranu
                  //TODO: NALEPI X,INSTAGRAM I DISCORD!!
                  _buildNavItem(
                    'ĆaciCoin',
                    () => Navigator.pushNamed(context, '/cacicoin'),
                  ),
                  _buildNavItem(
                    'Ne budi ćaci!',
                    () => Navigator.pushNamed(context, '/nebudicaci'),
                  ),
                  _buildNavItemRed(
                    'Ćacilend',
                    () => Navigator.pushNamed(context, '/cacilend'),
                  ),
                  _buildNavItem(
                    //TODO: OPIS ĆACIJA PAGE
                    '"Ćaci"',
                    () => Navigator.pushNamed(context, '/opiscacija'),
                  ),
                  SizedBox(width: 260),
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
          style: darkerGrotesqueBlack,
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
          style: darkerGrotesqueRed,
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
