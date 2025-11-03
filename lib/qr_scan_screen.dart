import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart'; // <-- TAMBAHKAN IMPORT INI
import 'package:sistem_akademik/design_system.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  // State untuk mengontrol tampilan: true = Scanner, false = Tampil QR
  bool _isScanning = true;
  
  // Controller untuk kamera
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    // Selalu matikan kamera saat halaman ini dihancurkan
    cameraController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengganti halaman
  void _togglePage(bool isScanningPage) {
    if (_isScanning == isScanningPage) return; // Tidak perlu ganti jika sama

    setState(() {
      _isScanning = isScanningPage;
    });

    if (isScanningPage) {
      // Jika pindah ke 'Scan', nyalakan kamera
      cameraController.start();
    } else {
      // Jika pindah ke 'Tampil QR', matikan kamera (PENTING!)
      cameraController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // 1. Banner Atas yang berisi TOGGLE SWITCH
          _buildToggleSwitch(),
          
          // 2. Konten Halaman (Scanner atau Tampil QR)
          Expanded(
            child: _isScanning
                ? _buildScannerUi()  // Tampilkan UI Scanner
                : _buildMyQrUi(),     // Tampilkan UI Tampil QR
          ),
        ],
      ),
    );
  }

  // --- WIDGET UNTUK TOGGLE SWITCH (SESUAI GAMBAR ANDA) ---
  Widget _buildToggleSwitch() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm / 2),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Warna latar toggle
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        children: [
          // Tombol "Scan QR"
          Expanded(
            child: GestureDetector(
              onTap: () => _togglePage(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: _isScanning ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: _isScanning ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ] : [],
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
          
          // Tombol "Create QRIS"
          Expanded(
            child: GestureDetector(
              onTap: () => _togglePage(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: !_isScanning ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: !_isScanning ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ] : [],
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

  // --- UI UNTUK HALAMAN SCANNER ---
  Widget _buildScannerUi() {
    // Ini adalah UI scanner Anda sebelumnya, tanpa banner atas
    return Stack(
      children: [
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty) {
              final String code = barcodes.first.rawValue ?? 'Tidak ada data';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('QR Ditemukan: $code')),
              );
            }
          },
        ),
        CustomPaint(
          size: Size.infinite,
          painter: QRScannerOverlay(
            scanWindowSize: 250.0,
            borderColor: AppColors.surface,
            scanWindowRadius: AppRadius.button,
          ),
        ),
        // Kita HILANGKAN _buildTopBanner() karena sudah diganti _buildToggleSwitch
        
        // Kontrol bawah (flash, dll) tetap ada
        _buildScannerBottomControls(),
      ],
    );
  }

  // --- UI UNTUK HALAMAN TAMPIL QR ---
  // (Ini adalah konten dari my_qr_code_screen.dart)
  Widget _buildMyQrUi() {
    const String nim = "235150601111012";
    const String qrData = "mahasiswanim:235150601111012";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Kita HILANGKAN banner atas karena sudah diganti _buildToggleSwitch
        
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
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 250.0,
            padding: const EdgeInsets.all(0),
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
    );
  }

  // --- KONTROL BAWAH UNTUK SCANNER ---
  Widget _buildScannerBottomControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Tombol Galeri
          // IconButton(
          //   icon: Icon(
          //     Icons.image_outlined, // Ikon galeri
          //     color: AppColors.surface,
          //     size: 32,
          //   ),
          //   onPressed: () {
          //     // TODO: Implementasi ambil QR dari galeri
          //   },
          // ),
          
          // Tombol Shutter (Placeholder)
          // Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: AppColors.surface, width: 3),
          //   ),
          //   padding: const EdgeInsets.all(AppSpacing.sm / 2),
          //   child: Container(
          //     width: 60,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: AppColors.surface,
          //     ),
          //   ),
          // ),
          
          // Tombol Flash
          ValueListenableBuilder(
            valueListenable: cameraController,
            builder: (context, state, child) {
              final IconData icon = (state.torchState == TorchState.on)
                  ? Icons.flashlight_off
                  : Icons.flashlight_on;
              return IconButton(
                icon: Icon(icon, color: AppColors.surface, size: 32),
                onPressed: () => cameraController.toggleTorch(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- KELAS HELPER UNTUK OVERLAY SCANNER ---
// (Tidak ada perubahan)
class QRScannerOverlay extends CustomPainter {
  final double scanWindowSize;
  final double scanWindowRadius;
  final Color borderColor;
  final double cornerLength;
  final double borderWidth;

  QRScannerOverlay({
    this.scanWindowSize = 250.0,
    this.scanWindowRadius = 12.0,
    this.borderColor = Colors.white,
    this.cornerLength = 24.0,
    this.borderWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ... (kode paint Anda)
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final Rect scanRect = Rect.fromCenter(
      center: Offset(screenWidth / 2, screenHeight / 2),
      width: scanWindowSize,
      height: scanWindowSize,
    );
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight)),
        Path()..addRRect(
          RRect.fromRectAndRadius(scanRect, Radius.circular(scanWindowRadius)),
        ),
      ),
      backgroundPaint,
    );
    // ... (sisa kode paint Anda)
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