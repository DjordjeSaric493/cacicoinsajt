import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart'; // For validating wallet format
import 'dart:html' as html; // Import for web download

class PixelArtUploadForm extends StatefulWidget {
  const PixelArtUploadForm({super.key});

  @override
  State<PixelArtUploadForm> createState() => _PixelArtUploadFormState();
}

class _PixelArtUploadFormState extends State<PixelArtUploadForm> {
  final supabase = Supabase.instance.client;
  final Uuid uuid = const Uuid();

  Uint8List? _originalImage;
  Uint8List? _editedImage;
  img.Image? _decodedImage;
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _caciController = TextEditingController(
    text: "caci",
  );
  final TextEditingController _walletController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _wordController.dispose();
    _caciController.dispose();
    _walletController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      final decoded = img.decodeImage(Uint8List.fromList(image));
      if (decoded == null) {
        _showError("Error decoding image");
        return;
      }

      final resizedImage = img.copyResize(decoded, width: 300, height: 300);
      final pixelizedImage = _pixelizeImage(resizedImage);

      setState(() {
        _originalImage = image;
        _decodedImage = decoded;
        _editedImage = Uint8List.fromList(img.encodePng(pixelizedImage));
      });
    }
  }

  img.Image _pixelizeImage(img.Image image, {int pixelSize = 10}) {
    final pixelized = img.Image(width: image.width, height: image.height);

    for (int y = 0; y < image.height; y += pixelSize) {
      for (int x = 0; x < image.width; x += pixelSize) {
        final colorPixel = image.getPixel(x, y);
        for (int dy = 0; dy < pixelSize && y + dy < image.height; dy++) {
          for (int dx = 0; dx < pixelSize && x + dx < image.width; dx++) {
            pixelized.setPixel(x + dx, y + dy, colorPixel);
          }
        }
      }
    }

    return pixelized;
  }

  Future<String> _uploadImageToStorage() async {
    if (_editedImage == null) _showError('Unesi sliku!!');

    final imageName = '${uuid.v4()}.png';

    try {
      await supabase.storage
          .from('cacislike') // Ispravljen naziv bucket-a
          .uploadBinary(
            imageName,
            _editedImage!,
            fileOptions: FileOptions(contentType: 'image/png', upsert: false),
          );

      return supabase.storage.from('cacislike').getPublicUrl(imageName);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> _saveToDatabase(String imageUrl) async {
    // Create a combined title from the user's input and "Ćaci"
    final title =
        _wordController.text.trim().isNotEmpty
            ? '${_wordController.text.trim()} Ćaci'
            : 'Ćaci';

    await supabase.from('pixel_art_submissions').insert({
      'image_url': imageUrl,
      'title': title,
      'wallet_id': _walletController.text,
      'status': 'pending',
    });
  }

  bool _isValidWalletId(String walletId) {
    // Proverava da li počinje sa 0x i ima tačno 42 karaktera
    if (!walletId.startsWith('0x') || walletId.length != 42) {
      return false;
    }

    // Proverava da li su preostali karakteri heksadecimalni
    final hexPart = walletId.substring(2);
    return isHexadecimal(hexPart);
  }

  Future<void> _submitForm() async {
    if (_walletController.text.isEmpty) {
      _showError("Molimo unesite Wallet ID");
      return;
    }

    if (!_isValidWalletId(_walletController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loš format wallet-a'),
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    if (_editedImage == null) {
      _showError("Molimo izaberite sliku");
      return;
    }

    setState(() => _isUploading = true);

    try {
      // 1. Upload image to Supabase Storage
      final imageUrl = await _uploadImageToStorage();

      // 2. Save the data to the database
      await _saveToDatabase(imageUrl);

      _showSuccess();
    } catch (e) {
      _showError("Došlo je do greške: ${e.toString()}");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> _downloadImage() async {
    if (_editedImage == null) return;

    final base64 = base64Encode(_editedImage!);
    final anchor = html.AnchorElement(href: 'data:image/png;base64,$base64');
    anchor.download = 'pixel_art.png'; // Naziv preuzete datoteke
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    _showSuccessDownload();
  }

  void _showSuccessDownload() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Uspešno!", style: dekkoTextSmall),
            content: Text("Slika je preuzeta.", style: dekkoTextSmall),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Uspešno!"),
            content: const Text(
              "Vaša slika je uspešno uploadovana i biće pregledana.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close success dialog
                  Navigator.pop(context); // Close upload dialog
                  // Reset form
                  setState(() {
                    _originalImage = null;
                    _editedImage = null;
                    _wordController.clear();
                  });
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Greška"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pixel Ćaci Upload', style: dekkoTextStyleRed),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 20),
          Text(
            'Opis -> Atribut + Ćaci',
            style: dekkoTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Zli Ćaci, Ludi Ćaci',
            style: dekkoTextSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _wordController,
            decoration: const InputDecoration(
              labelText: 'Unesi opis (npr. "Zli")',
              hintText: 'Ostavite prazno za samo "Ćaci"',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _caciController,
            decoration: const InputDecoration(
              labelText: 'Reč fotografija (uvek će biti "Ćaci")',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _walletController,
            decoration: InputDecoration(
              labelText: 'Unesi Wallet ID adresu',
              labelStyle: dekkoTextSmall,
              hintText: '0x... (42 karaktera)',
              border: const OutlineInputBorder(),
              errorText:
                  _walletController.text.isNotEmpty &&
                          !_isValidWalletId(_walletController.text)
                      ? 'Wallet ID mora početi sa 0x i imati tačno 42 karaktera'
                      : null,
            ),
            maxLength: 42,
            onChanged: (value) {
              setState(() {}); // Da bi se osvežila validacija
            },
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Izaberi sliku'),
          ),
          const SizedBox(height: 20),
          if (_editedImage != null) ...[
            const Text("Pregled slike:", textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Image.memory(_editedImage!, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              _wordController.text.trim().isNotEmpty
                  ? '${_wordController.text.trim()} Ćaci'
                  : 'Ćaci',
              textAlign: TextAlign.center,
              style: dekkoTextSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _downloadImage,
              child: const Text("Preuzmi sliku"),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isUploading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            child:
                _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                      "Pošalji i zarađuj Ćacicoin-e",
                      style: dekkoTextSmall,
                    ),
          ),
        ],
      ),
    );
  }
}
