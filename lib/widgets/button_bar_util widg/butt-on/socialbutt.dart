import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Za Font Awesome ikone
import 'package:cacicoinsajt/utils/text/textstyles.dart'; // Pretpostavljam da ovde imate definisan stil za tekst
import 'package:url_launcher/url_launcher.dart'; // Dodajte ovaj import

class SocialMediaButton extends StatefulWidget {
  final bool isMobile;

  const SocialMediaButton({Key? key, required this.isMobile}) : super(key: key);

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  late AnimationController _instagramController;
  late Animation<double> _instagramAnimation;
  late AnimationController _xController;
  late Animation<double> _xAnimation;
  late AnimationController _discordController;
  late Animation<double> _discordAnimation;

  @override
  void initState() {
    super.initState();
    _instagramController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _instagramAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _instagramController, curve: Curves.easeInOut),
    );
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _xAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _xController, curve: Curves.easeInOut));
    _discordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _discordAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _discordController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant SocialMediaButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isExpanded && !_instagramController.isCompleted) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () => _instagramController.forward(),
      );
      Future.delayed(
        const Duration(milliseconds: 200),
        () => _xController.forward(),
      );
      Future.delayed(
        const Duration(milliseconds: 300),
        () => _discordController.forward(),
      );
    } else if (!_isExpanded) {
      _instagramController.reverse();
      _xController.reverse();
      _discordController.reverse();
    }
  }

  @override
  void dispose() {
    _instagramController.dispose();
    _xController.dispose();
    _discordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _instagramController.forward();
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => _xController.forward(),
                  );
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () => _discordController.forward(),
                  );
                } else {
                  _instagramController.reverse();
                  _xController.reverse();
                  _discordController.reverse();
                }
              });
            },
            icon: const Icon(Icons.web),
            label: Text('Mreže', style: darkerGrotesqueWhite),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 70, 70, 70),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 10),
          if (widget.isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAnimatedSocialMediaItem(
                  FontAwesomeIcons.instagram,
                  'Instagram',
                  isMobile: true,
                  animation: _instagramAnimation,
                ),
                _buildAnimatedSocialMediaItem(
                  FontAwesomeIcons.x,
                  'X',
                  isMobile: true,
                  animation: _xAnimation,
                ),
                _buildAnimatedSocialMediaItem(
                  FontAwesomeIcons.discord,
                  'Discord',
                  isMobile: true,
                  animation: _discordAnimation,
                ),
              ],
            )
          else
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedSocialMediaItem(
                    FontAwesomeIcons.instagram,
                    'Instagram',
                    isMobile: false,
                    animation: _instagramAnimation,
                  ),
                  const SizedBox(width: 20),
                  _buildAnimatedSocialMediaItem(
                    FontAwesomeIcons.xTwitter,
                    'X',
                    isMobile: false,
                    animation: _xAnimation,
                  ),
                  const SizedBox(width: 20),
                  _buildAnimatedSocialMediaItem(
                    FontAwesomeIcons.discord,
                    'Discord',
                    isMobile: false,
                    animation: _discordAnimation,
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildAnimatedSocialMediaItem(
    IconData icon,
    String text, {
    required bool isMobile,
    required Animation<double> animation,
  }) {
    return InkWell(
      onTap: () async {
        Uri? url;
        if (text == 'Instagram') {
          url = Uri.parse('https://www.instagram.com/cacicoin/');
        } else if (text == 'X') {
          url = Uri.parse('https://x.com/CaciCoin');
        } else if (text == 'Discord') {
          url = Uri.parse('https://discord.com/invite/x56vRV8N');
        }

        if (url != null && await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ne mogu da otvorim $text link.')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
            isMobile
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (text == 'Discord')
                      Padding(
                        // Dodajte padding samo za Discord ikonicu
                        padding: const EdgeInsets.only(
                          bottom: 2.0,
                        ), // Probajte sa različitim vrednostima
                        child: Icon(icon, size: 30),
                      )
                    else
                      Icon(icon, size: 30),
                    const SizedBox(height: 5),
                    FadeTransition(
                      opacity: animation,
                      child: Text(
                        text,
                        style: darkerGrotesqueBlack.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 30),
                    const SizedBox(width: 10),
                    FadeTransition(
                      opacity: animation,
                      child: Text(
                        text,
                        style: darkerGrotesqueBlack.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
