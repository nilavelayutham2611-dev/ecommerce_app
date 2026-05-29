import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  late Future<List<ProductModel>>
      productsFuture;
      final TextEditingController
    searchController =
        TextEditingController();

List<ProductModel>
    allProducts = [];

List<ProductModel>
    filteredProducts = [];

  @override
  void initState() {
    super.initState();

    loadProducts();
  }
Future<void>
    loadProducts() async {

  final products =
      await ApiService
          .getProducts();

  setState(() {

    allProducts =
        products;

    filteredProducts =
        products;
  });
}
void searchProduct(
    String query) {

  setState(() {

    filteredProducts =
        allProducts.where(
      (product) {

        return product.name
            .toLowerCase()
            .contains(
              query
                  .toLowerCase(),
            );
      },
    ).toList();
  });
}
  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      backgroundColor:
          Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        title:
            const Text(
          "E-Commerce",
        ),

        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const OrdersScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.receipt_long,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
          IconButton(
  onPressed: () async {

    await ApiService
        .logout();

    if (!context.mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  },

  icon: const Icon(
    Icons.logout,
  ),
),
        ],
      ),

      body: Column(
  children: [

    Padding(
      padding:
          const EdgeInsets
              .all(16),

      child: TextField(
        controller:
            searchController,

        onChanged:
            searchProduct,

        decoration:
            InputDecoration(
          hintText:
              "Search products...",

          prefixIcon:
              const Icon(
            Icons.search,
          ),

          filled: true,

          fillColor:
              Colors.white,

          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
                    15),

            borderSide:
                BorderSide.none,
          ),
        ),
      ),
    ),

    Expanded(
      child: filteredProducts
              .isEmpty
          ? const Center(
              child: Text(
                "No products found",
              ),
            )
          : GridView.builder(
              padding:
                  const EdgeInsets
                      .symmetric(
                          horizontal:
                              16),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    2,

                crossAxisSpacing:
                    15,

                mainAxisSpacing:
                    15,

                childAspectRatio:
                    0.68,
              ),

              itemCount:
                  filteredProducts
                      .length,

              itemBuilder:
                  (
                    context,
                    index,
                  ) {

                final product =
                    filteredProducts[
                        index];

                return InkWell(
                  borderRadius:
                      BorderRadius
                          .circular(
                              20),

                  onTap: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailsScreen(
                          product:
                              product,
                        ),
                      ),
                    );
                  },

                  child:
                      Container(
                    decoration:
                        BoxDecoration(
                      color: Colors
                          .white,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),

                      boxShadow: [
                        BoxShadow(
                          color: Colors
                              .black12,

                          blurRadius:
                              10,

                          offset:
                              const Offset(
                                  0,
                                  5),
                        )
                      ],
                    ),

                    child:
                        Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Expanded(
                          child:
                              Container(
                            width: double
                                .infinity,

                            decoration:
                                BoxDecoration(
                              color: Colors
                                      .grey[
                                  300],

                              borderRadius:
                                  const BorderRadius.only(
                                topLeft:
                                    Radius.circular(
                                        20),

                                topRight:
                                    Radius.circular(
                                        20),
                              ),
                            ),

                            child:
                                const Icon(
                              Icons
                                  .shopping_bag,
                              size: 70,
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .all(
                                      12),

                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                product
                                    .name,

                                maxLines:
                                    1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      18,
                                ),
                              ),

                              const SizedBox(
                                  height:
                                      6),

                              Text(
                                product
                                    .description,

                                maxLines:
                                    2,

                                overflow:
                                    TextOverflow
                                        .ellipsis,
                              ),

                              const SizedBox(
                                  height:
                                      10),

                              Text(
                                "₹${product.price}",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.green,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      18,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    )
  ],
),
    );
  }
}