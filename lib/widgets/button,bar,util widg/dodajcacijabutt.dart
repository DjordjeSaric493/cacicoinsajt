import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/dodajcacija.dart';
import 'package:flutter/material.dart';

class PixelArtButton extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onPressed; // Opcionalni callback za dodatnu logiku

  const PixelArtButton({
    super.key,
    required this.isMobile,
    this.onPressed,
  });

  void _showPixelArtDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(isMobile ? 16 : 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? MediaQuery.of(context).size.width : 800,
          ),
          child: const PixelArtScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 32,
          vertical: isMobile ? 12 : 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
      ),
      onPressed: () {
        _showPixelArtDialog(context);
        onPressed?.call(); // Poziva dodatnu logiku ako postoji
      },
      child: Text(
        'Dodaj Ćacija',
        style: dekkoTextSmallWhite
      ),
    );
  }
}