import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductDetailsScreen
    extends StatefulWidget {

  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen>
      createState() =>
          _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<
        ProductDetailsScreen> {

  bool isLoading = false;

  Future<void> addToCart()
      async {

    setState(() {
      isLoading = true;
    });

    try {

      await ApiService
          .addToCart(
        widget.product.id,
      );

      if (!mounted) return;

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

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(
      BuildContext context) {

    final product =
        widget.product;

    return Scaffold(
      backgroundColor:
          Colors.grey[100],

      body: Column(
        children: [

          Expanded(
            child:
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Stack(
                    children: [

                      Container(
                        height: 320,
                        width:
                            double.infinity,

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.grey[
                                  300],

                          borderRadius:
                              const BorderRadius.only(
                            bottomLeft:
                                Radius.circular(
                                    30),

                            bottomRight:
                                Radius.circular(
                                    30),
                          ),
                        ),

                        child:
                            const Icon(
                          Icons
                              .shopping_bag,
                          size: 120,
                        ),
                      ),

                      Positioned(
                        top: 50,
                        left: 20,
                        child:
                            CircleAvatar(
                          backgroundColor:
                              Colors
                                  .white,

                          child:
                              IconButton(
                            icon:
                                const Icon(
                              Icons
                                  .arrow_back,
                            ),

                            onPressed:
                                () {
                              Navigator.pop(
                                  context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding:
                        const EdgeInsets
                            .all(20),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          product.name,

                          style:
                              const TextStyle(
                            fontSize:
                                28,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                15),

                        Row(
                          children: [

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal:
                                    12,

                                vertical:
                                    6,
                              ),

                              decoration:
                                  BoxDecoration(
                                color: Colors
                                    .green,

                                borderRadius:
                                    BorderRadius.circular(
                                        20),
                              ),

                              child:
                                  Text(
                                "Stock: ${product.stock}",

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height:
                                20),

                        Text(
                          "₹${product.price}",

                          style:
                              const TextStyle(
                            fontSize:
                                30,

                            color:
                                Colors.green,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                20),

                        const Text(
                          "Description",

                          style:
                              TextStyle(
                            fontSize:
                                20,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                10),

                        Text(
                          product
                              .description,

                          style:
                              TextStyle(
                            color: Colors
                                .grey[700],

                            fontSize:
                                16,

                            height:
                                1.6,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            padding:
                const EdgeInsets
                    .all(20),

            decoration:
                const BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.only(
                topLeft:
                    Radius.circular(
                        25),

                topRight:
                    Radius.circular(
                        25),
              ),
            ),

            child: SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(
                style:
                    ElevatedButton
                        .styleFrom(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            15),
                  ),
                ),

                onPressed:
                    isLoading
                        ? null
                        : addToCart,

                child:
                    isLoading
                        ? const CircularProgressIndicator(
                            color:
                                Colors
                                    .white,
                          )
                        : const Text(
                            "Add To Cart",
                            style:
                                TextStyle(
                              fontSize:
                                  18,
                            ),
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }
}