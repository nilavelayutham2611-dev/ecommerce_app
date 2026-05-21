import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  // Base URL
  static const String baseUrl =
      'http://10.0.2.2:5000/api';

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
}