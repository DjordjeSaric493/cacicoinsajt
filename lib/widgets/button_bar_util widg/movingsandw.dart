import 'package:flutter/material.dart';

class MovingSandwichIndicator extends StatefulWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? sandwichColor1;
  final Color? sandwichColor2;
  final Color? sandwichColor3;
  final double minHeight;

  const MovingSandwichIndicator({
    Key? key,
    this.value,
    this.backgroundColor = Colors.grey,
    this.sandwichColor1 = Colors.brown,
    this.sandwichColor2 = Colors.yellow,
    this.sandwichColor3 = Colors.green,
    this.minHeight = 10.0,
  }) : super(key: key);

  @override
  _MovingSandwichIndicatorState createState() =>
      _MovingSandwichIndicatorState();
}

class _MovingSandwichIndicatorState extends State<MovingSandwichIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sandwichWidth = width * 0.14; // Prilagodite širinu sendviča
    final horizontalOffset = sandwichWidth * _animation.value;

    return SizedBox(
      height: widget.minHeight * 3, // Povećajte visinu za sendvič
      child: Stack(
        clipBehavior: Clip.none, // Da bi sendvič mogao da se pomera van granica
        children: [
          // Pozadinska traka
          Container(
            height: widget.minHeight,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.minHeight / 2),
            ),
          ),
          // Animirani sendvič
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: (width - sandwichWidth) / 1.4 + horizontalOffset,
                top: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gornja kriška hleba
                    Container(
                      width: sandwichWidth,
                      height: widget.minHeight,
                      decoration: BoxDecoration(
                        color: widget.sandwichColor1,
                        borderRadius: BorderRadius.circular(
                          widget.minHeight / 1.5,
                        ),
                      ),
                    ),
                    // Fil
                    Container(
                      width: sandwichWidth * 0.8,
                      height: widget.minHeight,
                      color: widget.sandwichColor2,
                    ),
                    // Druga vrsta fila
                    Container(
                      width: sandwichWidth * 0.6,
                      height: widget.minHeight,
                      color: widget.sandwichColor3,
                    ),
                    // Donja kriška hleba
                    Container(
                      width: sandwichWidth,
                      height: widget.minHeight,
                      decoration: BoxDecoration(
                        color: widget.sandwichColor1,
                        borderRadius: BorderRadius.circular(
                          widget.minHeight / 2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
