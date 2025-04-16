/*import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class UputstvoScreen extends StatefulWidget {
  @override
  _UputstvoScreenState createState() => _UputstvoScreenState();
}

class _UputstvoScreenState extends State<UputstvoScreen> {
  late YoutubePlayerController _youtubeController1;
  late YoutubePlayerController _youtubeController2;
  late YoutubePlayerController _youtubeController3;

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _youtubeController1 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/2Drca5ZSGfI?si=Qvv5DLYpUPHkErHV',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _youtubeController2 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/jkyUXIY3NmU?si=N6F6oXn7w3LWL5GG',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _youtubeController3 = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://youtu.be/F-489Q-MYH8?si=c9XTHr083yDz_dv1',
          )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController1.dispose();
    _youtubeController2.dispose();
    _youtubeController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Uputstvo')),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: Text(
                    'Korak 1: Kreiranje MetaMask naloga',
                    style: dekkoTextSmall,
                  ),
                  content: Column(
                    children: [
                      YoutubePlayer(controller: _youtubeController1),
                      // Dodatni sadržaj za prvi korak, ako je potreban
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    'Korak 2: Kupovina BNB na Binance',
                    style: dekkoTextSmall,
                  ),
                  content: Column(
                    children: [
                      YoutubePlayer(controller: _youtubeController2),
                      // Dodatni sadržaj za drugi korak, ako je potreban
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    'Korak 3: Import CaciCoin',
                    style: dekkoTextSmall,
                  ),
                  content: Column(
                    children: [
                      YoutubePlayer(controller: _youtubeController3),
                      // Dodatni sadržaj za treći korak, ako je potreban
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Personalizovana navigacija između koraka
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentStep > 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep--;
                    });
                  },
                  child: Text("Prethodni korak", style: dekkoTextSmall),
                ),
              if (_currentStep < 2)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep++;
                    });
                  },
                  child: Text("Sledeći korak", style: dekkoTextSmall),
                ),
              if (_currentStep == 2)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0; // Vrati na prvi korak
                    });
                  },
                  child: Text("Počni ponovo", style: dekkoTextSmall),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
*/
