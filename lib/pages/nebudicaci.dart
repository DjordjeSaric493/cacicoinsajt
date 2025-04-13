import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/cacitipcard.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/mobile_drawer_widget.dart';
import 'package:cacicoinsajt/widgets/app_bar_widget.dart';

class NebudiCaciScreen extends StatelessWidget {
  const NebudiCaciScreen({super.key});

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
        child: Center(
          child: SizedBox(
            width: appBarWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'NE BUDI ĆACI',
                  style: deliciousTextStyleBig,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'U komplikovanim, turbulentnim vremenima, u kojima stvarnost poprima obrise\n mnogo veće od nas samih, budi Ćaci-ne budi Ćaci, postaje ključni\nindividualni doprinos potonuća ili prosperiteta čitave nacije.\nPrepoznaj, promeni, pobedi Ćacija, kako u sebi, tako i oko sebe.\nUpoznaj se sa trajnom edukacijom!',
                  style: dekkoTextStyle.copyWith(fontSize: 34),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ), //OSTALO BRIŠI, DASMI OSTANU SAMO TEKST I APPBAR I DRAWER
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return CaciTipCard(
                      title: '${index + 1}. deo',
                      buttonText: index == 0 ? 'Opis' : 'Uskoro',
                      buttonColor: const Color.fromARGB(255, 250, 4, 16),
                      buttonTextStyle: dekkoTextStyle,
                      onPressed:
                          index == 0
                              ? () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/prozorPrviDeo.png',
                                            ), // zameni putanju
                                            const SizedBox(height: 10),
                                            const Text(
                                              '1. deo',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Zatvori'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              : () {},
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
