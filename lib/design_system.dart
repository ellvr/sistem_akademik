import 'package:flutter/material.dart';

// ----- Design System -----
class AppColors {
  AppColors._();

  // WARNA Primary
  static const Color primary = Color(0xFF0482A8); // Blue Normal:active
  static const Color secondary = Color(0xFF05A3D2); // Blue Normal
  static const Color dark = Color(0xFF047A9E); // Blue Dark
  static const Color darker = Color(0xFF02394A); // Blue Darker
  static const Color lightActive = Color(0xFFB2E2F1); // Blue Light:Active

  //Warna Accent
  static const Color accent = Color(0xFFF4741B);
  static const Color light = Color(0xFFFCD4B8);

  // WARNA Natural text
  static const Color textPrimary = Color(0xFF151515);
  static const Color textSecondary = Color(0xFF383838);
  static const Color textOnPrimary = Color(0xFFfefefe);
  static const Color textDisabled = Color(0xFF757575);

  static const Color background = Color(
    0xFFF5F5F5,
  ); // Latar belakang (grey[100])
  static const Color surface = Colors.white; // Latar belakang kartu/kontainer

  static const Color success = Color(0xFF34B83A); // Hijau
  static const Color warning = Color(0xFFF9A825); // Kuning
  static const Color error = Color(0xFFC62828); // Merah
}

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle profileName = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle profileGreeting = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
  );

  static const TextStyle cardTitle = TextStyle(
    color: AppColors.textOnPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle cardSubtitle = TextStyle(
    color: Colors.white70,
    fontSize: 13,
  );

  static const TextStyle cardBody = TextStyle(
    color: AppColors.textOnPrimary,
    fontSize: 13,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.accent,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle itemTitle = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle itemSubtitle = TextStyle(
    color: AppColors.textDisabled,
    fontSize: 13,
  );

  static const TextStyle bodyText = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
    height: 1.4,
  );
}

class AppSpacing {
  AppSpacing._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
}

class AppRadius {
  AppRadius._();

  static const double card = 16.0;
  static const double button = 20.0;
  static const double container = 24.0;
}
