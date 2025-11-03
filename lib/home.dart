import 'package:flutter/material.dart';
import 'package:sistem_akademik/design_system.dart';
import 'package:sistem_akademik/navbar.dart';
import 'package:sistem_akademik/nfc_page.dart';
// 1. IMPORT HALAMAN LAINNYA
import 'package:sistem_akademik/qr_scan_screen.dart';
import 'package:sistem_akademik/my_qr_code_screen.dart';
import 'package:sistem_akademik/schedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 2. STATE UNTUK MELACAK HALAMAN AKTIF
  int _selectedIndex = 0;

  // 3. BUAT DAFTAR HALAMAN (WIDGETS)
  // Urutan harus sama dengan navbar: 0=Home, 1=Scan, 2=Catatan, dst.
  static const List<Widget> _pages = <Widget>[
    HomeContent(), // Halaman Home (kita buat di bawah)
    QrScanScreen(), // Halaman Scan QR
    NfcPage(), // Halaman Catatan (contoh)
    SchedulePage(), // Halaman Jadwal (contoh)
    PlaceholderPage(title: 'halaman profil'), // Halaman Profil (contoh)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // 4. BODY SEKARANG MENAMPILKAN HALAMAN SESUAI STATE
      body: _pages[_selectedIndex],

      // 5. HUBUNGKAN NAVBAR KE STATE
      bottomNavigationBar: BottomNavBar(
        initialIndex: _selectedIndex, // Beri tahu navbar index saat ini
        onItemTapped: (index) {
          // Saat navbar diklik, update state
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// -------------------------------------------------------------------
// KONTEN ASLI HOME.DART KITA PINDAHKAN KE WIDGET SENDIRI
// Ini membuat `HomePage` (di atas) bersih & hanya berfungsi sebagai navigasi
// -------------------------------------------------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomAppBar(),
          _buildOngoingClassCard(),
          _buildAnnouncementsSection(),
        ],
      ),
    );
  }

  // --- Semua method _build... milik HomeContent ada di sini ---

  // Bagian 1: Custom App Bar (Profil & Notifikasi)
  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=56'),
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
                          const Divider(thickness: 0.6),
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
          Divider(thickness: 0.5, color: AppColors.surface),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// WIDGET CONTOH UNTUK HALAMAN YANG BELUM DIBUAT
// -------------------------------------------------------------------
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
