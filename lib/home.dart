import 'package:flutter/material.dart';
import 'package:sistem_akademik/design_system.dart';
import 'package:sistem_akademik/navbar.dart';
import 'package:sistem_akademik/nfc_page.dart';
import 'package:sistem_akademik/qr_scan_screen.dart';
import 'package:sistem_akademik/my_qr_code_screen.dart';
import 'package:sistem_akademik/schedule.dart';
import 'package:sistem_akademik/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeContent(),
    QrScanScreen(),
    NfcPage(),
    SchedulePage(),
    ProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavBar(
        initialIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// -------------------------------------------------------------------
// KONTEN ASLI HOME.DART
// -------------------------------------------------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomAppBar(context),
          _buildOngoingClassCard(),
          _buildAnnouncementsSection(),
        ],
      ),
    );
  }

  // Bagian 1: Custom App Bar (Profil & Notifikasi)
  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
            child: const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/user_avatar.png'), // Menggunakan Asset untuk menghindari SocketException
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang,",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              Text(
                "Firza Aurel",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: AppColors.secondary,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Bagian 2: Kartu "Kelas Berlangsung"
  Widget _buildOngoingClassCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        // Hapus 'const' dari BoxDecoration jika AppColors.primary bukan const
        decoration: BoxDecoration( 
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kelas Berlangsung",
              style: TextStyle(
                color: AppColors.light,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Pemograman Lanjut (SI -c)",
              style: TextStyle(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Ir. Agus Wahyu Widodo, S.T., M.Cs.",
              style: TextStyle(color: AppColors.textOnPrimary, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Senin, 10:30 - 12:10",
                  style: TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "F4.11",
                  style: TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Izin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bagian 3: Judul dan Daftar Pengumuman
  Widget _buildAnnouncementsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Container(
                // Hapus 'const' dari BoxDecoration
                decoration: BoxDecoration( 
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textSecondary.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 24.0,
                        bottom: 12.0,
                      ),
                      child: Text(
                        "Pengumuman Kelas",
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        children: [
                          _buildAnnouncementItem(),
                          // Ganti const Divider dengan Divider biasa
                          Divider(thickness: 0.6), 
                          _buildAnnouncementItem(),
                        ],
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

  // Widget untuk satu item pengumuman
  Widget _buildAnnouncementItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manajemen Produk",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "kelas c",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Text(
                "2025-09-09",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Yth. Mahassiswa, Mohon maaf, hari ini (Rabu, 10/9) kelas manajemen produk ditiadakan karena saya ada tugas ke luar kota. Terima kasih.",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          // Ganti const Divider dengan Divider biasa
          Divider(thickness: 0.5, color: AppColors.surface),
        ],
      ),
    );
  }
}