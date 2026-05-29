import 'product_model.dart';

class OrderModel {

  final String id;
  final double totalAmount;
  final String status;
  final List<OrderItem>
      items;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.items,
  });

  factory OrderModel.fromJson(
    Map<String, dynamic>
        json,
  ) {
    return OrderModel(
      id: json["_id"],

      totalAmount:
          json["totalAmount"]
              .toDouble(),

      status:
          json["status"],

      items:
          (json["items"]
                  as List)
              .map(
                (item) =>
                    OrderItem
                        .fromJson(
                  item,
                ),
              )
              .toList(),
    );
  }
}

class OrderItem {

  final ProductModel
      product;

  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  factory OrderItem.fromJson(
    Map<String, dynamic>
        json,
  ) {
    return OrderItem(
      product:
          ProductModel
              .fromJson(
        json["product"],
      ),

      quantity:
          json["quantity"],
    );
  }
}