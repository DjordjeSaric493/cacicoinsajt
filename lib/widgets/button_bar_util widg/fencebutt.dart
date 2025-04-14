import 'package:flutter/material.dart';

class FenceButton extends StatefulWidget {
  final String buttonText;
  final Widget nextPage;
  final String fenceImagePath;

  const FenceButton({
    Key? key,
    required this.buttonText,
    required this.nextPage,
    required this.fenceImagePath,
  }) : super(key: key);

  @override
  State<FenceButton> createState() => _FenceButtonState();
}

class _FenceButtonState extends State<FenceButton> {
  bool _animationComplete = false;
  bool _animating = false;

  void _startAnimation() {
    if (!_animating) {
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fenceHeight = 80.0; // Podesite visinu ograde prema potrebi

    return SizedBox(
      width: screenWidth,
      height: fenceHeight,
      child: Stack(
        children: [
          // Dugme koje je inicijalno sakriveno iza ograde
          Positioned.fill(
            child: Center(
              child: Visibility(
                visible: _animationComplete,
                child: ElevatedButton(
                  onPressed: _navigateToNextPage,
                  child: Text(widget.buttonText),
                ),
              ),
            ),
          ),
          // Ograda
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left:
                _animating
                    ? screenWidth
                    : 0, // Kada animacija počne, ograda ide desno
            top: 0,
            child: GestureDetector(
              onTap: _animating ? null : _startAnimation,
              child: SizedBox(
                width: screenWidth / 10,
                height: fenceHeight,
                child: Image.asset(widget.fenceImagePath, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
