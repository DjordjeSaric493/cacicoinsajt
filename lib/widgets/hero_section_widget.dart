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
                Padding(
                  // Promenjeno iz Expanded u Padding
                  padding: EdgeInsets.only(
                    right: isMobile ? 20 : 30,
                  ), // Smanjen padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'FENOMEN',
                        style: deliciousTextStyleBig,
                        // textAlign: TextAlign.right, // Uklonjeno
                      ),
                      Text(
                        'ĆACI',
                        style: deliciousTextStyleBig,
                        // textAlign: TextAlign.right, // Uklonjeno
                      ),
                    ],
                  ),
                ),
                if (!isMobile)
                  Transform.translate(
                    offset: const Offset(-2, 0), // Prilagođeno pomeranje slike
                    child: Image.asset(
                      'assets/cacicoin.png',
                      width: 550,
                      height: 520,
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
