import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/dodajcacija.dart';
import 'package:cacicoinsajt/widgets/pump_bar.dart';
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/widgets/app_bar_widget.dart';
import 'package:cacicoinsajt/widgets/mobile_drawer_widget.dart';
import 'package:cacicoinsajt/widgets/hero_section_widget.dart';
import 'package:cacicoinsajt/widgets/description_section_widget.dart';
import 'package:cacicoinsajt/widgets/caci_coin_section_widget.dart';
import 'package:cacicoinsajt/widgets/uputstvosrb.dart';
import 'dart:js' as js;

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool _isLoading = false;
  bool _isMetaMaskInstalled = false;
  String? _connectedAddress;
  final String _presaleContractAddress =
      'TVOJA_PRESALE_ADRESA_SA_TESTNETA'; // ZAMENI PRAVOM ADRESOM

  @override
  void initState() {
    super.initState();
  }

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
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 250,
                  bottom: 0,
                  child: Image.asset(
                    'assets/caciusk2.png',
                    width: isMobile ? 140 : 200,
                    height: isMobile ? 140 : 200,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/caciusk2.png',
                    width: isMobile ? 140 : 200,
                    height: isMobile ? 140 : 200,
                  ),
                ),
                Column(
                  children: [
                    HeroSection(isMobile: isMobile, appBarWidth: appBarWidth),
                    DescriptionSection(
                      isMobile: isMobile,
                      appBarWidth: appBarWidth,
                    ),
                    Center(
                      child: SizedBox(
                        width: appBarWidth * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            children: [
                              CaciCoinSection(showUputstvoDialog: () {}),
                              const SizedBox(height: 20),
                              PresalePumpWidget(),
                              const SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: isMobile ? 20 : 50,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Uđi u Ćacilend',
                                    style: deliciousTextStyleBig,
                                  ),
                                ),
                              ),
                              PixelArtScreen(), //problematičan ekran
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
