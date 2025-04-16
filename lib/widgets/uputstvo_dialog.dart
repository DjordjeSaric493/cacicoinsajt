import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UputstvosrbDialog extends StatefulWidget {
  const UputstvosrbDialog({super.key});

  @override
  State<UputstvosrbDialog> createState() => _UputstvosrbDialogState();
}

class _UputstvosrbDialogState extends State<UputstvosrbDialog> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/2Drca5ZSGfI?si=Qvv5DLYpUPHkErHV',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _controller2 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/jkyUXIY3NmU?si=N6F6oXn7w3LWL5GG',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _controller3 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/F-489Q-MYH8?si=c9XTHr083yDz_dv1',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPlayer(_controller1, "1. Kreiranje MetaMask naloga"),
              const SizedBox(height: 16),
              _buildPlayer(_controller2, "2. Kupovina BNB na Binance"),
              const SizedBox(height: 16),
              _buildPlayer(_controller3, "3. Import CaciCoin"),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Zatvori'),
        ),
      ],
    );
  }

  Widget _buildPlayer(YoutubePlayerController controller, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        YoutubePlayer(controller: controller, showVideoProgressIndicator: true),
      ],
    );
  }
}
