import 'package:flutter/material.dart';
// Sesuaikan path jika nama proyek Anda berbeda
import 'package:sistem_akademik/design_system.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Halaman ini akan ditampilkan di 'body' home.dart,
    // jadi kita hanya butuh SafeArea.
    return SafeArea(
      child: Column(
        children: [
          // --- 1. Banner Atas ---
          _buildTopBanner(),

          // --- 2. Daftar Riwayat ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              children: [
                // Grup tanggal pertama
                _buildDateGroup(
                  title: "Senin, 15 September 2025",
                  items: [
                    ScheduleItemData(
                      subject: "Sistem Enterprise - A",
                      lecturer: "Almira Syawli, S.Kom., M.Kom.",
                      room: "F3.10",
                      time: "12.30 : 15.00",
                    ),
                    ScheduleItemData(
                      subject: "Sistem Enterprise - A",
                      lecturer: "Almira Syawli, S.Kom., M.Kom.",
                      room: "F3.10",
                      time: "10.30 : 12.10",
                    ),
                    ScheduleItemData(
                      subject: "Sistem Enterprise - A",
                      lecturer: "Almira Syawli, S.Kom., M.Kom.",
                      room: "F3.10",
                      time: "7.00 : 8.40",
                    ),
                  ],
                ),

                // Grup tanggal kedua
                _buildDateGroup(
                  title: "Jumat, 12 September 2025",
                  items: [
                    ScheduleItemData(
                      subject: "Sistem Enterprise - A",
                      lecturer: "Almira Syawli, S.Kom., M.Kom.",
                      room: "F3.10",
                      time: "12.30 : 15.00",
                    ),
                    ScheduleItemData(
                      subject: "Sistem Enterprise - A",
                      lecturer: "Almira Syawli, S.Kom., M.Kom.",
                      room: "F3.10",
                      time: "10.30 : 12.10",
                    ),
                  ],
                ),
                // Beri jarak di bawah agar tidak terpotong navbar
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk banner di bagian atas
  Widget _buildTopBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary, // Biru dari design system
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            // Ikon clipboard/jadwal
            Icons.assignment_turned_in_outlined, 
            color: AppColors.textOnPrimary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Cek kembali riwayat absensimu",
            style: TextStyle(
              color: AppColors.textOnPrimary, // Putih
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk satu grup tanggal (Judul + Kartu)
  Widget _buildDateGroup({required String title, required List<ScheduleItemData> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul Tanggal (Oranye)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          child: Text(
            title,
            style: AppTextStyles.sectionTitle, // Style dari design system
          ),
        ),
        // Kontainer putih untuk daftar item
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface, // Putih
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: [
              BoxShadow(
                color: AppColors.textSecondary.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            // Gunakan List.generate untuk membuat item dan divider
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  _buildScheduleItem(item: item),
                  // Tambahkan Divider kecuali untuk item terakhir
                  if (index < items.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Divider(thickness: 0.5, color: AppColors.background),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // Helper untuk satu baris item jadwal
  Widget _buildScheduleItem({required ScheduleItemData item}) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Kolom Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.subject, style: AppTextStyles.itemTitle),
                const SizedBox(height: 4),
                Text(item.lecturer, style: AppTextStyles.itemSubtitle),
                const SizedBox(height: 4),
                Text(
                  "${item.room}   ${item.time}",
                  style: AppTextStyles.itemSubtitle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Tombol Status
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.success, // Warna teks
              side: BorderSide(color: AppColors.success, width: 1.5), // Warna border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            ),
            child: const Text("Hadir"),
          ),
        ],
      ),
    );
  }
}

// Class helper untuk data (opsional, tapi membuat kode lebih rapi)
class ScheduleItemData {
  final String subject;
  final String lecturer;
  final String room;
  final String time;

  ScheduleItemData({
    required this.subject,
    required this.lecturer,
    required this.room,
    required this.time,
  });
}