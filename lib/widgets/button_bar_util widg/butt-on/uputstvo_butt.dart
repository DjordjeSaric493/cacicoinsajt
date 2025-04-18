import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UputstvoButton extends StatefulWidget {
  const UputstvoButton({super.key});

  @override
  State<UputstvoButton> createState() => _UputstvoButtonState();
}

class _UputstvoButtonState extends State<UputstvoButton> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late InAppWebViewGroupOptions options;

  @override
  void initState() {
    super.initState();
    options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildWebView(String url) {
    return SizedBox(
      height: 200,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        initialOptions: options,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Text('Uputstvo', style: darkerGrotesqueSmallWhite),
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
          child: Column(
            children: [
              const SizedBox(height: 12),
              _buildWebView('https://www.youtube.com/embed/2Drca5ZSGfI'),
              const SizedBox(height: 12),
              _buildWebView('https://www.youtube.com/embed/jkyUXIY3NmU'),
              const SizedBox(height: 12),
              _buildWebView('https://www.youtube.com/embed/F-489Q-MYH8'),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }
}
