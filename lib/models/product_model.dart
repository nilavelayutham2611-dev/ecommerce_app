class ProductModel {

  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.stock,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json["_id"],
      name: json["name"],
      description:
          json["description"],

      price:
          json["price"]
              .toDouble(),

      image:
          json["image"],

      category:
          json["category"],

      stock:
          json["stock"],
    );
  }
}