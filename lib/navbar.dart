import 'package:flutter/material.dart';
import 'package:sistem_akademik/design_system.dart';
import 'package:sistem_akademik/nfc_page.dart';
import 'package:sistem_akademik/qr_scan_screen.dart';
import 'package:sistem_akademik/home.dart';
import 'package:sistem_akademik/schedule.dart';

/// A reusable bottom navigation bar widget.
/// Use [onItemTapped] to be notified when the user selects a tab.
class BottomNavBar extends StatefulWidget {
  final ValueChanged<int>? onItemTapped;
  final int initialIndex;

  const BottomNavBar({
    Key? key,
    this.onItemTapped,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}


class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Call the callback if provided
    if (widget.onItemTapped != null) {
      widget.onItemTapped!(index);
    }

  //   // Handle navigation based on index
  //   switch (index) {
  //     case 0:
  //       // Navigate to Home
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //       break;
  //     case 1:
  //       // Navigate to QR Scanner
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const QrScanScreen()),
  //       );
  //       break;
  //     case 2:
  //       // Navigate to Notes
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const NfcPage()),
  //       );
  //       break;
  //     case 3:
  //       // Navigate to Schedule
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const SchedulePage()),
  //       );
  //       break;
  //     case 4:
  //       // Navigate to Profile
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const PlaceholderPage(title: 'Halaman Profil')),
  //       );
  //       break;
  //   }
  }
  

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nfc_outlined),
          label: 'NFC',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_history),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}