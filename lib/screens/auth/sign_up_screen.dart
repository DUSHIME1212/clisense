import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:clisence/main.dart'; // Import AppRoutes

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
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

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (value.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() => _printText(_usernameController.text));
    _emailController.addListener(() => _printText(_emailController.text));
    _passwordController.addListener(() => _printText(_passwordController.text));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define text styles for FTextField
    final textStyle = TextStyle(color: Colors.white);
    final hintStyle = TextStyle(color: Colors.white70);
    final errorStyle = TextStyle(color: Colors.white70);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (non-const constructor)
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
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'REGISTER TO CREATE ACCOUNT',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    // Username field with blurred background
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
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'JaneDoe',
                              labelStyle: textStyle,
                              hintStyle: hintStyle,
                              border: InputBorder.none,
                            ),
                            validator: _validateUsername,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          try {
                            context.go(AppRoutes.formdetails);
                          } catch (e) {
                            print('Navigation failed: $e');
                          }
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
                        'SIGN UP',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('OR', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () {
                        print('Sign up with Google clicked');
                      },
                      icon: Image.network(
                        'https://i.pinimg.com/736x/59/7f/11/597f11b631d7d94492f1adb95110cc44.jpg',
                        height: 24,
                      ),
                      label: const Text(
                        'SIGN UP WITH GOOGLE',
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
                        context.go(AppRoutes.signin);
                      },
                      child: const Text(
                        'ALREADY HAD AN ACCOUNT SIGNIN?',
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