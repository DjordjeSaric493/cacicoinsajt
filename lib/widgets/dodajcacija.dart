import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/pixelartupload.dart';
import 'package:flutter/material.dart';

class PixelArtScreen extends StatelessWidget {
  const PixelArtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Dodaj Ćacija',
            style: dekkoTextStyleRed,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Tvoj Ćaci će biti ubačen u Ćacilend i prikazan na sajtu!!!',
            textAlign: TextAlign.center,
            style: dekkoTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'Nagrada: 1000 Ćacicoin-a (max 3 puta po wallet-u)',
            style: dekkoTextStyleRed,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showPixelArtUploadDialog(context),
            child: Text('Ubaci svoju sliku', style: dekkoTextSmall),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showPixelArtUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const PixelArtUploadForm(),
            ),
          ),
    );
  }
}
