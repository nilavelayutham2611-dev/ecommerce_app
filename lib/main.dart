import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp
    extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return ChangeNotifierProvider(
  create: (_) =>
      CartProvider()
        ..loadCart(),

  child: MaterialApp(
      debugShowCheckedModeBanner:
          false,

      initialRoute:
          "/",

      routes: {

        "/": (context) =>
            const SplashScreen(),

        "/login":
            (context) =>
                const LoginScreen(),

        "/home":
            (context) =>
                const HomeScreen(),
      },
    ),);
  }
}