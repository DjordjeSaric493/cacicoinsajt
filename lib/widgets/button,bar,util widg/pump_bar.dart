import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class PresalePumpWidget extends StatefulWidget {
  const PresalePumpWidget({super.key});

  @override
  State<PresalePumpWidget> createState() => _PresalePumpWidgetState();
}

class _PresalePumpWidgetState extends State<PresalePumpWidget> {
  final DateTime startDate = DateTime(
    2025,
    4,
    12,
  ); // Početni datum presale-a, menjaj za ui
  final int durationInDays = 30;
  bool isLoading = false;

  Future<void> _buyTokens() async {
    setState(() {
      isLoading = true;
    });

    // Simulacija uspešne transakcije
    await Future.delayed(const Duration(seconds: 2)); // Simulacija kašnjenja
    setState(() {
      isLoading = false;
    });

    // Prikazivanje poruke o uspehu
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Uspešna transakcija!")));
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int daysElapsed = now
        .difference(startDate)
        .inDays
        .clamp(0, durationInDays);
    final double progress = daysElapsed / durationInDays;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PUMPA GIF
        Image.asset(
          'assets/pumpaj-protest-srbija.gif',
          width: 200,
          height: 200,
        ),

        // PROGRESS BAR
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: Colors.red,
            minHeight: 10,
          ),
        ),

        Text(
          'Pre-sale traje još ${durationInDays - daysElapsed} dana!',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        // BUTTON
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: isLoading ? null : _buyTokens,
          icon:
              isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : const Icon(Icons.local_gas_station),
          label: Text(
            isLoading ? "Procesiranje..." : "Pumpaj PreSale",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
