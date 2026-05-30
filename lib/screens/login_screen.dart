import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'signup_screen.dart';

class LoginScreen
    extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen>
      createState() =>
          _LoginScreenState();
}

class _LoginScreenState
    extends State<
        LoginScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;
  bool obscurePassword =
      true;

  Future<void> login() async {

    if (!_formKey
        .currentState!
        .validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response =
          await ApiService.login(
        emailController.text
            .trim(),

        passwordController.text
            .trim(),
      );

      if (response["token"] !=
          null) {

        await ApiService
            .saveToken(
          response["token"],
        );

        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(
            content: Text(
              "Login Successful",
            ),
          ),
        );

        Navigator.pushReplacementNamed(
          context,
          "/home",
        );

      } else {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              response["message"] ??
                  "Login failed",
            ),
          ),
        );
      }

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

    return Scaffold(
      backgroundColor:
          Colors.grey[100],

      body: SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets
                  .all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                const SizedBox(
                    height:
                        50),

                Center(
                  child: Container(
                    height: 100,
                    width: 100,

                    decoration:
                        BoxDecoration(
                      color: Colors
                          .blue
                          .shade100,

                      shape:
                          BoxShape
                              .circle,
                    ),

                    child:
                        const Icon(
                      Icons
                          .shopping_bag,
                      size: 50,
                      color:
                          Colors.blue,
                    ),
                  ),
                ),

                const SizedBox(
                    height:
                        40),

                const Text(
                  "Welcome Back 👋",

                  style:
                      TextStyle(
                    fontSize:
                        32,

                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                    height:
                        8),

                Text(
                  "Login to continue shopping",

                  style:
                      TextStyle(
                    color: Colors
                        .grey[600],

                    fontSize:
                        16,
                  ),
                ),

                const SizedBox(
                    height:
                        40),

                TextFormField(
                  controller:
                      emailController,

                  validator:
                      (value) {

                    if (value ==
                            null ||
                        value
                            .isEmpty) {

                      return "Please enter email";
                    }

                    return null;
                  },

                  decoration:
                      InputDecoration(
                    labelText:
                        "Email",

                    prefixIcon:
                        const Icon(
                      Icons.email,
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

                const SizedBox(
                    height:
                        20),

                TextFormField(
                  controller:
                      passwordController,

                  obscureText:
                      obscurePassword,

                  validator:
                      (value) {

                    if (value ==
                            null ||
                        value
                            .length <
                                6) {

                      return "Password must be at least 6 characters";
                    }

                    return null;
                  },

                  decoration:
                      InputDecoration(
                    labelText:
                        "Password",

                    prefixIcon:
                        const Icon(
                      Icons.lock,
                    ),

                    suffixIcon:
                        IconButton(
                      onPressed:
                          () {

                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },

                      icon:
                          Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
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

                const SizedBox(
                    height:
                        30),

                SizedBox(
                  width:
                      double.infinity,

                  height: 55,

                  child:
                      ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : login,

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

                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                                color:
                                    Colors.white,
                              )
                            : const Text(
                                "Login",

                                style:
                                    TextStyle(
                                  fontSize:
                                      18,
                                ),
                              ),
                  ),
                ),

                const SizedBox(
                    height:
                        20),

                Center(
                  child:
                      TextButton(
                    onPressed:
                        () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const SignupScreen(),
                        ),
                      );
                    },

                    child:
                        const Text(
                      "Don't have an account? Sign Up",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}