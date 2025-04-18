import 'package:cacicoinsajt/widgets/button_bar_util%20widg/butt-on/socialbutt.dart';
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
                      style: GoogleFonts.darkerGrotesque(
                        color: Colors.red,
                        fontSize: widget.isMobile ? 24 : 46,
                        fontWeight: FontWeight.w500
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
                          vertical: 18,
                        ),
                        textStyle: GoogleFonts.darkerGrotesque(
                          fontSize: widget.isMobile ? 18 : 24,
                          fontWeight: FontWeight.w500,
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
                      style: GoogleFonts.darkerGrotesque(color: Colors.red, fontSize: 40),
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
                        textStyle: GoogleFonts.darkerGrotesque(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text(AppStringsSrb.descriptionButton),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 80),
              Center(
                child: Text(
                  AppStringsSrb.staJeCaciCoin,
                  style: deliciousTextStyleBig,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppStringsSrb.staJeCaciCoinDescription,
                  style: darkerGrotesqueBlack.copyWith(fontSize: widget.isMobile ? 20 : 28), //isMobile
                  textAlign: TextAlign.justify,
                ),
              ),
              Center(
                child: Text(
                  AppStringsSrb.koSmoMi,
                  style: deliciousTextStyleBig,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppStringsSrb.koSmoMiDescription,
                  style: darkerGrotesqueBlack.copyWith(fontSize: widget.isMobile ? 20 : 28), //isMobile
                  textAlign: TextAlign.justify,
                ),
              ),
            
              const SizedBox(height: 8),
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
