import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class UdjiUCacilend extends StatelessWidget {
  final bool isMobile;
  final double appBarWidth;

  const UdjiUCacilend({
    super.key,
    required this.isMobile,
    required this.appBarWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: appBarWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 50),
              child: Text('Uđi u Ćacilend', style: deliciousTextStyleBig),
            ),
            SizedBox(height: isMobile ? 10 : 20),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 50),
              child: Text(
                'Učešće u ovim igrama se uvek nagrađuje dodatnim ĆaciCoin-ima! \n Uskoro',
                style: darkerGrotesqueSmallBlack,
              ),
            ),
            SizedBox(height: isMobile ? 20 : 40),
            Center(
              child: Image.asset(
                'assets/igre.png',
                width: isMobile ? appBarWidth * 0.8 : appBarWidth * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
