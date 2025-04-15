import 'package:cacicoinsajt/widgets/button_bar_util%20widg/socialbutt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cacicoinsajt/utils/text/appstrings.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';

class DescriptionSection extends StatefulWidget {
  final bool isMobile;
  final double appBarWidth;

  const DescriptionSection({
    super.key,
    required this.isMobile,
    required this.appBarWidth,
  });

  @override
  _DescriptionSectionState createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  final ScrollController _scrollController = ScrollController();
  bool _autoScroll = false;

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 1), () {
      if (_autoScroll && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 60),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.appBarWidth * 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              if (widget.isMobile) ...[
                Column(
                  children: [
                    Text(
                      AppStringsSrb.readDescription,
                      style: GoogleFonts.dekko(
                        color: Colors.red,
                        fontSize: widget.isMobile ? 24 : 46,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/opiscacija');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: GoogleFonts.dekko(
                          fontSize: widget.isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(AppStringsSrb.descriptionButton),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStringsSrb.readDescription,
                      style: GoogleFonts.dekko(color: Colors.red, fontSize: 40),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/opiscacija');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: GoogleFonts.dekko(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(AppStringsSrb.descriptionButton),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 30),
              Center(
                child: Text(
                  AppStringsSrb.whoAreWe,
                  style: deliciousTextStyleBig,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppStringsSrb.whoAreWeDescription,
                  style: dekkoTextStyle,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 15),
              SocialMediaButton(
                isMobile: widget.isMobile,
              ), //widget.isMobile da prati iz parent-a dal je mobilno
            ],
          ),
        ),
      ),
    );
  }
}
