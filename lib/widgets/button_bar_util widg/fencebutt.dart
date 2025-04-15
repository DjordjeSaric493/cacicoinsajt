import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart'; // Pretpostavljam da ovde imate definisan stil za tekst

class FenceButton extends StatefulWidget {
  final String? buttonText;
  final String fenceImagePath;
  final TextStyle? buttonTextStyle; // Dodatni parametar za stil teksta dugmeta

  const FenceButton({
    Key? key,
    this.buttonText,
    required this.fenceImagePath,
    this.buttonTextStyle, // Inicijalizujte novi parametar
  }) : super(key: key);

  @override
  State<FenceButton> createState() => _FenceButtonState();
}

class _FenceButtonState extends State<FenceButton> {
  bool _animationComplete = false;
  bool _animating = false;
  double _buttonWidth = 140.0; // Pretpostavljena širina dugmeta

  void _startAnimation() {
    if (!_animating && !_animationComplete) {
      setState(() {
        _animating = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _animationComplete = true;
          _animating = false;
        });
      });
    }
  }

  void _navigateToNextPage() {
    if (_animationComplete) {
      Navigator.pushNamed(context, '/cacilend');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final originalFenceHeight = 100.0;
    final fenceHeight = originalFenceHeight * 1.3;
    final fenceWidth = _buttonWidth * 1.2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: screenWidth,
          height: fenceHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: _animationComplete,
                child: SizedBox(
                  width: _buttonWidth,
                  height: fenceHeight,
                  child: ElevatedButton(
                    onPressed: _navigateToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Svetlosiva boja pozadine
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: Center(
                      // Explicitno centriranje teksta
                      child: Text(
                        "?",
                        style:
                            widget.buttonTextStyle ??
                            dekkoTextStyle.copyWith(
                              fontSize: 32,
                            ), // Koristite prosleđeni stil ili podrazumevani
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !_animationComplete,
                child: GestureDetector(
                  onTap: _animating ? null : _startAnimation,
                  child: SizedBox(
                    width: fenceWidth,
                    height: fenceHeight,
                    child: Image.asset(
                      widget.fenceImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _animationComplete ? 'UĐI U ĆACILEND' : 'PROBIJ OGRADU',
          style: dekkoTextStyle.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
