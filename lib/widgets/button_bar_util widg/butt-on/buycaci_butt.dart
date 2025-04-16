import 'package:cacicoinsajt/utils/text/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

@JS('window.checkNetwork')
external dynamic checkNetworkJs();

@JS('window.sendTransaction')
external dynamic sendTransactionJs(dynamic bnbAmount);

class BuyButton extends StatelessWidget {
  final bool isConnected;
  final bool isLoading;
  final double bnbValue;
  final VoidCallback onStart;
  final VoidCallback onFinish;
  final BuildContext context;

  const BuyButton({
    super.key,
    required this.isConnected,
    required this.isLoading,
    required this.bnbValue,
    required this.onStart,
    required this.onFinish,
    required this.context,
  });

  Future<void> buyTokens() async {
    if (!isConnected || bnbValue <= 0) return;

    onStart();

    try {
      final isCorrectNetwork = await js_util.promiseToFuture(checkNetworkJs());

      if (!isCorrectNetwork) {
        throw Exception("Prebacite se na Binance Smart Chain");
      }

      final safeBNB = double.parse(bnbValue.toStringAsFixed(18));
      final txResult = await js_util.promiseToFuture(
        sendTransactionJs(safeBNB.toString()),
      );

      if (txResult == 'mobile_transaction_initiated') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "✅ Otvara se MetaMask aplikacija. Molimo vas da potvrdite kupovinu.",
            ),
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (txResult != null &&
          txResult != 'mobile_transaction_initiated') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Transakcija poslata!\nTX hash: $txResult")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("❌ Transakcija nije poslata ili je otkazana."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Greška: ${e.toString()}")));
    } finally {
      onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 25)),
      onPressed: isConnected && !isLoading ? buyTokens : null,
      child:
          isLoading
              ? const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : Text('Kupi', style: dekkoTextStyle),
    );
  }
}
