import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn/auth/signup.dart';
import 'package:learn/auth/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String loginApiUrl = 'https://maiasalt.online/api/mobile/login';
  final String googleOAuthUrl = 'https://maiasalt.online/api/mobile/google-oauth';

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _loginUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(loginApiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => User()),
        );
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Login failed';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (error) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to connect to the server.')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return;

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) throw Exception("No idToken received from Google.");

      final response = await http.post(
        Uri.parse(googleOAuthUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_token': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>User()),
        );
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Google login failed';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign In Failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff213448),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 100, right: 20, bottom: 10),
                    child: Text(
                      "LogIn",
                      style: TextStyle(
                        color: Color(0xFF547792),
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(0xffffffff),
                          decoration: _inputDecoration("Email", Icons.email),
                          validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter valid email' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          cursorColor: const Color(0XFF547792),
                          decoration: _inputDecoration(
                            "Password",
                            Icons.lock,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: const Color(0xff547792),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),
                        _isLoading
                            ? const CircularProgressIndicator(color: Color(0xff547792))
                            : ElevatedButton(
                          onPressed: () => _loginUser(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff547792),
                            minimumSize: const Size(300, 50),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xff213448),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const <Widget>[
                            Expanded(child: Divider(thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Text(
                                "OR",
                                style: TextStyle(fontSize: 14, color: Color(0xff547792)),
                              ),
                            ),
                            Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff547792),
                            elevation: 2,
                            minimumSize: const Size(350, 50),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                  text: 'Login In With ',
                                  style: TextStyle(color: Color(0xffF8EEDF), fontSize: 13),
                                ),
                                TextSpan(
                                  text: 'Google',
                                  style: TextStyle(
                                    color: Color(0xff213448),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account?',
                              style: TextStyle(color: Color(0xffF8EEDF)),
                              children: [
                                TextSpan(
                                  text: ' Sign Up Now',
                                  style: TextStyle(color: Color(0xff94B4C1)),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(0XFF547792),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: Icon(icon, color: const Color(0xff547792)),
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Color(0xff94B4C1), width: 1.5),
      ),

      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Color(0xff547792)),
      ),
    );
  }
}
