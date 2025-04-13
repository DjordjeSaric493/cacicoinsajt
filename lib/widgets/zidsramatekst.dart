import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:flutter/material.dart';

class ZidSramaText extends StatelessWidget {
  final bool isMobile;

  const ZidSramaText({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text('ĆACILEND', style: deliciousTextStyleBig),
        SizedBox(height: isMobile ? 6 : 8),
        Text('Zid srama', style: deliciousTextStyleBigRed),
        SizedBox(height: isMobile ? 6 : 8),
        Text(
          'Prst na čelo ćaci, na zidu si, a voleo bi da nisi!\nDobra vest je da postoji način, loša vest za tebe - nema\n “kozmetike”, zahteva suštinu.Nepoznata teritorija,\n hmmm…jeste, ali ne brini!\nPokaži za početak dovoljno skromnosti da prihvatiš činjenično stanje, preuzmi odgovornost za situaciju u kojoj se nalaziš, pronađi hrabrosti u sebi za potrebnu inicijativu u delima koja ti\n pomažu da se suočiš sa svim izazovima, i ovo mesto ovde će ti  ukazati neverovatnu moć izbora!',
          style: dekkoTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
