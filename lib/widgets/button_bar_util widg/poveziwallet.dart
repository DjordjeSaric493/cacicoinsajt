import 'package:flutter/material.dart';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

@js.JS('window.checkWeb3Provider')
external dynamic checkWeb3ProviderJs();

@js.JS('window.requestAccount')
external dynamic requestAccountJs();

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

  Future<void> connectWallet() async {
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
            content: Text("Greška: ${e.toString()}"),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
