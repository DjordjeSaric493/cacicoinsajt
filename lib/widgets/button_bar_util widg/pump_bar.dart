import 'package:cacicoinsajt/widgets/button_bar_util%20widg/movingsandw.dart';
import 'package:cacicoinsajt/widgets/button_bar_util%20widg/pumpajcacicoine.dart';
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
    14,
  ); // Početni datum presale-a, menjaj za ui
  final int durationInDays = 30;
  bool isLoading = false;

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
        //TODO: nasminkaj bar
        //
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

        // TODO: BUTTON KAD SMISLIMO
        PumpajCaciButton(websiteUrl: "cacicoin.com"),
      ],
    );
  }
}
