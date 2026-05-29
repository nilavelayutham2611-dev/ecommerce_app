import 'product_model.dart';

class CartModel {

  final String id;
  final ProductModel product;
  final int quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CartModel(
      id: json["_id"],

      quantity:
          json["quantity"],

      product:
          ProductModel
              .fromJson(
        json["product"],
      ),
    );
  }
}