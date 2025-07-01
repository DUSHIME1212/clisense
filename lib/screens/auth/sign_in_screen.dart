import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clisence/main.dart'; // Import AppRoutes

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _printText(String text) {
    print('Input: $text');
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => _printText(_emailController.text));
    _passwordController.addListener(() => _printText(_passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define text styles
    final textStyle = TextStyle(color: Colors.white);
    final hintStyle = TextStyle(color: Colors.white70);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                  'https://i.pinimg.com/736x/8b/55/59/8b5559aa155c458f774bccfade3c4782.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark semi-transparent layer for readability
          Container(
            color: Colors.black.withOpacity(0.6), // Dark overlay
          ),
          // Centered content with form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME TO OUR APP',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'ENTER YOUR EMAIL AND PASSWORD TO LOG IN',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    // Email field with blurred background
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'john@doe.com',
                              labelStyle: textStyle,
                              hintStyle: hintStyle,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password field with blurred background
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: '********',
                              labelStyle: textStyle,
                              hintStyle: hintStyle,
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                            validator: _validatePassword,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        print('Forgot Password clicked');
                      },
                      child: const Text(
                        'FORGOT YOUR PASSWORD ?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid, proceeding with login');
                          context.go(AppRoutes.splash);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('OR', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () {
                        print('Log in with Google clicked');
                      },
                      icon: Image.asset(
                        'assets/google_icon.png',
                        height: 24,
                      ),
                      label: const Text(
                        'LOG IN WITH GOOGLE',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.white),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.signup);
                      },
                      child: const Text(
                        'DON’T HAVE AN ACCOUNT SIGNUP?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}