import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sistem_akademik/design_system.dart';
// Hapus import yang tidak perlu

class MyQrCodeScreen extends StatelessWidget {
  const MyQrCodeScreen({super.key});

  final String nim = "235150601111012";
  final String qrData = "mahasiswanim:235150601111012";

  @override
  Widget build(BuildContext context) {
    // [PERBAIKAN] Tambahkan Scaffold di sini.
    // Halaman ini adalah halaman BARU, jadi dia butuh Scaffold-nya sendiri
    // untuk punya AppBar dan background.
    return Scaffold(
      backgroundColor: AppColors.background, // Set background
      appBar: AppBar(
        title: const Text("QR Code Saya"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBanner(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nim : $nim",
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textSecondary.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: 250.0,
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                      child: Text(
                        "Gunakan QR Code ini untuk menampilkan data mahasiswa.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // [PERBAIKAN] Hapus tombol 'Switch to Scanner'
            // Center(
            //   child: _buildBottomControls(context),
            // ),
          ],
        ),
      ),
    );
  }

  // [PERBAIKAN] HAPUS FUNGSI _buildBottomControls
  // Widget _buildBottomControls(BuildContext context) { ... }

  Widget _buildTopBanner() {
    // ... (Kode _buildTopBanner Anda tidak berubah) ...
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
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb, color: AppColors.textOnPrimary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Tingkatkan kecerahan layar",
            style: TextStyle(
              color: AppColors.textOnPrimary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}