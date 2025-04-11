import 'package:cacicoinsajt/widgets/button,bar,util%20widg/buycaci_butt.dart';
import 'package:cacicoinsajt/widgets/poveziwallet.dart';
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class CaciCoinSection extends StatefulWidget {
  final Function() showUputstvoDialog;

  const CaciCoinSection({super.key, required this.showUputstvoDialog});

  @override
  _CaciCoinSectionState createState() => _CaciCoinSectionState();
}

class _CaciCoinSectionState extends State<CaciCoinSection> {
  bool isConnected = false;
  bool isLoading = false;
  double bnbValue = 0;
  String currentAddress = '';
  final TextEditingController _bnbAmountController = TextEditingController();

  @override
  void dispose() {
    _bnbAmountController.dispose();
    super.dispose();
  }

  void _onWalletConnected(String address) {
    setState(() {
      isConnected = true;
      currentAddress = address;
      print('Wallet povezan: $address');
    });
  }

  void _updateBNBValue(String value) {
    final parsed = double.tryParse(value) ?? 0;
    setState(() {
      bnbValue = parsed;
    });
  }

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
        Text(
          'Kupovina Ćacicoin-a',
          style: deliciousTextStyleBig,
          textAlign: TextAlign.center,
        ),
        Text(
          'Da biste kupili Ćacicoin, prvo povežite svoj e-wallet',
          style: dekkoTextSmall,
          textAlign: TextAlign.center,
        ),

        /// ✅ Ovde ubacujemo dugme
        ConnectWalletButton(
          onConnected:
              _onWalletConnected, // Koristimo funkciju za ažuriranje stanja
          connectedText: "Uspešno povezano! ✅",
          disconnectedText: "Poveži sa e-walletom",
          connectedIcon: const Icon(Icons.check_circle_outline),
          disconnectedIcon: const Icon(Icons.account_balance_wallet_outlined),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF525252), // tamno siva pozadina
            foregroundColor: Colors.white, // bela boja teksta i ikone
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: dekkoTextSmall,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            // Koristimo Row da bi textbox i dugme bili u redu
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150, // Povećana širina textboxa
                child: TextField(
                  controller: _bnbAmountController, // Koristimo kontroler
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unesite količinu BNB', // Dodat label za textbox
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged:
                      _updateBNBValue, // Pozivamo funkciju za ažuriranje vrednosti
                ),
              ),
              const SizedBox(width: 8), // Razmak između textboxa i dugmeta
              BuyButton(
                isConnected: isConnected,
                isLoading: isLoading,
                bnbValue: bnbValue,
                onStart: () {
                  setState(() => isLoading = true);
                  //logDart("Pokretanje kupovine...");
                },
                onFinish: () {
                  if (mounted) setState(() => isLoading = false);
                },
                //onLog: logDart,
                context: context,
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
