import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;
import 'package:url_launcher/url_launcher.dart'; // Dodajte ovaj import

@js.JS('window.checkWeb3Provider')
external dynamic checkWeb3ProviderJs();

@js.JS('window.requestAccount')
external dynamic requestAccountJs();

@js.JS('window.localStorage.setItem')
external void localStorageSetItem(String key, String value);

@js.JS('window.localStorage.getItem')
external String? localStorageGetItem(String key);

class ConnectWalletButton extends StatefulWidget {
  final Function(String) onConnected;

  final ButtonStyle? style;
  final String connectedText;
  final String disconnectedText;
  final Widget? connectedIcon;
  final Widget? disconnectedIcon;

  const ConnectWalletButton({
    super.key,
    required this.onConnected,
    this.style,
    this.connectedText = "Povezano ✅",
    this.disconnectedText = "Poveži MetaMask",
    this.connectedIcon,
    this.disconnectedIcon,
  });

  @override
  State<ConnectWalletButton> createState() => _ConnectWalletButtonState();
}

class _ConnectWalletButtonState extends State<ConnectWalletButton> {
  bool isConnected = false;
  String address = '';

  @override
  void initState() {
    super.initState();
    // Proveri da li postoji sačuvana adresa prilikom inicijalizacije widgeta
    final storedAddress = localStorageGetItem('walletAddress');
    if (storedAddress != null && storedAddress.isNotEmpty) {
      setState(() {
        isConnected = true;
        address = storedAddress;
      });
      widget.onConnected(address);
    }
  }

  Future<void> connectWallet() async {
    if (kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        final shouldLaunch = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Poveži se sa MetaMask"),
              content: const Text(
                "Da biste povezali novčanik, bićete preusmereni na MetaMask aplikaciju. "
                "Ako je nemate instaliranu, bićete preusmereni na prodavnicu.",
              ),
              actions: [
                TextButton(
                  child: const Text("Otkaži"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text("Nastavi"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        );

        if (shouldLaunch != true) {
          return; // korisnik je otkazao
        }

        final deepLinkUri = Uri.parse(
          'https://metamask.app.link/dapp/cacicoin.com',
        );

        if (await canLaunchUrl(deepLinkUri)) {
          await launchUrl(deepLinkUri, mode: LaunchMode.externalApplication);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Otvaramo MetaMask aplikaciju..."),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Ne mogu da otvorim MetaMask aplikaciju."),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
          }
        }

        return;
      }

      // Desktop (ekstenzija)
      try {
        final isProviderAvailable = await js_util.promiseToFuture(
          checkWeb3ProviderJs(),
        );

        if (!isProviderAvailable) {
          throw Exception("MetaMask nije pronađen");
        }

        final account = await js_util.promiseToFuture(requestAccountJs());
        setState(() {
          isConnected = true;
          address = account.toString();
        });
        widget.onConnected(address);
        localStorageSetItem('walletAddress', address);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Povezan uspešno 🎉"),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Greška pri povezivanju: ${e.toString()}"),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  /*
  Future<void> connectWallet() async {
    if (kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        final metamaskAppUrl = Uri.parse('https://metamask.app/');
        if (await canLaunchUrl(metamaskAppUrl)) {
          await launchUrl(metamaskAppUrl);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Otvaranje MetaMask aplikacije..."),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          // Ne postavljamo isConnected na true ovde odmah, jer se korisnik tek prebacuje na MetaMask.
          // Stanje će se potencijalno ponovo proveriti kada se korisnik vrati.
        } else {
          // MetaMask aplikacija nije instalirana, preusmeri na prodavnicu
          String appStoreUrl = '';
          if (defaultTargetPlatform == TargetPlatform.android) {
            appStoreUrl =
                'https://play.google.com/store/apps/details?id=io.metamask';
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            appStoreUrl = 'https://apps.apple.com/app/metamask/id1438183784';
          }
          final appStoreUri = Uri.parse(appStoreUrl);
          if (await canLaunchUrl(appStoreUri)) {
            await launchUrl(appStoreUri);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Preusmeravanje na prodavnicu za preuzimanje MetaMask-a.",
                  ),
                  duration: Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Ne mogu da otvorim prodavnicu aplikacija."),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      } else {
        try {
          final isProviderAvailable = await js_util.promiseToFuture(
            checkWeb3ProviderJs(),
          );

          if (!isProviderAvailable) {
            throw Exception("MetaMask nije pronađen");
          }

          final account = await js_util.promiseToFuture(requestAccountJs());
          setState(() {
            isConnected = true;
            address = account.toString();
          });
          widget.onConnected(address);
          localStorageSetItem(
            'walletAddress',
            address,
          ); // Sačuvaj adresu u Local Storage

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Povezan uspešno 🎉"),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          // ... (obrada greške) ...
        }
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: connectWallet,
      style: widget.style,
      icon:
          isConnected
              ? (widget.connectedIcon ?? const Icon(Icons.check))
              : (widget.disconnectedIcon ?? const Icon(Icons.link)),
      label: Text(isConnected ? widget.connectedText : widget.disconnectedText),
    );
  }
}
