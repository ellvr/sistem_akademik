import 'package:flutter/material.dart';
import 'package:sistem_akademik/theme/design_system.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sistem_akademik/screens/riwayat_screen.dart';

enum NfcResultType {
  success,
  failedNotSaved,
  failedTimeisUp,
  deviceNotSupported,
}

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  Timer? _timer;
  int _remainingSeconds = 90;

  bool _showDebugMenu = false;
  final String mataKuliah = "Pemrograman Mobile";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _showResultDialog(NfcResultType.failedTimeisUp);
      }
    });
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
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
                      style: TextStyle(
                        color: AppColors.textDisabled,
                        fontSize: 16,
                      ),
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
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
          _buildDebugTrigger(),
          if (_showDebugMenu) _buildDebugMenu(),
        ],
      ),
    );
  }

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
          const Icon(Icons.nfc, color: AppColors.textOnPrimary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Dekatkan ponsel anda pada kotak absensi",
            style: TextStyle(color: AppColors.textOnPrimary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildNfcGraphic() {
    return SvgPicture.asset('assets/nfc.svg', height: 400, width: 400);
  }

  Widget _buildDebugTrigger() {
    return Positioned(
      top: 12,
      right: 12,
      child: IconButton(
        icon: const Icon(Icons.menu),
        color: AppColors.textSecondary,
        onPressed: () {
          setState(() {
            _showDebugMenu = !_showDebugMenu;
          });
        },
      ),
    );
  }

  Widget _buildDebugMenu() {
    return Positioned(
      top: 56,
      right: 12,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDebugItem(
                icon: Icons.check_circle_outline,
                label: "Berhasil",
                onTap: () {
                  _closeDebug();
                  _showResultDialog(NfcResultType.success);
                },
              ),
              _buildDebugItem(
                icon: Icons.highlight_off,
                label: "Gagal",
                onTap: () {
                  _closeDebug();
                  _showResultDialog(NfcResultType.failedNotSaved);
                },
              ),
              _buildDebugItem(
                icon: Icons.warning_amber_rounded,
                label: "Tidak Didukung",
                onTap: () {
                  _closeDebug();
                  _showResultDialog(NfcResultType.deviceNotSupported);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebugItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void _closeDebug() {
    setState(() {
      _showDebugMenu = false;
    });
  }

  void _showResultDialog(NfcResultType type) {
    if (!mounted) return;

    _timer?.cancel();

    IconData icon;
    Color iconColor;
    String title;
    String message;
    Widget actionButton;

    switch (type) {
      case NfcResultType.success:
        icon = Icons.check_circle;
        iconColor = AppColors.primary;
        title = "Absensi Berhasil";
        message = "Absen mata kuliah \"$mataKuliah\" berhasil disimpan.";
        actionButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 44),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RiwayatScreen()),
            );
          },
          child: const Text("Lihat riwayat absen"),
        );
        break;

      case NfcResultType.failedTimeisUp:
        icon = Icons.highlight_off;
        iconColor = AppColors.error;
        title = "Absensi Gagal";
        message =
            "Waktu pemindaian habis dan NFC belum terdeteksi, silahkan coba lagi.";
        actionButton = _buildOkButton();
        break;

      case NfcResultType.failedNotSaved:
        icon = Icons.highlight_off;
        iconColor = AppColors.error;
        title = "Absensi Gagal";
        message =
            "Proses absensi gagal dan data tidak tersimpan. Silahkan coba lagi.";
        actionButton = _buildOkButton();
        break;

      case NfcResultType.deviceNotSupported:
        icon = Icons.warning_amber_rounded;
        iconColor = AppColors.error;
        title = "Perangkat Tidak Didukung";
        message = "Maaf perangkat Anda tidak mendukung fitur NFC.";
        actionButton = _buildOkButton();
        break;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 70),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: AppTextStyles.profileName,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                actionButton,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOkButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        minimumSize: const Size(double.infinity, 44),
      ),
      onPressed: () => Navigator.pop(context),
      child: const Text("OK"),
    );
  }
}
