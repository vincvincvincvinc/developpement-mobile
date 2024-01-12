import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';
import '../page/payment_page.dart';



class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EPSI Shop"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Votre panier total est de"),
                Text(context.watch<Cart>().priceTotalInEuro()),
              ],
            ),
            // New button
            ElevatedButton(
              onPressed: () {
                if (context.read<Cart>().items.isNotEmpty) {
                  // naviguer à la page de paiment
                  context.go('/payment');
                }
              },
              child: Text("Procéder au paiement"),
            ),
          ],
        ),
      ),
    );
  }
}


class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Votre panier total est de"), Text("0.00€")],
        ),
        Spacer(),
        Text("Votre panier est actuellement vide"),
        Icon(Icons.image),
        Spacer()
      ],
    );
  }
}

class ListCart extends StatelessWidget {
  const ListCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, cart, _) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Votre panier total est de"),
                    Text(cart.priceTotalInEuro())
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) => ListTile(
                            leading: Image.network(cart.items[index].image),
                            title: Text(cart.items[index].nom),
                            subtitle: Text(
                              cart.items[index].getPrixEuro(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //Supprimer un élément du panier
                            trailing: TextButton(
                              child: const Text("SUPPRIMER"),
                              onPressed: () => context
                                  .read<Cart>()
                                  .removeArticle(cart.items[index]),
                            ),
                          )),
                ),
              ],
            ));
  }
}
