import 'dart:ui' as ui;
import 'dart:html'; // za IFrameElement
import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class UputstvoButton extends StatefulWidget {
  const UputstvoButton({super.key});

  @override
  State<UputstvoButton> createState() => _UputstvoButtonState();
}

class _UputstvoButtonState extends State<UputstvoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  Widget _buildIframe(String videoId, String viewId) {
    // Registruj view samo jednom
    // Moraš koristiti jedinstveni viewId za svaki video
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final IFrameElement element =
          IFrameElement()
            ..width = '100%'
            ..height = '100%'
            ..src = 'https://www.youtube.com/embed/$videoId'
            ..style.border = 'none'
            ..allowFullscreen = true;
      return element;
    });

    return SizedBox(height: 200, child: HtmlElementView(viewType: viewId));
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: _toggleExpansion,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Uputstvo', style: dekkoTextStyleWhite),
              const SizedBox(width: 8),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                _buildIframe('2Drca5ZSGfI', 'yt_iframe_1'),
                const SizedBox(height: 8),
                _buildIframe('jkyUXIY3NmU', 'yt_iframe_2'),
                const SizedBox(height: 8),
                _buildIframe('F-489Q-MYH8', 'yt_iframe_3'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
