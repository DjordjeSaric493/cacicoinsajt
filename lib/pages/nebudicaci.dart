import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/cacitipcard.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/mobile_drawer_widget.dart';
import 'package:cacicoinsajt/widgets/app_bar_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../widgets/footer.dart';

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
                  style: deliciousTextStyleBig.copyWith(
                    fontSize: isMobile ? 36 : 48,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'U komplikovanim, turbulentnim vremenima, u kojima stvarnost poprima obrise mnogo veće od nas samih, budi Ćaci-ne budi Ćaci, postaje ključni individualni doprinos potonuća ili prosperiteta čitave nacije. Prepoznaj, promeni, pobedi Ćacija, kako u sebi, tako i oko sebe. Upoznaj se sa trajnom edukacijom!',
                  style: dekkoTextStyle.copyWith(fontSize: isMobile ? 20 : 28),
                  textAlign: TextAlign.justify,
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
                                            GestureDetector(
                                              onTap:
                                                  () => _showFullScreenImage(
                                                    context,
                                                    'assets/prozorPrviDeo.png',
                                                  ),
                                              child: Image.asset(
                                                'assets/prozorPrviDeo.png',
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  '1. deo',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.search,
                                                  ),
                                                  onPressed:
                                                      () => _showFullScreenImage(
                                                        context,
                                                        'assets/prozorPrviDeo.png',
                                                      ),
                                                ),
                                              ],
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

  void _showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: AssetImage(imagePath),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => _saveImage(context, imagePath),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _saveImage(BuildContext context, String imagePath) async {
    try {
      final ByteData imageData = await rootBundle.load(imagePath);
      final Uint8List bytes = imageData.buffer.asUint8List();
      final String base64 = base64Encode(bytes);
      final String mimeType = 'image/png';
      final String dataUrl = 'data:$mimeType;base64,$base64';
      final html.AnchorElement anchor = html.AnchorElement(href: dataUrl)
        ..download = imagePath.split('/').last;
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Slika se preuzima...'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Greška pri preuzimanju: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
