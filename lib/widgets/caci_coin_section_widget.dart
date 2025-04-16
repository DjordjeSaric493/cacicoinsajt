import 'package:cacicoinsajt/utils/text/appstrings.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/buycaci_butt.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/uputstvo_butt.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/crttokenomicsmonitor.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/poveziwallet.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/ugovori_butt.dart';
import 'package:cacicoinsajt/widgets/uputstvopravo.dart';
import 'package:cacicoinsajt/widgets/uputstvo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:google_fonts/google_fonts.dart';

class CaciCoinSection extends StatefulWidget {
  //final Function() showUputstvoDialog;

  const CaciCoinSection({super.key});

  @override
  _CaciCoinSectionState createState() => _CaciCoinSectionState();
}

class _CaciCoinSectionState extends State<CaciCoinSection> {
  bool isConnected = false;
  bool isLoading = false;
  double bnbValue = 0;
  String currentAddress = '';
  int tokenAmount = 0;
  double tokenPriceInBNB = 0.0000001;
  double maxBNB = 1.0;
  final TextEditingController _bnbAmountController = TextEditingController();
  String? _maxInputMessage;

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

  //ZAKLJUČA MU NA FLOOR TJ VREDNOSTI 1 BNB
  /*void updateBNBValue(String value) {
    final parsed = int.tryParse(value) ?? 0;
    setState(() {
      tokenAmount = parsed;
      bnbValue = parsed * tokenPriceInBNB;
      if (bnbValue > maxBNB) {
        tokenAmount = (maxBNB / tokenPriceInBNB).floor();
        bnbValue = maxBNB;
      }
    });
  }*/
  void updateBNBValue(String value) {
    final parsed = int.tryParse(value) ?? 0;
    setState(() {
      tokenAmount = parsed;
      bnbValue = parsed * tokenPriceInBNB;
      _maxInputMessage = null; // Resetujemo poruku pri svakoj promeni unosa
      if (bnbValue > maxBNB) {
        final maxTokens = (maxBNB / tokenPriceInBNB).floor();
        _maxInputMessage = 'Najviše možete uneti: $maxTokens ĆaciCoin-a';
        tokenAmount =
            maxTokens; // Automatski postavljamo maksimalnu vrednost u state
        bnbValue = maxBNB;
        _bnbAmountController.text =
            maxTokens.toString(); // Ažuriramo tekst u TextField-u
      }
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
        SizedBox(height: 14),
        Text(
          'Kupovina Ćacicoin-a',
          style: deliciousTextStyleBig,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14),
        Text(
          'Da biste kupili Ćacicoin, prvo povežite svoj e-wallet',
          style: deliciousTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        // UputstvoButton(),
        /*Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => UputstvosrbDialog(),
              );
            },
            child: Text('Uputstvo', style: dekkoTextSmallWhite),
          ),
        ),*/
        SizedBox(height: 26),
        CrtTokenomicsMonitor(),
        SizedBox(height: 26),
        UgovoriButton(),
        SizedBox(height: 26),

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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: dekkoTextSmall,
          ),
        ),
        SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            // Promenili smo Row u Column
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centriramo elemente po širini
            children: [
              SizedBox(
                width: 240, // Povećana širina textboxa
                child: TextField(
                  controller: _bnbAmountController, // Koristimo kontroler
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        'Unesite količinu tokena', // Dodat label za textbox
                    labelStyle: dekkoTextSmall, // Dodajte ovaj stil
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged:
                      updateBNBValue, // Pozivamo funkciju za ažuriranje vrednosti
                ),
              ),
              const SizedBox(
                height: 30,
              ), // Dodatni razmak između polja i teksta
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Boja pozadine kutije
                  borderRadius: BorderRadius.circular(8.0), // Zaobljeni uglovi
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Boja senke
                      spreadRadius: 2, // Koliko daleko se senka širi
                      blurRadius: 5, // Stepen zamućenja senke
                      offset: const Offset(
                        0,
                        3,
                      ), // Pomeraj senke (horizontalno, vertikalno)
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0), // Unutrašnji padding teksta
                child: Text(
                  'Vrednost u BNB: ${bnbValue.toStringAsFixed(8)}',
                  style: dekkoTextSmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
        SizedBox(height: 20),
      ],
    );
  }
}
