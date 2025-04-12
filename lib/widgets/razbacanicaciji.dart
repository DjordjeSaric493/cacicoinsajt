import 'package:flutter/material.dart';

class RazbacaneSlikeIzAssets extends StatelessWidget {
  final List<String> imageAssetPaths = [
    '1.png',
    '2.png',
    '3.png',
    '4.png',
    '5.png',
    '6.png',
    '7.png',
    '8.png',
    '9.png',
    '10.png',
    '11.png',
    '12.png',
    '13.png',
    '14.png',
    '15.png',
    '16.png',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                imageAssetPaths.map((path) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth / 2 - 12,
                    ), // Prilagodite po potrebi
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        path,
                        fit: BoxFit.contain, // Prilagodite kako se slika uklapa
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return const Text('Greška pri učitavanju slike');
                        },
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
