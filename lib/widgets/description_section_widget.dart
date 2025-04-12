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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Builder(
                                builder: (context) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.7,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            child: Text(
                                              OpisCacijaSrb.opis,
                                              style: GoogleFonts.dekko(
                                                fontSize: 50,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Auto-scroll:'),
                                            Switch(
                                              value: _autoScroll,
                                              onChanged: (value) {
                                                setState(() {
                                                  _autoScroll = value;
                                                  if (_autoScroll)
                                                    _startAutoScroll();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
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
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Builder(
                                builder: (context) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.7,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            child: Text(
                                              OpisCacijaSrb.opis,
                                              style: GoogleFonts.dekko(
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Auto-scroll:'),
                                            Switch(
                                              value: _autoScroll,
                                              onChanged: (value) {
                                                setState(() {
                                                  _autoScroll = value;
                                                  if (_autoScroll)
                                                    _startAutoScroll();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
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
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  AppStringsSrb.whoAreWeDescription,
                  style: dekkoTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
