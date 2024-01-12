//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../bo/cart.dart';
import '../bo/payment.dart';
import '../page/cart_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalisation de la commande"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/cart'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Récapitulatif de votre commande"),
            /* add subtotal, TVA, total price */
            Text("Adresse de livraison"),
            /* Add address box */
            Text("Moyen de paiment"),
            PaymentMethodSelection(),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                final success = await PaymentService.processPayment(context.read<Cart>());
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Votre commande est validée")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erreur lors du paiement")),
                  );
                }
              },
              child: Text("Confirmer l'achat"),
            ),

            Text(
              "En cliquant sur confirmer l'achat, vous acceptez les conditions...",
            ),
          ],
        ),
      ),
    );
  }

  /*
  void sendPurchaseRequest() async {
    final purchaseUrl = Uri.parse("http://ptsv3.com/t/EPSISHOPC1/");
    final cartItems = context.read<Cart>().items;
    final List<Map<String, dynamic>> itemsData = cartItems.map((item) => item.toMap()).toList();

    try {
      final response = await http.post(
        purchaseUrl,
        body: {
          'items': itemsData.toString(),
        },
      );
    }
    catch (e) {
      print("Error sending purchase request: $e");
    }
  }
  */

}




class PaymentMethodSelection extends StatefulWidget {
  @override
  _PaymentMethodSelectionState createState() => _PaymentMethodSelectionState();
}




class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaymentMethodIcon("Apple Pay", FontAwesomeIcons.applePay, () {
          updateSelectedMethod("Apple Pay");
        }),
        PaymentMethodIcon("VISA", FontAwesomeIcons.ccVisa, () {
          updateSelectedMethod("VISA");
        }),
        PaymentMethodIcon("Mastercard", FontAwesomeIcons.ccMastercard, () {
          updateSelectedMethod("Mastercard");
        }),
        PaymentMethodIcon("PayPal", FontAwesomeIcons.paypal, () {
          updateSelectedMethod("PayPal");
        }),
      ],
    );
  }

  void updateSelectedMethod(String label) {
    setState(() {
      selectedMethod = label;
    });
  }
}



class PaymentMethodIcon extends StatelessWidget {
  final String label;
  final IconData iconData;
  final VoidCallback onTap;

  const PaymentMethodIcon(this.label, this.iconData, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          FaIcon(iconData, size: 40),
          Text(label),
        ],
      ),
    );
  }
}































