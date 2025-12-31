import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isBlue = false;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _navigateToNextScreen(bool isLoggedIn, bool isFirstLaunch) {
    if (mounted) {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/onboarding');
      }
    }
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _isBlue = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _showLogo = true;
    });

    await Future.delayed(const Duration(milliseconds: 2000));
    
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }

    _navigateToNextScreen(isLoggedIn, isFirstLaunch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        color: _isBlue ? const Color(0xFF0482A8) : Colors.white,
        child: Center(
          child: AnimatedOpacity(
            opacity: _showLogo ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox( child: Image.asset(
                  'assets/ub.png',
                  width: 85,
                ),),
                const SizedBox(height: 10),
                const Text(
                  'SIAM',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Sistem Akademik Mahasiswa Pascasarjana',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFE0E0E0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}