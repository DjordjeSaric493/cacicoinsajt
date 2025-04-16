import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
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
            child:
                isMobile
                    ? Center(
                      child: Image.asset(
                        'assets/cacicoin.png',
                        width:
                            300, // možeš smanjiti veličinu za mobilne ako treba
                        height: 300,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: isMobile ? 20 : 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('FENOMEN', style: deliciousTextStyleBig),
                              Text('ĆACI', style: deliciousTextStyleBig),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(-2, 0),
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
