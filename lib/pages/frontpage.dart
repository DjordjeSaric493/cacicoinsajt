import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/dodajcacijabutt.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/fencebutt.dart';
import 'package:cacicoinsajt/widgets/entercacilend.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/pump_bar.dart';
import 'package:cacicoinsajt/widgets/razbacanicaciji.dart';
import 'package:cacicoinsajt/pages/cacilend.dart';
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/widgets/app_bar_widget.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/mobile_drawer_widget.dart';
import 'package:cacicoinsajt/widgets/hero_section_widget.dart';
import 'package:cacicoinsajt/widgets/description_section_widget.dart';
import 'package:cacicoinsajt/widgets/caci_coin_section_widget.dart';
import 'package:cacicoinsajt/widgets/uputstvosrb.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  void initState() {
    super.initState();
  }

  void _showUputstvoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SingleChildScrollView(
            child: Uputstvosrb(), // Koristite vaš UputstvoSrb widget ovde
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final appBarWidth =
        isMobile
            ? MediaQuery.of(context).size.width * 0.95
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
                              CaciCoinSection(
                                showUputstvoDialog: _showUputstvoDialog,
                              ),
                              const SizedBox(height: 20),
                              PresalePumpWidget(),

                              /*kad dodje vreme
                              UdjiUCacilend(
                                isMobile: isMobile,
                                appBarWidth: appBarWidth,
                              ),*/
                              const SizedBox(height: 30),
                              //ZidSramaText(isMobile: isMobile),
                              const SizedBox(height: 40),
                              Text(
                                'Dodaj svog Ćacija!!!',
                                style: dekkoTextStyle,
                              ),
                              const SizedBox(height: 40),
                              PixelArtButton(
                                isMobile: isMobile,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 40),
                              FenceButton(
                                buttonText: 'Idi na sledeću stranicu',
                                nextPage: Cacilend(
                                  isMobile: isMobile,
                                ), // Vaša widget klasa za sledeću stranicu
                                fenceImagePath:
                                    'assets/ograda.png', // Putanja do slike ograde
                              ),

                              //TODO:IMPORTUJ DUGME  OVDE!
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
