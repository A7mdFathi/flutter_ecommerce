import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantiy;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantiy,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantiy;
    });
    return total;
  }

  void addItem(
    String prodId,
    String title,
    double price,
  ) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingItem) => CartItem(
                id: existingItem.id,
                title: existingItem.title,
                quantiy: existingItem.quantiy + 1,
                price: existingItem.price,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantiy: 1,
              ));
    }

    notifyListeners();
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }
}
