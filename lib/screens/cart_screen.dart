import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen
    extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen>
      createState() =>
          _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  

  @override
void initState() {
  super.initState();

  Future.microtask(() {
    context
        .read<CartProvider>()
        .loadCart();
  });
}


  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      backgroundColor:
          Colors.grey[100],

      appBar: AppBar(
        title:
            const Text(
          "My Cart",
        ),
      ),

      body: Consumer<
    CartProvider>(
  builder:
      (
        context,
        cartProvider,
        child,
      ) {

    final cartItems =
        cartProvider
            .cartItems;

    if (cartItems
        .isEmpty) {

      return const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [

            Icon(
              Icons
                  .shopping_cart_outlined,
              size: 100,
              color:
                  Colors.grey,
            ),

            SizedBox(
                height:
                    20),

            Text(
              "Your cart is empty",

              style:
                  TextStyle(
                fontSize:
                    20,
              ),
            )
          ],
        ),
      );
    }

    return Column(
      children: [

        Expanded(
          child:
              ListView.builder(
            padding:
                const EdgeInsets
                    .all(12),

            itemCount:
                cartItems
                    .length,

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final item =
                  cartItems[
                      index];

              return Card(
                elevation: 4,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),

                margin:
                    const EdgeInsets
                        .only(
                        bottom:
                            15),

                child:
                    Padding(
                  padding:
                      const EdgeInsets
                          .all(
                              14),

                  child: Row(
                    children: [

                      Container(
                        width: 90,
                        height:
                            90,

                        decoration:
                            BoxDecoration(
                          color: Colors
                                  .grey[
                              300],

                          borderRadius:
                              BorderRadius.circular(
                                  15),
                        ),

                        child:
                            const Icon(
                          Icons
                              .shopping_bag,
                          size: 45,
                        ),
                      ),

                      const SizedBox(
                          width:
                              15),

                      Expanded(
                        child:
                            Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              item
                                  .product
                                  .name,

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
                                    8),

                            Text(
                              "Qty: ${item.quantity}",
                            ),

                            const SizedBox(
                                height:
                                    8),

                            Text(
                              "₹${item.product.price}",

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
                      ),

                      IconButton(
                        onPressed:
                            () async {

                          await cartProvider
                              .removeItem(
                            item.id,
                          );
                        },

                        icon:
                            const Icon(
                          Icons.delete,
                          color:
                              Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Container(
          padding:
              const EdgeInsets
                  .all(20),

          decoration:
              const BoxDecoration(
            color:
                Colors.white,

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

          child: Column(
            children: [

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [

                  const Text(
                    "Total",

                    style:
                        TextStyle(
                      fontSize:
                          20,
                    ),
                  ),

                  Text(
                    "₹${cartProvider.totalPrice}",

                    style:
                        const TextStyle(
                      fontSize:
                          24,

                      fontWeight:
                          FontWeight
                              .bold,

                      color:
                          Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height:
                      15),

              SizedBox(
                width:
                    double.infinity,

                height: 55,

                child:
                    ElevatedButton(
                  onPressed:
                      () async {

                    await cartProvider
                        .checkout();
                  },

                  child:
                      const Text(
                    "Checkout",

                    style:
                        TextStyle(
                      fontSize:
                          18,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  },
),
    );
  }
}