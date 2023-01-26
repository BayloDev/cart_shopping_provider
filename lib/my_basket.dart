import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/cart_provider.dart';

class MyBasketShop extends StatelessWidget {
  const MyBasketShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: const Text('My Basket'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${cart.totalePrice.toInt()}\$ / ${cart.totalePhones}',
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: cart.basketItems.length,
              itemBuilder: (context, i) => Card(
                color: Colors.white60,
                child: ListTile(
                  title: Row(
                    children: [
                      Text(cart.basketItems[i].name),
                      Text('   (${cart.basketItems[i].number})'),
                    ],
                  ),
                  subtitle: Text('${cart.basketItems[i].price} \$'),
                  trailing: IconButton(
                    onPressed: () => cart.removeItem((cart.basketItems[i])),
                    icon: const Icon(Icons.remove),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
