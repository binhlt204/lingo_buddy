import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Soft Cozy Pastel Palette
  static const Color background = Color(0xFFFBF9F5); // Kem sữa dịu ấm
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3EFEA);

  // Brand Accents
  static const Color primary = Color(0xFF4A7C59); // Xanh Matcha ấm
  static const Color primaryLight = Color(0xFFE8F1EC);
  static const Color primaryDark = Color(0xFF2C553B);

  static const Color secondary = Color(0xFFE7835E); // Cam đào ấm
  static const Color secondaryLight = Color(0xFFFDEEE8);

  static const Color accentYellow = Color(0xFFF3C760); // Vàng mật ong pastel
  static const Color accentPurple = Color(0xFFA688B7); // Tím lavender pastel
  static const Color accentBlue = Color(0xFF7FA8C9);   // Xanh da trời pastel

  // Text
  static const Color textMain = Color(0xFF263238);
  static const Color textSub = Color(0xFF6B7A82);
  static const Color textMuted = Color(0xFF9EABB2);

  // Status & SRS
  static const Color srsHard = Color(0xFFE57373);   // Đỏ đào (Khó)
  static const Color srsMedium = Color(0xFFF6B26B); // Cam vàng (Vừa)
  static const Color srsEasy = Color(0xFF81C784);   // Xanh mạ (Dễ)

  // Border & Divider
  static const Color border = Color(0xFFEBE6DF);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.nunito().fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        onSurface: AppColors.textMain,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border, width: 1.2),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textMain),
      ),
    );
  }
}
