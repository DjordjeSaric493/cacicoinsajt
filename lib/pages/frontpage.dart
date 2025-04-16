import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/dodajcacijabutt.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/fencebutt.dart';
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
import 'package:cacicoinsajt/widgets/uputstvo_dialog.dart';

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
                Visibility(
                  visible: !isMobile,
                  child: Positioned(
                    left: 0,
                    top: 250,
                    bottom: 0,
                    child: Image.asset(
                      'assets/caciusk2.png',
                      width: isMobile ? 140 : 200,
                      height: isMobile ? 140 : 200,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isMobile,
                  child: Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/caciusk2.png',
                      width: isMobile ? 140 : 200,
                      height: isMobile ? 140 : 200,
                    ),
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
                              CaciCoinSection(),
                              const SizedBox(height: 20),
                              PresalePumpWidget(),

                              const SizedBox(height: 30),

                              const SizedBox(height: 40),
                              Text(
                                'Dodaj svog Ćacija!!!',
                                style: deliciousTextStyle,
                              ),
                              const SizedBox(height: 20),
                              PixelArtButton(
                                isMobile: isMobile,
                                onPressed: () {},
                              ),
                              const SizedBox(height: 41),
                              FenceButton(
                                buttonText: 'Uđi u ĆACILEND',
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
