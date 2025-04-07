import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:cacicoinsajt/widgets/widg2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Uputstvosrb extends StatefulWidget {
  final Function(double amount, Function(bool success) callback) onPurchase;

  const Uputstvosrb({
    super.key,
    required this.onPurchase,
  }); //TODO:IZMENI DA NE MORA DA IMA ONPURCHASE OVDE KAO REQUIRED

  @override
  State<Uputstvosrb> createState() => _UputstvosrbState();
}

enum InstructionItemLayout { defaultLayout, columnWithImage }

class _UputstvosrbState extends State<Uputstvosrb> {
  final TextEditingController _amountController = TextEditingController();
  bool _isProcessing = false;
  bool _showSuccess = false;
  double _maxCaciCoins = 1000000; // Example max limit for presale

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final sideMargin = isMobile ? 8.0 : 32.0;
        final textFieldWidth = isMobile ? constraints.maxWidth * 0.4 : 150.0;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? constraints.maxWidth : 700,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sideMargin,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Item 0
                    _buildBaseItem(
                      index: 0,
                      isMobile: isMobile,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Kreiraj MetaMask wallet ukoliko ga nemaš',
                                  style: dekkoTextSmall,
                                ),
                                Text(
                                  'i dodaj kao ekstenziju na pregledaču',
                                  style: dekkoTextSmall,
                                ),
                              ],
                            ),
                          ),
                          _buildResponsiveImage(
                            context,
                            'assets/arright.png',
                            isMobile,
                            size: 0.08,
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final Uri url = Uri.parse('https://metamask.io/');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                71,
                                71,
                                71,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              'Napravi e-wallet',
                              style:
                                  deliciousTextStyleSmallWhite, // Directly using the TextStyle
                            ),
                          ),
                        ],
                      ),
                    ),
                    Widg2(
                      text: '2. Napravi konekciju ka Binance Smart Chain',
                      additionalText: 'Pratite uputstva',
                      images: [
                        'assets/image3.png',
                        'assets/image4.png',
                        'assets/image5.png',
                      ],
                      isMobile: MediaQuery.of(context).size.width < 600,
                    ),
                    _buildInstructionItem(
                      index: 2,
                      isMobile: isMobile,
                      contentLayout:
                          InstructionItemLayout
                              .columnWithImage, // Use a custom layout
                      text: '3. Dodaj BNB u wallet, kupi ga na sajtu',
                      additionalText: '- www.binance.com',
                      additionalTextStyle: dekkoTextSmall,
                      note:
                          'Ukoliko nemate nalog na sajtu, potrebno ga je kreirati.',
                      noteTextStyle: TextStyle(fontSize: 14),
                      leftWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3. Dodaj BNB u wallet, kupi ga na sajtu',
                            style: dekkoTextSmall,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width:
                                constraints.maxWidth *
                                (isMobile ? 0.6 : 0.21), // 70% of 30% less
                            child: ElevatedButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(
                                  'https://www.binance.com/',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  71,
                                  71,
                                  71,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                              child: Text(
                                'binance sajt',
                                style: dekkoTextSmallWhite,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ukoliko nemate nalog na sajtu, potrebno ga je kreirati.',
                            style: dekkoTextSmall,
                          ),
                        ],
                      ),
                      middleWidget: _buildResponsiveImage(
                        context,
                        'assets/arright.png',
                        isMobile,
                        size: 0.12 * 0.60, // 160%  od original size
                      ),
                      rightWidget: _buildResponsiveImage(
                        context,
                        'assets/conv.png',
                        isMobile,
                        height: 120 * 1.5,
                      ),
                    ),
                    _buildBaseItem(
                      index: 3,
                      isMobile: isMobile,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4. Izaberi količinu ĆaciCoina koju želiš da kupiš:',
                            style:
                                dekkoTextSmall, // Directly using the TextStyle
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              SizedBox(
                                width: textFieldWidth,
                                child: TextField(
                                  controller: _amountController,
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
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '= ${_calculateTokenAmount(_amountController.text)} ĆACI-a',
                                style: dekkoTextSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildConfirmationItem(index: 4, isMobile: isMobile),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructionItem({
    required int index,
    required bool isMobile,
    InstructionItemLayout contentLayout = InstructionItemLayout.defaultLayout,
    required String text,
    TextStyle? textStyle,
    String? additionalText,
    TextStyle? additionalTextStyle,
    String? note,
    TextStyle? noteTextStyle,
    List<String> images = const [],
    Widget? button,
    Widget? leftWidget,
    Widget? middleWidget,
    Widget? rightWidget,
  }) {
    return _buildBaseItem(
      index: index,
      isMobile: isMobile,
      child:
          contentLayout == InstructionItemLayout.columnWithImage
              ? Row(
                children: [
                  Expanded(child: leftWidget ?? SizedBox()),
                  if (middleWidget != null) ...[
                    const SizedBox(width: 16),
                    middleWidget,
                    const SizedBox(width: 16),
                  ],
                  if (rightWidget != null)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: rightWidget,
                      ),
                    ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text section
                  Text(text, style: textStyle ?? _getTextStyleForItem(index)),
                  if (additionalText != null)
                    Text(
                      additionalText,
                      style: additionalTextStyle ?? _getTextStyleForItem(index),
                    ),

                  // Button (
                  if (button != null) ...[const SizedBox(height: 8), button],

                  // Note
                  if (note != null) ...[
                    const SizedBox(height: 8),
                    Text(note, style: noteTextStyle ?? TextStyle(fontSize: 14)),
                  ],

                  // Images section
                  if (images.isNotEmpty &&
                      contentLayout !=
                          InstructionItemLayout.columnWithImage) ...[
                    const SizedBox(height: 16),
                    isMobile
                        ? Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              images
                                  .map(
                                    (img) => _buildResponsiveImage(
                                      context,
                                      img,
                                      isMobile,
                                      size: 0.12,
                                    ),
                                  )
                                  .toList(),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              images
                                  .map(
                                    (img) => Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: _buildResponsiveImage(
                                        context,
                                        img,
                                        isMobile,
                                        size: 0.12,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                  ],
                ],
              ),
    );
  }

  TextStyle _getTextStyleForItem(int index) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: index.isEven ? Colors.black87 : Colors.black,
    );
  }

  Widget _buildConfirmationItem({required int index, required bool isMobile}) {
    return _buildBaseItem(
      index: index,
      isMobile: isMobile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('5. Potvrdi transakciju', style: dekkoTextStyle),
          const SizedBox(height: 16),
          if (_showSuccess)
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Transakcija uspešna!',
                  style: GoogleFonts.dekko(color: Colors.green, fontSize: 30),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '(max. količina ??? Ćacija po osobi)',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _isProcessing ? null : _handlePurchase,
                  child:
                      _isProcessing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'POTVRDI KUPOVINU',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBaseItem({
    required int index,
    required bool isMobile,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
      decoration: BoxDecoration(
        color: index.isEven ? const Color(0xFFEFEFEF) : Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _buildResponsiveImage(
    BuildContext context,
    String assetPath,
    bool isMobile, {
    double size = 0.15,
    double? height,
  }) {
    final width =
        isMobile
            ? MediaQuery.of(context).size.width * size
            : height ?? (MediaQuery.of(context).size.width * size * 0.5);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        width: width,
        height: height ?? width,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) => Container(
              width: width,
              height: height ?? width,
              color: Colors.grey[200],
              child: Icon(
                Icons.image,
                size: width * 0.5,
                color: Colors.grey[600],
              ),
            ),
      ),
    );
  }

  void _handlePurchase() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) return;

    setState(() => _isProcessing = true);

    widget.onPurchase(amount, (success) {
      setState(() {
        _isProcessing = false;
        _showSuccess = success;
      });

      if (success) {
        _amountController.clear();
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _showSuccess = false);
        });
      }
    });
  }

  String _calculateTokenAmount(String bnbAmount) {
    final amount = double.tryParse(bnbAmount) ?? 0;
    return (amount * 10000).toStringAsFixed(2);
  }
}
