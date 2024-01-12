import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);
  void showConfirmationSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Votre achat a été confirmé let\'s gooo!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalisation de la commande"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OutlineCardWidget(
              title: "Récapitulatif de la commande",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sous-total:"),
                      Text("${getSubtotal(context)} €"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vous économisez",
                        style: TextStyle(
                          color: Colors.green, // Couleur verte
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "-0.01€",
                        style: TextStyle(
                          color: Colors.green, // Couleur verte
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TVA"),
                      Text("${getTVA()}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TOTAL"),
                      Text("${getTotal()}"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Adresse de Livraison",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            OutlineCardWidget(title: "Michel le Poney", content: YourSecondContent()),
            SizedBox(height: 16),
            Text(
              "En cliquant sur \"Confirmer l'achat\", vous acceptez les conditions de vente de EPSI Shop International. Besoin d'aide ? Désolé on ne peut rien faire. En poursuivant, vous acceptez les Conditions d'utilisation du fournisseur de paiement CoffeeDis.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showConfirmationSnackbar(context);
        },
        label: const Text("Confirmer l'achat"),
        icon: const Icon(Icons.check),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );


  }


  String getSubtotal(BuildContext context) {
    Cart cart = context.read<Cart>();
    return cart.priceTotalInEuro();
  }

  double getTVA() {
    return 10.0;
  }

  double getTotal() {
    return 110.0;
  }
}

class OutlineCardWidget extends StatelessWidget {
  final String title;
  final Widget content;

  const OutlineCardWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}

class YourSecondContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("8 rue des ouvertures de portes, 93204 CORBEAUX"),
    );
  }
}
