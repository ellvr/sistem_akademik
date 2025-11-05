import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryButtonColor = Color(0xFF0482A8);
  static const Color textFieldBorderColor = Color(0xFFD9D9D9);

  void _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('isLoggedIn', false); 
    
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login', 
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.35; 
    final double overlapRadius = 28;
    final double minorOverlapOffset = overlapRadius / 2;
    
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final double extraBottomPadding = 0.0;

    return Scaffold(
      backgroundColor: primaryButtonColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: headerHeight,
              width: double.infinity,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('lib/assets/pipo.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Firza Aurel',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF369BB9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(overlapRadius)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    _buildReadOnlyField(
                      label: 'Nim',
                      value: '235150401111033',
                    ),
                    _buildReadOnlyField(
                      label: 'Email',
                      value: 'firzaaurel@student.ub.ac.id',
                    ),
                    _buildReadOnlyField(
                      label: 'Nama',
                      value: 'Firza Aurel',
                    ),
                    _buildReadOnlyField(
                      label: 'Tempat Lahir',
                      value: 'Malang, Jawa Timur',
                    ),
                    _buildReadOnlyField(
                      label: 'Jenis Kelamin',
                      value: 'Perempuan',
                    ),
                    _buildReadOnlyField(
                      label: 'Alamat',
                      value: 'Jl. Terusan Cikampek, No 110',
                    ),
                    _buildReadOnlyField(
                      label: 'No. HP',
                      value: '081234567890',
                    ),
                    _buildReadOnlyField(
                      label: 'Angkatan',
                      value: '2023',
                    ),
                    _buildReadOnlyField(
                      label: 'Status',
                      value: 'Mahasiswa Aktif',
                    ),
                    _buildReadOnlyField(
                      label: 'Program Studi',
                      value: 'Pendidikan Teknologi Informasi',
                    ),
                    const SizedBox(height: 20),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text('Logout', style: TextStyle(fontSize: 18, color: Colors.white)),
                        onPressed: () => _handleLogout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryButtonColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryButtonColor,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: textFieldBorderColor, width: 1),
            ),
            width: double.infinity,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}