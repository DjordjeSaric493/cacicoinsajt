import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Za otvaranje linkova

class UgovoriButton extends StatefulWidget {
  const UgovoriButton({super.key});

  @override
  State<UgovoriButton> createState() => _UgovoriButtonState();
}

class _UgovoriButtonState extends State<UgovoriButton>
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

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _toggleExpansion,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ugovori', style: darkerGrotesqueSmallBlack),
              SizedBox(width: 8),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .stretch, // Promenjeno na stretch da Container zauzme širinu
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300, // Svetlo siva boja za ivicu
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ), // Opciono zaobljene ivice
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ), // Dodatni razmak oko "papira"
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ), // Unutrašnji padding za tekst dugmeta
                    child: ElevatedButton(
                      onPressed:
                          () => _launchURL(
                            'https://bscscan.com/address/0x9e8ccea53ef25f64e244bb1eeaecba8421417c50#code',
                          ),
                      style: ElevatedButton.styleFrom(
                        elevation:
                            0, // Uklanjamo senku dugmeta da bi izgledalo ravnije
                        backgroundColor: Colors.white, // Bela pozadina dugmeta
                        foregroundColor: Colors.black, // Crna boja teksta
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ), // Malo manje zaobljenja od ivice
                        ),
                      ),
                      child: Text('CaciToken Ugovor', style: darkerGrotesqueSmallBlack),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed:
                          () => _launchURL(
                            'https://bscscan.com/address/0x63539cf43ce777c6dfadbe484de53246ce7ef134#code',
                          ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Text('Presale Ugovor', style: darkerGrotesqueSmallBlack),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
