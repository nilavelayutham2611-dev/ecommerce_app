import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SplashScreen
    extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen>
      createState() =>
          _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void>
      checkLogin() async {

    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    final token =
        await ApiService
            .getToken();

    if (!mounted) return;

    if (token != null) {

      Navigator.pushReplacementNamed(
        context,
        "/home",
      );

    } else {

      Navigator.pushReplacementNamed(
        context,
        "/login",
      );
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(),
      ),
    );
  }
}