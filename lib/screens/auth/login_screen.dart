// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color primaryButtonColor = Color(0xFF0482A8);

  final TextEditingController _nimEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nimEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // void _handleLogin(BuildContext context) async {
  //   if (_nimEmailController.text.isNotEmpty &&
  //       _passwordController.text.isNotEmpty) {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);

  //     Navigator.of(context).pushReplacementNamed('/home');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('NIM/Email dan Password harus diisi')),
  //     );
  //   }
  // }
  void _handleLogin(BuildContext context) async {
  if (_nimEmailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    // TAMBAHKAN PENGECEKAN INI
    if (!mounted) return; 

    Navigator.of(context).pushReplacementNamed('/home');
  } else {
    // TAMBAHKAN JUGA DI SINI
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('NIM/Email dan Password harus diisi')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/login.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: screenHeight * 0.28,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth,
                constraints: BoxConstraints(minHeight: screenHeight * 0.72),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryButtonColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Masuk ke akun Kamu',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                      controller: _nimEmailController,
                      label: 'NIM/Email',
                      hint: 'Masukkan NIM atau email...',
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: '••••••••',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      icon: Icons.lock_outline,
                      onTogglePassword: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      suffixWidget: InkWell(
                        onTap: () {},
                        child: const Text(
                          'Lupa password?',
                          style: TextStyle(
                            color: primaryButtonColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        key: const Key('loginButton'),
                        onPressed: () => _handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(color: Colors.grey, height: 36),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Atau',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 24,
                              child: Image.asset('assets/google.png'),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Masuk dengan Google',
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryButtonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum Punya Akun? ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              color: primaryButtonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTextField({
    Key? key,
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
    IconData? icon,
    Widget? suffixWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$label', style: const TextStyle(color: primaryButtonColor)),
            if (suffixWidget != null) suffixWidget,
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          key: key,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword ? obscureText : false,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
