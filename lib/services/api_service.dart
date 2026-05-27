import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

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
}