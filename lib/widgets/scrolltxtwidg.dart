import 'package:flutter/material.dart';

class ScrollableTextWidget extends StatefulWidget {
  @override
  _ScrollableTextWidgetState createState() => _ScrollableTextWidgetState();
}

class _ScrollableTextWidgetState extends State<ScrollableTextWidget> {
  final ScrollController _controller = ScrollController();
  bool _autoScroll = false;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 1), () {
      if (_autoScroll && _controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 5),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Text('Scroll.\n' * 10, style: TextStyle(fontSize: 16)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Auto-scroll:'),
              Switch(
                value: _autoScroll,
                onChanged: (value) {
                  setState(() {
                    _autoScroll = value;
                    if (_autoScroll) _startAutoScroll();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
