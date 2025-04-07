import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final double appBarWidth;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.appBarWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: appBarWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isMobile ? 40 : 90),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'FENOMEN',
                          style: deliciousTextStyleBig,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ĆACI',
                          style: deliciousTextStyleBig,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isMobile)
                  Transform.translate(
                    offset: const Offset(-140, 0),
                    child: Image.asset(
                      'assets/logo-pisan-rukom-caci 1.png',
                      width: 550,
                      height: 550,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
