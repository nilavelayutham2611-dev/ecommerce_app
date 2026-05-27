import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class HomeScreen
    extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen>
      createState() =>
          _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  late Future<
      List<ProductModel>>
      productsFuture;

  @override
  void initState() {
    super.initState();

    productsFuture =
        ApiService
            .getProducts();
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          "Products",
        ),
      ),

      body: FutureBuilder<
          List<ProductModel>>(
        future:
            productsFuture,

        builder:
            (context,
                snapshot) {

          if (snapshot
                  .connectionState ==
              ConnectionState
                  .waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot
              .hasError) {

            return Center(
              child: Text(
                snapshot.error
                    .toString(),
              ),
            );
          }

          final products =
              snapshot.data!;

          return ListView.builder(
            itemCount:
                products.length,

            itemBuilder:
                (context,
                    index) {

              final product =
                  products[
                      index];

              return Card(
                margin:
                    const EdgeInsets
                        .all(
                            10),

                child:
                    ListTile(
                       onTap: () {
                              Navigator.push(
                                   context,
                                 MaterialPageRoute(
                                  builder: (_) =>
                                    ProductDetailsScreen(
                                      product: product,
                                     ),
                                 ),
                               );
                         },
                  leading:
                      const Icon(
                    Icons
                        .shopping_bag,
                  ),

                  title: Text(
                    product
                        .name,
                  ),

                  subtitle:
                      Text(
                    "₹${product.price}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}