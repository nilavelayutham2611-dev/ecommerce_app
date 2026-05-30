import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/api_service.dart';

class CartProvider
    extends ChangeNotifier {

  List<CartModel>
      cartItems = [];

  int get cartCount =>
      cartItems.length;

  double get totalPrice {

    double total = 0;

    for (var item
        in cartItems) {

      total +=
          item.product.price *
              item.quantity;
    }

    return total;
  }

  Future<void>
      loadCart() async {

    try {

      cartItems =
          await ApiService
              .getCart();

      notifyListeners();

    } catch (e) {

      debugPrint(
        e.toString(),
      );
    }
  }

  Future<void>
      addToCart(
    String productId,
  ) async {

    await ApiService
        .addToCart(
      productId,
    );

    await loadCart();
  }

  Future<void>
      removeItem(
    String cartId,
  ) async {

    await ApiService
        .removeCartItem(
      cartId,
    );

    await loadCart();
  }

  Future<void>
      checkout() async {

    await ApiService
        .placeOrder();

    cartItems.clear();

    notifyListeners();
  }
}