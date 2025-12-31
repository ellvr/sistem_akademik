import 'package:flutter/material.dart';
import 'package:sistem_akademik/theme/design_system.dart';
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
  int _remainingSeconds = 90;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    NfcManager.instance.stopSession();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _showResultDialog(isSuccess: false);
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
                const SizedBox(height: 60),
              ],
            ),
          ),
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

  Widget _buildNfcGraphic() {
    return SvgPicture.asset('assets/nfc.svg', height: 400, width: 400);
  }

  void _showResultDialog({required bool isSuccess}) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
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
                  style: AppTextStyles.profileName,
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
                    Navigator.pop(context);
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
