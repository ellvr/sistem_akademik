import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color primaryButtonColor = Color(0xFF0482A8);

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/onboarding_1.png',
      'title': 'Selamat Datang di SIAM!',
      'description':
          'Absen kuliah lebih mudah dengan melakukan scan QR yang terdapat di setiap kelas.',
    },
    {
      'image': 'assets/onboarding_2.png',
      'title': 'Pantau langsung jadwal kuliah dan presensi',
      'description':
          'Periksa daftar mata kuliah, dosen pengampu, hingga ruangan kelas secara real-time.',
    },
    {
      'image': 'assets/onboarding_3.png',
      'title': 'Lebih praktis, lebih transparan',
      'description':
          'Kamu bisa melihat riwayat presensi kapan saja, tanpa perlu takut ketinggalan presensi',
    },
  ];

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildPage(_onboardingData[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                30, 20, 30, MediaQuery.of(context).padding.bottom + 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: primaryButtonColor,
                      child: Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                  )
                else
                  const SizedBox(width: 48),
                if (_currentPage < _onboardingData.length - 1)
                  GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: primaryButtonColor,
                      child: Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 20),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: _goToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Mulai',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> data) {
    return Column(
      children: [
        ClipPath(
          clipper: OnlyBottomRightRoundedClipper(radius: 120),
          child: Image.asset(
            data['image']!,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  data['title']!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: primaryButtonColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data['description']!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color:
            _currentPage == index ? primaryButtonColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnlyBottomRightRoundedClipper extends CustomClipper<Path> {
  final double radius;
  OnlyBottomRightRoundedClipper({this.radius = 50});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
