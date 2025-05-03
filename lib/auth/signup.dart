import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:learn/auth/user.dart';
import 'package:learn/auth/login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _obscurePassword = true;

  final String signUpApiUrl = 'https://maiasalt.online:5200/api/mobile/signup';

  Future<void> _signUpUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await http.post(
        Uri.parse(signUpApiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => User()),
        );
      } else {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'Sign up failed.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to connect to server')),
      );
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => User()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign In Failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF780000),
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                cursorColor: Color(0xff780000),
                decoration: _inputDecoration("User Name", Icons.person),
                validator: (value) => value!.isEmpty ? 'Enter a username' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color(0xff780000),
                decoration: _inputDecoration("Email", Icons.email),
                validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter valid email' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                cursorColor: Color(0xff780000),
                decoration: _inputDecoration(
                  "Password",
                  Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xff780000),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _signUpUser(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff05064e),
                  minimumSize: Size(300, 50),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleGoogleSignIn(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  minimumSize: Size(350, 50),
                ),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign Up With ',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      TextSpan(
                        text: 'Google',
                        style: TextStyle(color: Color(0xff05064e), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: ' Log In',
                        style: TextStyle(color: Color(0xff780000)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0XFF780000), fontSize: 12, fontWeight: FontWeight.bold),
      prefixIcon: Icon(icon, color: Color(0xff780000)),
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Color(0xff780000)),
      ),
    );
  }
}
