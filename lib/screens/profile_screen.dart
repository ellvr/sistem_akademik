// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_akademik/screens/edit_profile_screen.dart';
import 'package:sistem_akademik/theme/design_system.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const Color primaryButtonColor = Color(0xFF0482A8);
  static const Color textFieldBorderColor = Color(0xFFD9D9D9);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Firza Aurel";
  String tempatLahir = "Malang, Jawa Timur";
  String alamat = "Jl. Terusan Cikampek, No 110";
  String noHp = "081234567890";

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Konfirmasi Keluar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Apakah anda yakin ingin keluar dari aplikasi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _handleLogout(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dark,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Keluar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(
                            color: ProfileScreen.textFieldBorderColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.28;
    final double overlapRadius = 28;

    return Scaffold(
      backgroundColor: ProfileScreen.primaryButtonColor,
      appBar: AppBar(
        backgroundColor: ProfileScreen.primaryButtonColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.lightActive,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(currentName: userName),
                        ),
                      );

                      if (result != null && result is Map<String, String>) {
                        setState(() {
                          userName = result['nama']!;
                          tempatLahir = result['tempatLahir']!;
                          alamat = result['alamat']!;
                          noHp = result['noHp']!;
                        });
                      }
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF369BB9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(overlapRadius),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyField(label: 'Nim', value: '235150401111033'),
                  _buildReadOnlyField(
                    label: 'Email',
                    value: 'firzaaurel@student.ub.ac.id',
                  ),
                  _buildReadOnlyField(label: 'Nama', value: userName),
                  _buildReadOnlyField(
                    label: 'Tempat Lahir',
                    value: tempatLahir,
                  ),
                  _buildReadOnlyField(
                    label: 'Jenis Kelamin',
                    value: 'Perempuan',
                  ),
                  _buildReadOnlyField(label: 'Alamat', value: alamat),
                  _buildReadOnlyField(label: 'No. HP', value: noHp),
                  _buildReadOnlyField(label: 'Angkatan', value: '2023'),
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
                      label: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () => _showLogoutDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProfileScreen.primaryButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
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
              color: ProfileScreen.primaryButtonColor,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ProfileScreen.textFieldBorderColor,
                width: 1,
              ),
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
