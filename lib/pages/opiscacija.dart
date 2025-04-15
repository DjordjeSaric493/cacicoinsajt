import 'package:cacicoinsajt/utils/text/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/mobile_drawer_widget.dart';
import 'package:cacicoinsajt/widgets/app_bar_widget.dart';

class OpiscacijaScreen extends StatelessWidget {
  const OpiscacijaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final appBarWidth =
        isMobile
            ? MediaQuery.of(context).size.width * 0.90
            : MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(isMobile: isMobile),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: appBarWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'SIMBOL BEZ SUŠTINE - FENOMEN ĆACI',
                  style: deliciousTextStyleRed,
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 7),
                Text(
                  OpisCacijaSrb.opis,
                  style: dekkoTextStyle.copyWith(
                    fontSize:
                        isMobile
                            ? 20
                            : 30, // Ternarni operator za veličinu fonta
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
