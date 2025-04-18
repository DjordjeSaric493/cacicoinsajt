import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/appstrings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFooter extends StatelessWidget {
  final bool isMobile;

  const CustomFooter({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 227, 227, 227), // Početna svetlo siva
          Color.fromARGB(255, 118, 118, 118), // Završna malo tamnija siva
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
      child: Column(
        children: [
          // Gornji deo sa ikonama i sadržajem
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child:
                isMobile
                    ? Column(
                      children: [
                        _buildSocialIcons(),
                        const SizedBox(height: 20),
                        _buildCenterLogo(),
                        const SizedBox(height: 20),
                        _buildContactLinks(TextAlign.center),
                      ],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildCenterLogo(),
                        _buildContactLinks(TextAlign.left),
                        _buildSocialIcons(),
                      ],
                    ),
          ),
          const Divider(thickness: 1, height: 1, color: Colors.black),
          
          Container(
            width: double.infinity,
            color: Colors.black87, // Tamno siva ili crna
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '© 2025 ĆaciCoin. All rights reserved.',
              style: darkerGrotesqueSmallWhite, // Svetliji tekst
              textAlign: TextAlign.center,
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _socialIcon('https://x.com/CaciCoin', FontAwesomeIcons.x), // X
        const SizedBox(width: 30),
        _socialIcon(
          'https://www.instagram.com/cacicoin/',
          FontAwesomeIcons.instagram,
        ), // Instagram
        const SizedBox(width: 30),
        _socialIcon(
          'https://discord.com/invite/x56vRV8N',
          FontAwesomeIcons.discord,
        ), // Discord
      ],
    );
  }

  Widget _socialIcon(String url, IconData icon) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(icon, color: Colors.black),
    );
  }

  Widget _buildCenterLogo() {
    return Column(
      children: [
        Image.asset('assets/cacicoin.png', height: 120), // Povećan logo
        const SizedBox(height: 12),
        Text(
          'ĆACICOIN',
          style: deliciousTextStyleBig.copyWith(
            fontSize: isMobile ? 28 : 36, // Povećan tekst
          ),
        ),
      ],
    );
  }

  Widget _buildContactLinks(TextAlign align) {
    return Column(
      crossAxisAlignment:
          align == TextAlign.left
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
      children: [
        Text(
          'Kontakt',
          style: darkerGrotesqueBlack.copyWith(fontSize: isMobile ? 20 : 28),
        ),
        _linkText('cacicoins@gmail.com', 'mailto:cacicoins@gmail.com'),
        _linkText(
          'Uslovi korišćenja',
          '',
          showDialogContent: AppStringsSrb.usloviKoriscenja,
        ),
        _linkText(
          'Politika privatnosti',
          '',
          showDialogContent: AppStringsSrb.politikaPrivatnosti,
        ),
      ],
    );
  }

  Widget _linkText(String text, String url, {String? showDialogContent}) {
    return Builder(
      builder:
          (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: () {
                if (showDialogContent != null) {
                  _showInfoDialog(context, text, showDialogContent);
                } else {
                  _launchURL(url);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: darkerGrotesqueSmallBlack),
                  Container(height: 2, width: 120, color: Colors.red),
                ],
              ),
            ),
          ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: deliciousTextStyleRed),
          content: SingleChildScrollView(
            child: Text(content, style: darkerGrotesqueSmallBlack),
          ),
          actions: [
            TextButton(
              child: Text('Zatvori', style: darkerGrotesqueSmallBlackW),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
