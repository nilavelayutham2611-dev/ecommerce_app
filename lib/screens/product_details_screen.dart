import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailsScreen
    extends StatelessWidget {

  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            Text(product.name),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
                20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(
              height: 220,
              width:
                  double.infinity,

              color:
                  Colors.grey[300],

              child:
                  const Icon(
                Icons
                    .shopping_bag,
                size: 100,
              ),
            ),

            const SizedBox(
                height: 20),

            Text(
              product.name,
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 10),

            Text(
              "₹${product.price}",
              style:
                  const TextStyle(
                fontSize: 22,
                color:
                    Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 15),

            Text(
              product.description,
              style:
                  const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(
                height: 20),

            Text(
              "Stock: ${product.stock}",
            ),

            const Spacer(),

            SizedBox(
              width:
                  double.infinity,

              child:
                  ElevatedButton(
                onPressed: () async {

  try {

    await ApiService
        .addToCart(
      product.id,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          "Added to cart",
        ),
      ),
    );

  } catch (e) {

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
},

                child:
                    const Text(
                  "Add To Cart",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}