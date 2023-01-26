import 'package:flutter/material.dart';

import 'item.dart';

class CartProvider with ChangeNotifier {
  final List<Item> basketItems = [];
  int totalePhones = 0;
  double totalePrice = 0;
  final List<Item> items = [
    Item(name: 'Redmi Note 8', price: 80),
    Item(name: 'POCO X3', price: 100),
    Item(name: 'POCO X3 PRO', price: 150),
    Item(name: 'S20 Utlra', price: 400),
    Item(name: 'Iphone 11', price: 500),
  ];
  void addItem(Item newItem) {
    totalePhones++;
    for (var i = 0; i < basketItems.length; i++) {
      if (basketItems[i].name == newItem.name) {
        basketItems[i].number = basketItems[i].number! + 1;
        totalePrice += newItem.price!;
        notifyListeners();
        return;
      }
    }
    basketItems.add(Item(name: newItem.name, price: newItem.price, number: 1));

    totalePrice += newItem.price!;
    notifyListeners();
  }

  removeItem(Item removedItem) {
    totalePhones--;
    for (var i = 0; i < basketItems.length; i++) {
      if (basketItems[i].name == removedItem.name) {
        if (basketItems[i].number == 1) {
          basketItems.remove(removedItem);
          totalePrice -= removedItem.price!;
          notifyListeners();
          return;
        }
        basketItems[i].number = basketItems[i].number! - 1;
        totalePrice -= removedItem.price!;
        notifyListeners();
        return;
      }
    }
  }

  addProducts(String newName, double newPrice) {
    items.add(Item(name: newName, price: newPrice));
    notifyListeners();
  }
}
