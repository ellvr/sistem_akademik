// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  static const Color primaryButtonColor = Color(0xFF0482A8);

  final TextEditingController _nimEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _nimError;
  String? _passwordError;

  late final AnimationController _loadingController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _nimEmailController.dispose();
    _passwordController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                RotationTransition(
                  turns: _loadingController,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: List.generate(8, (index) {
                        return Positioned.fill(
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(index / 8),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 5 + (index * 0.7),
                                width: 5 + (index * 0.7),
                                decoration: const BoxDecoration(
                                  color: primaryButtonColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 244, 247),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Loading...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryButtonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleLogin(BuildContext context) async {
    final String nimInput = _nimEmailController.text;
    final String passwordInput = _passwordController.text;

    setState(() {
      _nimError = null;
      _passwordError = null;

      if (nimInput.isEmpty) {
        _nimError = 'Data tidak boleh kosong';
      } else if (nimInput != '235150600111001') {
        _nimError = 'NIM/Email tidak valid';
      }

      if (passwordInput.isEmpty) {
        _passwordError = 'Data tidak boleh kosong';
      } else if (passwordInput != '12345678') {
        _passwordError = 'Password tidak valid';
      }
    });

    if (_nimError == null && _passwordError == null) {
      _showLoadingDialog(context);

      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (!mounted) return;

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
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
                      'Mulai dengan login terlebih dahulu',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildTextField(
                          controller: _nimEmailController,
                          label: 'NIM/Email UB',
                          hint: 'Masukkan NIM atau email...',
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.person_outline,
                          errorText: _nimError,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: '••••••••',
                          isPassword: true,
                          obscureText: _obscurePassword,
                          icon: Icons.lock_outline,
                          errorText: _passwordError,
                          onTogglePassword: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'Lupa password?',
                            style: TextStyle(
                              color: primaryButtonColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(label, style: const TextStyle(color: primaryButtonColor)),
                const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
            if (suffixWidget != null) suffixWidget,
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          key: key,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword ? obscureText : false,
          onChanged: (_) {
            if (errorText != null) {
              setState(() {
                if (label.contains('NIM')) _nimError = null;
                if (label.contains('Password')) _passwordError = null;
              });
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : primaryButtonColor,
                width: 1,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
