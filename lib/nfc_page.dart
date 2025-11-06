import 'package:flutter/material.dart';
import 'package:sistem_akademik/design_system.dart';
import 'package:sistem_akademik/navbar.dart';
import 'dart:async';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  Timer? _timer;
  int _remainingSeconds = 90; // 1 menit 30 detik

  @override
  void initState() {
    super.initState();
    // Mulai timer saat halaman dibuka
    _startTimer();
    // Mulai memindai NFC
    // _startNfcScan();
  }

  @override
  void dispose() {
    // Selalu batalkan timer saat halaman ditutup
    _timer?.cancel();
    // Hentikan sesi NFC
    NfcManager.instance.stopSession();
    super.dispose();
  }

  // --- LOGIKA TIMER ---
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        // Tampilkan popup gagal jika waktu habis
        _showResultDialog(isSuccess: false);
      }
    });
  }

  // Helper untuk format waktu 01:29
  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  // --- LOGIKA NFC ---
  // void _startNfcScan() {
  //   NfcManager.instance.startSession(
  //     onDiscovered: (NfcTag tag) async {
  //       // --- SUKSES ---
  //       // Hentikan timer & sesi
  //       _timer?.cancel();
  //       NfcManager.instance.stopSession();

  //       // Tampilkan popup sukses
  //       _showResultDialog(isSuccess: true);

  //       // Di sini Anda bisa memproses data 'tag'
  //       // print(tag.data);
  //     },
  //     onError: (e) async {
  //       // --- GAGAL (dari NFC) ---
  //       _timer?.cancel();
  //       NfcManager.instance.stopSession();
  //       _showResultDialog(isSuccess: false);
  //     },
  //   );
  // }

  // --- UI WIDGETS ---
  @override
  Widget build(BuildContext context) {
    // Halaman ini akan ditampilkan di 'body' home.dart,
    // jadi kita hanya butuh SafeArea.

    return SafeArea(
      // backgroundColor: AppColors.surface,
      // child: SafeArea(
      child: Column(
        children: [
          _buildTopBanner(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNfcGraphic(),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  "Selesaikan Absensi dalam",
                  style: TextStyle(color: AppColors.textDisabled, fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _formatDuration(_remainingSeconds),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60), // Beri jarak dari bawah
              ],
            ),
          ),
        ],
      ),
      // ),
      //  bottomNavigationBar: const BottomNavBar(
      //   initialIndex: 2,
      //  )
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
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.nfc, color: AppColors.textOnPrimary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Dekatkan ponsel anda pada kotak absensi",
            style: TextStyle(color: AppColors.textOnPrimary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // Helper untuk grafis NFC di tengah
  Widget _buildNfcGraphic() {
    return SvgPicture.asset(
      'lib/assets/nfc.svg', // Path ke file SVG Anda
      height: 400, // Sesuaikan ukuran sesuai kebutuhan
      width: 400,
      // colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn), // Mengganti warna SVG ke primary color
    );
  }

  // --- LOGIKA POPUP ---
  void _showResultDialog({required bool isSuccess}) {
    // Pastikan dialog tampil di context yang benar
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false, // User tidak bisa skip
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.highlight_off,
                  color: isSuccess ? AppColors.success : AppColors.error,
                  size: 70,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  isSuccess ? "Absensi Berhasil" : "Absensi Gagal",
                  style: AppTextStyles.profileName, // Style dari design system
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  isSuccess
                      ? "Data absensi Anda telah terekam."
                      : "Waktu habis atau device tidak terdeteksi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    minimumSize: const Size(double.infinity, 44),
                  ),
                  onPressed: () {
                    // Tutup popup
                    Navigator.pop(context);
                    // TODO: Arahkan user kembali ke Home
                    // (Ini perlu callback ke home.dart untuk ganti index)
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
