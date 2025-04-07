import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class CaciCoinSection extends StatefulWidget {
  final Function() showUputstvoDialog;

  const CaciCoinSection({super.key, required this.showUputstvoDialog});

  @override
  _CaciCoinSectionState createState() => _CaciCoinSectionState();
}

class _CaciCoinSectionState extends State<CaciCoinSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ĆaciCoin',
          style: deliciousTextStyleBigRed,
          textAlign: TextAlign.center,
        ),
        Text(
          'Pre-sale počinje SADA!',
          style: deliciousTextStyleBigRed,
          textAlign: TextAlign.center,
        ),
        Text(
          'Po promotivnoj ceni samo tokom presale-a od:',
          style: deliciousTextStyle,
          textAlign: TextAlign.center,
        ),
        Text(
          '0.0000001 BNB = 0.0069 RSD = 0.000063 USD',
          style: dekkoTextStyleRed,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  // TODO:IMPLEMENTIRAJ NEKAKO KUPOVINU!!
                  print('Dugme za kupovinu pritisnuto');
                  //
                },
                child: Text('Kupi ĆaciCoin', style: dekkoTextSmallWhite),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              widget
                  .showUputstvoDialog(); // Poziv kroz konstruktor, vidi lakši način
            },
            child: Text('Uputstvo', style: dekkoTextSmallWhite),
          ),
        ),
      ],
    );
  }
}
