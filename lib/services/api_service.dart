import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';

class ApiService {

  // Base URL
  static const String baseUrl =
      'http://10.162.111.237:5000/api';

  // LOGIN API
  static Future<Map<String, dynamic>>
      login(
    String email,
    String password,
  ) async {

    final response =
        await http.post(
      Uri.parse(
        '$baseUrl/auth/login',
      ),
      headers: {
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password':
            password,
      }),
    );
    print(response.body);
    return jsonDecode(
      response.body,
    );
  }

  // SAVE TOKEN
  static Future<void>
      saveToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'token',
      token,
    );
  }

  // GET TOKEN
  static Future<String?>
      getToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      'token',
    );
  }

  // GET PRODUCTS
static Future<List<ProductModel>>
    getProducts() async {

  final response =
      await http.get(
    Uri.parse(
      '$baseUrl/products',
    ),
  );

  if (response.statusCode ==
      200) {

    List data =
        jsonDecode(
      response.body,
    );

    return data
        .map(
          (product) =>
              ProductModel
                  .fromJson(
            product,
          ),
        )
        .toList();
  }

  throw Exception(
    "Failed to load products",
  );
}


// ADD TO CART
static Future<void>
    addToCart(
  String productId,
) async {

  final token =
      await getToken();

  final response =
      await http.post(
    Uri.parse(
      '$baseUrl/cart',
    ),

    headers: {
      'Content-Type':
          'application/json',

      'Authorization':
          'Bearer $token',
    },

    body: jsonEncode({
      'productId':
          productId,

      'quantity': 1,
    }),
  );

  if (response.statusCode !=
      200 &&
      response.statusCode !=
          201) {

    throw Exception(
      "Failed to add cart",
    );
  }
}

// GET CART
static Future<List<CartModel>>
    getCart() async {

  final token =
      await getToken();

  final response =
      await http.get(
    Uri.parse(
      '$baseUrl/cart',
    ),

    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode ==
      200) {

    List data =
        jsonDecode(
      response.body,
    );

    return data
        .map(
          (item) =>
              CartModel
                  .fromJson(
            item,
          ),
        )
        .toList();
  }

  throw Exception(
    "Failed to load cart",
  );
}
// PLACE ORDER
static Future<void>
    placeOrder() async {

  final token =
      await getToken();

  final response =
      await http.post(
    Uri.parse(
      '$baseUrl/orders',
    ),

    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode !=
      201) {

    throw Exception(
      "Order failed",
    );
  }
}
// GET ORDERS
static Future<
    List<OrderModel>>
    getOrders() async {

  final token =
      await getToken();

  final response =
      await http.get(
    Uri.parse(
      '$baseUrl/orders',
    ),

    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode ==
      200) {

    List data =
        jsonDecode(
      response.body,
    );

    return data
        .map(
          (item) =>
              OrderModel
                  .fromJson(
            item,
          ),
        )
        .toList();
  }

  throw Exception(
    "Failed to load orders",
  );
}

// REMOVE CART ITEM
static Future<void>
    removeCartItem(
  String cartId,
) async {

  final token =
      await getToken();

  final response =
      await http.delete(
    Uri.parse(
      '$baseUrl/cart/$cartId',
    ),

    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  if (response.statusCode !=
      200) {

    throw Exception(
      "Failed to remove item",
    );
  }
}
// LOGOUT
static Future<void>
    logout() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.remove(
    'token',
  );
}

// SIGNUP
static Future<void>
    signup({
  required String name,
  required String email,
  required String password,
}) async {

  final response =
      await http.post(
    Uri.parse(
      '$baseUrl/auth/signup',
    ),

    headers: {
      'Content-Type':
          'application/json',
    },

    body: jsonEncode({
      'name': name,
      'email': email,
      'password':
          password,
    }),
  );

  if (response.statusCode !=
      201) {

    throw Exception(
      "Signup failed",
    );
  }
}
}