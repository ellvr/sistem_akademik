import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sistem_akademik/screens/riwayat_screen.dart';
import 'package:sistem_akademik/theme/design_system.dart';
import 'dart:async';

class QrScanScreen extends StatefulWidget {
  final VoidCallback? onViewHistory; // Tambahkan callback ini
  const QrScanScreen({super.key, this.onViewHistory});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool _isScanning = true;
  bool _hasScanned = false;
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    // OTOMATIS: Munculkan pop-up berhasil setelah 1 detik untuk simulasi/testing
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _isScanning) {
        _showSuccessDialog();
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _togglePage(bool isScanningPage) {
    if (_isScanning == isScanningPage) return;
    setState(() {
      _isScanning = isScanningPage;
      _hasScanned = false;
    });
    if (isScanningPage) {
      cameraController.start();
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && _isScanning) _showSuccessDialog();
      });
    } else {
      cameraController.stop();
    }
  }

  void _showSuccessDialog() {
    if (_hasScanned) return;
    setState(() {
      _hasScanned = true;
    });
    cameraController.stop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 244, 247),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  "Absen Berhasil",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  "Absen Mata Kuliah \"Sistem Enterprise - A\" berhasil disimpan",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      setState(() {
                        _hasScanned = false;
                      });

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RiwayatScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
                    ),
                    child: const Text("Lihat riwayat absen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFailedDialog() {
    cameraController.stop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.highlight_off, size: 60, color: Colors.red),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  "Absen Gagal",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  "QR Code yang Anda scan tidak valid. Silahkan periksa kembali",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cameraController.start();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildToggleSwitch(),
          Expanded(child: _isScanning ? _buildScannerUi() : _buildMyQrUi()),
        ],
      ),
    );
  }
  
  // ... (Sisa fungsi _buildToggleSwitch, _buildScannerUi, dll tetap sama)
  Widget _buildToggleSwitch() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm / 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _togglePage(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: _isScanning ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: _isScanning
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "Scan QR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isScanning
                          ? AppColors.primary
                          : AppColors.textDisabled,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _togglePage(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: !_isScanning ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: !_isScanning
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "QR Saya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !_isScanning
                          ? AppColors.primary
                          : AppColors.textDisabled,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerUi() {
    return Stack(
      children: [
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final barcodes = capture.barcodes;
            if (barcodes.isNotEmpty && !_hasScanned) {
              _showSuccessDialog();
            }
          },
        ),
        CustomPaint(
          size: Size.infinite,
          painter: QRScannerOverlay(
            scanWindowSize: 250,
            borderColor: AppColors.surface,
            scanWindowRadius: AppRadius.button,
          ),
        ),
        _buildScannerBottomControls(),
      ],
    );
  }

  Widget _buildMyQrUi() {
    const String nim = "235150600111001";
    const String qrData = "mahasiswanim:235150600111001";

    return Column(
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
        Container(
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
          child: QrImageView(data: qrData, version: QrVersions.auto, size: 250),
        ),
        const SizedBox(height: AppSpacing.xxl),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
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
    );
  }

  Widget _buildScannerBottomControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ValueListenableBuilder(
            valueListenable: cameraController,
            builder: (context, state, child) {
              final icon = state.torchState == TorchState.on
                  ? Icons.flashlight_off
                  : Icons.flashlight_on;
              return IconButton(
                icon: Icon(icon, color: AppColors.surface, size: 32),
                onPressed: () => cameraController.toggleTorch(),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 32,
            ),
            onPressed: _showFailedDialog,
          ),
        ],
      ),
    );
  }
}
// ... (QRScannerOverlay tetap sama)
class QRScannerOverlay extends CustomPainter {
  final double scanWindowSize;
  final double scanWindowRadius;
  final Color borderColor;
  final double cornerLength;
  final double borderWidth;

  QRScannerOverlay({
    this.scanWindowSize = 250,
    this.scanWindowRadius = 12,
    this.borderColor = Colors.white,
    this.cornerLength = 24,
    this.borderWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanWindowSize,
      height: scanWindowSize,
    );

    final backgroundPaint = Paint()..color = Colors.black.withOpacity(0.5);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(
          RRect.fromRectAndRadius(scanRect, Radius.circular(scanWindowRadius)),
        ),
      ),
      backgroundPaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.top + cornerLength)
        ..lineTo(scanRect.left, scanRect.top)
        ..lineTo(scanRect.left + cornerLength, scanRect.top),
      borderPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.top)
        ..lineTo(scanRect.right, scanRect.top)
        ..lineTo(scanRect.right, scanRect.top + cornerLength),
      borderPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.bottom - cornerLength)
        ..lineTo(scanRect.left, scanRect.bottom)
        ..lineTo(scanRect.left + cornerLength, scanRect.bottom),
      borderPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.bottom)
        ..lineTo(scanRect.right, scanRect.bottom)
        ..lineTo(scanRect.right, scanRect.bottom - cornerLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}