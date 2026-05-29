import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/api_service.dart';

class OrdersScreen
    extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen>
      createState() =>
          _OrdersScreenState();
}

class _OrdersScreenState
    extends State<OrdersScreen> {

  late Future<
      List<OrderModel>>
      ordersFuture;

  @override
  void initState() {
    super.initState();

    ordersFuture =
        ApiService
            .getOrders();
  }

  Color getStatusColor(
    String status,
  ) {
    switch (status) {
      case "Delivered":
        return Colors.green;

      case "Shipped":
        return Colors.blue;

      case "Pending":
        return Colors.orange;

      default:
        return Colors.grey;
    }
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
          "My Orders",
        ),
      ),

      body: FutureBuilder<
          List<OrderModel>>(
        future:
            ordersFuture,

        builder:
            (
              context,
              snapshot,
            ) {

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

          final orders =
              snapshot.data!;

          if (orders.isEmpty) {

            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children: [

                  Icon(
                    Icons
                        .receipt_long,
                    size: 100,
                    color:
                        Colors.grey,
                  ),

                  SizedBox(
                      height:
                          20),

                  Text(
                    "No orders found",

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

          return ListView.builder(
            padding:
                const EdgeInsets
                    .all(12),

            itemCount:
                orders.length,

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final order =
                  orders[index];

              return Card(
                elevation: 4,

                margin:
                    const EdgeInsets
                        .only(
                            bottom:
                                15),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),

                child:
                    Padding(
                  padding:
                      const EdgeInsets
                          .all(16),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          Text(
                            "Order #${order.id.substring(0, 6)}",

                            style:
                                const TextStyle(
                              fontSize:
                                  18,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

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
                              color:
                                  getStatusColor(
                                      order.status),

                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),

                            child:
                                Text(
                              order.status,

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
                              15),

                      Text(
                        "Total: ₹${order.totalAmount}",

                        style:
                            const TextStyle(
                          fontSize:
                              22,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color:
                              Colors.green,
                        ),
                      ),

                      const Divider(
                          height:
                              30),

                      const Text(
                        "Items",

                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,

                          fontSize:
                              16,
                        ),
                      ),

                      const SizedBox(
                          height:
                              8),

                      ...order.items.map(
                        (
                          item,
                        ) =>
                            Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                                      bottom:
                                          8),

                          child: Row(
                            children: [

                              const Icon(
                                Icons
                                    .shopping_bag,
                                size: 18,
                              ),

                              const SizedBox(
                                  width:
                                      8),

                              Expanded(
                                child:
                                    Text(
                                  item.product
                                      .name,
                                ),
                              ),

                              Text(
                                "x${item.quantity}",
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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