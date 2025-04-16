import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Dodajte ovaj import za deljenje

class PumpajCaciButton extends StatelessWidget {
  final String websiteUrl; //TODO: Dodajte URL sajta kao parametar

  const PumpajCaciButton({super.key, required this.websiteUrl});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Share.share(websiteUrl); // Koristimo share_plus za deljenje URL-a
      },
      icon: const Icon(Icons.directions_bike), // Koristimo ikonicu bicikle
      label: const Text(
        'PUMPAJ ĆACICOIN-E',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: Colors.blueAccent, // Možete prilagoditi boju
        foregroundColor: Colors.white, // Boja teksta i ikonice
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
