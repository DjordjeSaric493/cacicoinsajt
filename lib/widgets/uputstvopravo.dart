import 'package:flutter/material.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CaciPopupCard extends StatelessWidget {
  const CaciPopupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Uputstvo za ĆaciCoins', style: dekkoTextStyle),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            body: _buildContent(context), // Prosleđujemo context
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Primamo context
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepCard(
            context: context, // Prosleđujemo context
            step: 1,
            title: 'Kreiraj MetaMask wallet',
            description: 'Dodaj ekstenziju na pregledaču i osveži sajt',
            action: ElevatedButton(
              onPressed: () => _launchUrl('https://metamask.io/'),
              style: _buttonStyle(),
              child: Text('Napravi e-wallet', style: dekkoTextSmallWhite),
            ),
            //image: 'assets/arright.png',
          ),

          const SizedBox(height: 16),

          _buildStepCard(
            context: context, // Prosleđujemo context
            step: 2,
            title: 'Poveži se sa Binance Smart Chain',
            description: 'Pratite uputstva',
            images: [
              'assets/image3.png',
              'assets/image4.png',
              'assets/image5.png',
            ],
          ),

          const SizedBox(height: 16),

          _buildStepCard(
            context: context, // Prosleđujemo context
            step: 3,
            title: 'Dodaj BNB u wallet',
            description: 'Kupi BNB na Binance sajtu',
            action: ElevatedButton(
              onPressed: () => _launchUrl('https://www.binance.com/'),
              style: _buttonStyle(),
              child: Text('binance sajt', style: dekkoTextSmallWhite),
            ),
            note: 'Ukoliko nemate nalog, potrebno ga je kreirati',
          ),

          const SizedBox(height: 16),

          _buildStepCard(
            context: context, // Prosleđujemo context
            step: 4,
            title: 'Unesite količinu i kupite ĆaciCoin-e',
            description: 'Pratite uputstva za povezivanje',
            images: ['uput.png'],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required BuildContext context, // Primamo BuildContext
    required int step,
    required String title,
    String? description,
    String? note,
    Widget? action,
    Widget? content,
    String? image,
    List<String>? images,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: step.isEven ? const Color(0xFFEFEFEF) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$step. $title', style: dekkoTextStyle),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(description, style: dekkoTextSmall),
            ),

          if (content != null)
            Padding(padding: const EdgeInsets.only(top: 16), child: content),

          if (action != null || image != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                // Promenjeno iz Row u Column da bi tekst bio ispod slike
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (action != null) action,
                      if (image != null)
                        GestureDetector(
                          onTap: () {
                            _showImageDialog(
                              context,
                              image,
                            ); // Prikazujemo dijalog
                          },
                          child: Image.asset(image, width: 60, height: 60),
                        ),
                    ],
                  ),
                  if (image != null) // Dodajemo tekst samo ako postoji slika
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Klikni na sliku za uvećanje',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),

          if (images != null && images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                // Promenjeno iz Row u Column da bi tekst bio ispod slika
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          images
                              .map(
                                (img) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                        context,
                                        img,
                                      ); // Prikazujemo dijalog
                                    },
                                    child: Image.asset(
                                      img,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Klikni na sliku za uvećanje',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

          if (note != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(note, style: const TextStyle(fontSize: 14)),
            ),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 71, 71, 71),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  // Funkcija za prikazivanje uvećane slike u dijalogu
  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: <Widget>[
              SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.8, // Prilagodite širinu po potrebi
                child: Image.asset(imagePath),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TokenAmountInput extends StatefulWidget {
  const _TokenAmountInput();

  @override
  State<_TokenAmountInput> createState() => _TokenAmountInputState();
}

class _TokenAmountInputState extends State<_TokenAmountInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '0.00',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '= ${_calculateTokenAmount(_controller.text)} ĆACI-a',
          style: dekkoTextSmall,
        ),
      ],
    );
  }

  String _calculateTokenAmount(String bnbAmount) {
    final amount = double.tryParse(bnbAmount) ?? 0;
    return (amount * 10000).toStringAsFixed(2);
  }
}
