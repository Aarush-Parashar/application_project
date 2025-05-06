import 'package:application_project/screens/home_screen.dart';
import 'package:application_project/widgets/login_button.dart';
import 'package:application_project/services/auth_services.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double boxWidth = 300.0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isLoginMode = true;

  final ButtonStyle blackButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(45),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(value);
    });
  }

  Future<void> navigateToHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> handleSocialLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    navigateToHome();
  }

  Future<void> _handleAuthAction() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final prefs = await SharedPreferences.getInstance();
    final authService = AuthService();

    final userCredential =
        isLoginMode
            ? await authService.loginWithEmailPassword(email, password)
            : await authService.registerWithEmailPassword(email, password);

    if (userCredential != null) {
      await prefs.setBool('is_logged_in', true);
      navigateToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${isLoginMode ? 'Login' : 'Sign Up'} Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SizedBox(
                width: boxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      isLoginMode ? 'Log in' : 'Sign up',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildEmailInput(),
                    const SizedBox(height: 20),
                    _buildPasswordInput(),
                    const SizedBox(height: 20),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildSocialButtons(),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginMode = !isLoginMode;
                        });
                      },
                      child: Text(
                        isLoginMode
                            ? "Don't have an account? Sign up"
                            : "Already have an account? Log in",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isEmailValid ? Colors.green : Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(17),
      ),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Enter your email address',
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: validateEmail,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isPasswordValid ? Colors.green : Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: 'Enter your password',
            ),
            onChanged: (value) {
              setState(() {
                isPasswordValid = value.length >= 6;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: isEmailValid && isPasswordValid ? _handleAuthAction : null,
          style: blackButtonStyle,
          child: Text(isLoginMode ? 'Login with Email' : 'Sign up with Email'),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.black)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        Expanded(child: Divider(color: Colors.black)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        SocialLoginButton(
          icon: 'assets/googleLogo.png',
          text: 'Continue with Google',
          onPressed: () {
            AuthService().loginWithGoogle(context).then((value) {
              if (value != null) {
                handleSocialLogin();
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Login Failed")));
              }
            });
          },
        ),
      ],
    );
  }
}
