import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:flutter/material.dart';

class CaciTipCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? onPressed;
  final TextStyle? buttonTextStyle;

  const CaciTipCard({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.buttonColor,
    this.onPressed,
    this.buttonTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centriranje sadržaja vertikalno
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Rastezanje dugmeta horizontalno
          children: <Widget>[
            Text(title, style: dekkoTextStyle, textAlign: TextAlign.center),
            const SizedBox(height: 8), // Dodat razmak između teksta i dugmeta
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  buttonText,
                  style:
                      buttonTextStyle, // Uklonjen pokušaj postavljanja textAlign ovde
                  textAlign:
                      TextAlign
                          .center, // TextAlign se postavlja direktno na Text widgetu
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
