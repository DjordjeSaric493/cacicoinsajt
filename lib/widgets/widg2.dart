import 'package:flutter/material.dart';

class Widg2 extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final String? additionalText; // Corrected spelling
  final List<String> images;
  final bool isMobile;

  const Widg2({
    super.key,
    required this.text,
    this.textStyle,
    this.additionalText, // Corrected spelling
    required this.images,
    required this.isMobile,
  });

  @override
  State<Widg2> createState() => _Widg2State();
}

class _Widg2State extends State<Widg2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.5;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text section
          Text(widget.text, style: widget.textStyle ?? _getDefaultTextStyle()),
          if (widget.additionalText != null)
            Text(
              widget.additionalText!,
              style: widget.textStyle ?? _getDefaultTextStyle(),
            ),

          // Images carousel
          if (widget.images.isNotEmpty) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: imageHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildImageContainer(widget.images[index]),
                  );
                },
              ),
            ),

            // Navigation controls
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed:
                        _currentPage > 0
                            ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                  ),

                  // Page indicator
                  Text(
                    '${_currentPage + 1}/${widget.images.length}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  // Next arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed:
                        _currentPage < widget.images.length - 1
                            ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.broken_image, color: Colors.grey),
                  Text('Image not found', style: _getDefaultTextStyle()),
                ],
              ),
            ),
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }
}
