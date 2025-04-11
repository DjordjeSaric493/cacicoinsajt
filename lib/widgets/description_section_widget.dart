import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class DescriptionSection extends StatelessWidget {
  final bool isMobile;
  final double appBarWidth;

  const DescriptionSection({
    super.key,
    required this.isMobile,
    required this.appBarWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: appBarWidth * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              if (isMobile) ...[
                Column(
                  children: [
                    Text(
                      "pročitaj detaljan opis klikom na",
                      style: GoogleFonts.dekko(
                        color: Colors.red,
                        fontSize: isMobile ? 24 : 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: GoogleFonts.dekko(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('opis Ćacija'),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "pročitaj detaljan opis klikom na",
                      style: GoogleFonts.dekko(color: Colors.red, fontSize: 40),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed:
                          () //TODO:IMPLEMENTIRAJ OTVARANJE ONOG TEKSTA SA SKROLOM KADA KLIKNE OVDE!
                          {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: GoogleFonts.dekko(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('opis Ćacija'),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Ko smo mi?',
                  style: deliciousTextStyleBig,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Mi smo tim koji stoji iza ĆaciCoin-a najšaljivijeg kripto projekta na internetu!\n\n'
                  'ĆaciCoin je parodija na etiku ličnosti, ali sa ozbiljnom misijom - da ukaže na pogrešne vrednosti i pokrene etiku karaktera.\n\n'
                  'Iako sve radimo sa osmehom, ne zaboravljamo ni one kojima je pomoć najpotrebnija zato će ĆaciCoin imati i humanitarnu crtu, jer smeh i dobrota idu ruku pod ruku!\n\n'
                  'Pridruži se našoj zajednici i postani deo krypto revolucije u buđenju svesti, empatije i savesti kod ljudi!',
                  style: dekkoTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
