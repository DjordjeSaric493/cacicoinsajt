import 'dart:async';
import 'package:flutter/material.dart';

class CrtTokenomicsMonitor extends StatefulWidget {
  const CrtTokenomicsMonitor({super.key});

  @override
  State<CrtTokenomicsMonitor> createState() => _CrtTokenomicsMonitorState();
}

class _CrtTokenomicsMonitorState extends State<CrtTokenomicsMonitor> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    // Pokreće blink svakih 3 sekunde
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent, width: isMobile ? 6 : 8),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildCrtEffect(),
          _buildScanLines(),
          _buildScreenCurvature(),
          Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: _buildFramedText(
                    context,
                    'ĆACICOIN TOKENOMICS',
                    fontSize: isMobile ? 20 : 24,
                    bold: true,
                  ),
                ),
                const SizedBox(height: 20),
                _buildFramedText(context, 'TOTAL SUPPLY: 100,000,000,000 ĆACI'),
                _buildFramedText(
                  context,
                  'PRESALE RATE: 1 ĆACI = 0.0000001 BNB',
                ),
                /* if (!isMobile)
                  _buildFramedText(
                    context,
                    '= 0.0069 RSD = 0.000063 USD = 0.000055 EUR',
                  ),*/
                _buildFramedText(
                  context,
                  'PRESALE DOSTUPNO: 10,000,000,000 ĆACI',
                ),
                _buildFramedText(
                  context,
                  'HUMANITARNI DEO: 20,000,000,000 ĆACI',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFramedText(
    BuildContext context,
    String text, {
    double? fontSize,
    bool bold = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveFontSize =
        fontSize ??
        (screenWidth < 400
            ? 10.0
            : screenWidth < 600
            ? 12.0
            : 14.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(-2, -2),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black,
              offset: const Offset(2, 2),
              blurRadius: 0,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: effectiveFontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Courier',
            shadows: const [Shadow(blurRadius: 10, color: Colors.green)],
          ),
        ),
      ),
    );
  }

  Widget _buildCrtEffect() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.5,
              colors: [Colors.black.withOpacity(0.1), Colors.transparent],
              stops: const [0.1, 1.0],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanLines() {
    return Positioned.fill(
      child: IgnorePointer(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
              stops: const [0.95, 1.0],
              tileMode: TileMode.repeated,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
          child: Container(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildScreenCurvature() {
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.3),
                width: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
