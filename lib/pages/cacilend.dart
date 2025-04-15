import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/dodajcacijabutt.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:convert'; // Za base64Encode
import 'package:cacicoinsajt/widgets/app_bar_widget.dart'; // Dodajte ovaj import
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/mobile_drawer_widget.dart'; // Dodajte ovaj import

class Cacilend extends StatelessWidget {
  const Cacilend({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final appBarWidth =
        isMobile
            ? MediaQuery.of(context).size.width * 0.90
            : MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: CustomAppBar(isMobile: isMobile), // Dodajte AppBar
      drawer: isMobile ? const MobileDrawer() : null, // Dodajte Drawer
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: appBarWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'ĆACILEND',
                  style: deliciousTextStyleBig.copyWith(
                    fontSize: isMobile ? 36 : 48,
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 12),
                Text(
                  'Zid srama',
                  style: deliciousTextStyleBigRed.copyWith(
                    fontSize: isMobile ? 28 : 36,
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 24),
                Text(
                  'Prst na čelo ćaci, na zidu si, a voleo bi da nisi!\n'
                  'Dobra vest je da postoji način, loša vest za tebe - nema'
                  '“kozmetike", zahteva suštinu. Nepoznata teritorija,'
                  'hmmm…jeste, ali ne brini!\n'
                  'Pokaži za početak dovoljno skromnosti da prihvatiš činjenično stanje, '
                  'preuzmi odgovornost za situaciju u kojoj se nalaziš, pronađi hrabrosti u sebi '
                  'za potrebnu inicijativu u delima koja ti pomažu da se suočiš sa svim izazovima '
                  'i ovo mesto ovde će ti ukazati neverovatnu moć izbora!',
                  style: dekkoTextStyle.copyWith(fontSize: isMobile ? 20 : 28),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text('Dodaj svog Ćacija!!!', style: dekkoTextStyle),
                const SizedBox(height: 40),
                PixelArtButton(isMobile: isMobile, onPressed: () {}),
                const SizedBox(height: 40),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: appBarWidth),
                  child: _RazbacaneSlike(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RazbacaneSlike extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',
    'assets/8.png',
    'assets/9.png',
    'assets/10.png',
    'assets/11.png',
    'assets/12.png',
    'assets/13.png',
    'assets/14.png',
    'assets/15.png',
    'assets/16.png',
  ];

  final List<double> rotations = [
    -5,
    3,
    -2,
    4,
    -3,
    2,
    -4,
    1,
    -1,
    5,
    -2,
    3,
    -3,
    2,
    -1,
    4,
  ];

  final List<double> scales = [
    0.9,
    1.1,
    0.95,
    1.05,
    1.0,
    0.9,
    1.1,
    0.95,
    1.05,
    1.0,
    0.9,
    1.1,
    0.95,
    1.05,
    1.0,
    0.9,
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final imageSize = isMobile ? 120.0 : 150.0;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 2 : 4,
      mainAxisSpacing: isMobile ? 12.0 : 20.0,
      crossAxisSpacing: isMobile ? 12.0 : 20.0,
      childAspectRatio: 1,
      children: List.generate(imagePaths.length, (index) {
        return GestureDetector(
          onTap: () => _showFullScreenImage(context, imagePaths[index]),
          child: Transform.rotate(
            angle: rotations[index] * (3.1415926535 / 180),
            child: Transform.scale(
              scale: scales[index],
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
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
      // 1. Učitajte sliku kao niz bajtova iz asseta
      final ByteData imageData = await rootBundle.load(imagePath);
      final Uint8List bytes = imageData.buffer.asUint8List();

      // 2. Kreirajte data URL za preuzimanje
      final String base64 = base64Encode(bytes);
      final String mimeType =
          'image/png'; // Prilagodite tip mime u zavisnosti od formata slike
      final String dataUrl = 'data:$mimeType;base64,$base64';

      // 3. Kreirajte anchor element
      final html.AnchorElement anchor = html.AnchorElement(href: dataUrl)
        ..download =
            imagePath.split('/').last; // Postavite naziv fajla za preuzimanje

      // 4. Dodajte anchor u body dokumenta (privremeno)
      html.document.body?.children.add(anchor);

      // 5. Programski kliknite na link da biste pokrenuli preuzimanje
      anchor.click();

      // 6. Uklonite anchor iz body-ja
      html.document.body?.children.remove(anchor);

      // 7. Prikažite poruku o uspešnom preuzimanju
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Slika se preuzima...'),
          duration: Duration(seconds: 2),
        ),
      );
      // Ili ako imate _showSuccessDownload() metodu u vašem kodu, možete je pozvati:
      // _showSuccessDownload();
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
