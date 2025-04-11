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
  //final Function(String) onLog;
  final BuildContext context;

  const BuyButton({
    super.key,
    required this.isConnected,
    required this.isLoading,
    required this.bnbValue,
    required this.onStart,
    required this.onFinish,
    //required this.onLog,
    required this.context,
  });

  Future<void> buyTokens() async {
    if (!isConnected || bnbValue <= 0) return;

    onStart();
    // onLog("Pokretanje kupovine...");

    try {
      final isCorrectNetwork = await js_util.promiseToFuture(checkNetworkJs());
      // onLog("Provera mreže: $isCorrectNetwork");

      if (!isCorrectNetwork) {
        throw Exception("Prebacite se na Binance Smart Chain");
      }

      final safeBNB = double.parse(bnbValue.toStringAsFixed(18));
      final txHash = await js_util.promiseToFuture(
        sendTransactionJs(safeBNB.toString()),
      );

      //  onLog("Transakcija poslata: $txHash");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Transakcija poslata!\nTX hash: $txHash")),
      );
    } catch (e) {
      // onLog("Greška: ${e.toString()}");
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
      onPressed: isConnected && !isLoading ? buyTokens : null,
      child: isLoading ? const CircularProgressIndicator() : const Text('Kupi'),
    );
  }
}
