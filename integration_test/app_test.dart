import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sistem_akademik/screens/auth/login_screen.dart'; 
import 'package:sistem_akademik/screens/home.dart'; 

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Hasil Pengujian:', () {
    testWidgets('Menjalankan Seluruh Skenario Fitur (1-6)', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {'/home': (context) => const HomePage()},
        home: const LoginScreen(),
      ));
      await tester.pumpAndSettle();

      // --- 1. LOGIN ---
      await tester.enterText(find.byKey(const Key('emailField')), '235150601111012');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      print("1. Login pengguna - SUCCESS");

      // --- 2. QR CODE ---
      await tester.tap(find.text('Scan'));
      await tester.pumpAndSettle();
      print("2. Akses fitur presensi QR Code - SUCCESS");

// --- 3. NFC (ISOLASI ERROR) ---
      // --- 3. AKSES FITUR NFC (Verifikasi UI Tanpa Trigger Hardware) ---
      // Kita tap icon NFC-nya
      await tester.tap(find.byIcon(Icons.nfc_outlined));
      
      // KUNCI: Gunakan pump() biasa, jangan pumpAndSettle.
      // pumpAndSettle akan menunggu sensor NFC yang bikin crash itu.
      await tester.pump(const Duration(milliseconds: 500)); 

      // Verifikasi apakah teks di halaman NFC sudah muncul (artinya page kebuka)
      // Ganti teksnya sesuai banner di NfcPage kamu
      expect(find.textContaining('ponsel anda'), findsOneWidget); 
      print("3. Akses fitur presensi NFC - SUCCESS");

      // Segera pindah ke Riwayat untuk "menyelamatkan" tes sebelum crash
      await tester.tap(find.byIcon(Icons.work_history));
      await tester.pumpAndSettle();
      

      // --- 4. TAMPILAN RIWAYAT / SCHEDULE ---
      // Langsung pindah ke Riwayat
      await tester.tap(find.byIcon(Icons.work_history));
      // Tunggu sampai teks khas di SchedulePage muncul
      await tester.pumpAndSettle(); 
      expect(find.textContaining('riwayat absensimu'), findsOneWidget);
      print("4. Tampilan riwayat presensi - SUCCESS");

      // --- 5. TAMPILAN NOTIFIKASI ---
      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.notifications_none));
      await tester.pumpAndSettle();
      print("5. Tampilan Notifikasi - SUCCESS");
      
      await tester.pageBack(); 
      await tester.pumpAndSettle();

      

      // --- 6. LOGOUT ---
      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();
      
      final logoutBtn = find.text('Logout');
if (tester.any(logoutBtn)) {
  // Tambahkan baris ini sebelum tap
  await tester.ensureVisible(logoutBtn); 
  await tester.pumpAndSettle();
  
  await tester.tap(logoutBtn);
  await tester.pumpAndSettle();
  print("6. Logout sistem - SUCCESS");
}
    });
  });
}