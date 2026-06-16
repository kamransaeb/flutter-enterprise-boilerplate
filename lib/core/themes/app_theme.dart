// import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.light(
//       primary: Colors.blue.shade700,
//       secondary: Colors.blue.shade500,
//       background: Colors.grey.shade50,
//       surface: Colors.white,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onBackground: Colors.black,
//       onSurface: Colors.black,
//       error: Colors.red.shade700,
//       onError: Colors.white,
//     ),
//     scaffoldBackgroundColor: Colors.grey.shade50,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       elevation: 1,
//       shadowColor: Colors.grey.shade300,
//       titleTextStyle: const TextStyle(
//         color: Colors.black,
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     textTheme: const TextTheme(
//       displayLarge: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         letterSpacing: -0.5,
//       ),
//       displayMedium: TextStyle(
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//       ),
//       displaySmall: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//       headlineMedium: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       headlineSmall: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//       ),
//       titleLarge: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//       ),
//       bodyLarge: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.normal,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//       ),
//       bodySmall: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.normal,
//       ),
//       labelLarge: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),
//       labelMedium: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//       ),
//       labelSmall: TextStyle(
//         fontSize: 11,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue.shade700,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 16,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: Colors.blue.shade700,
//         side: BorderSide(color: Colors.blue.shade700),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 16,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: Colors.blue.shade700,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         textStyle: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.red.shade700, width: 2),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.red.shade700, width: 2),
//       ),
//       contentPadding: const EdgeInsets.all(16),
//       hintStyle: TextStyle(color: Colors.grey.shade600),
//       labelStyle: TextStyle(color: Colors.grey.shade700),
//       errorStyle: TextStyle(color: Colors.red.shade700),
//     ),
//     cardTheme: CardTheme(
//       color: Colors.white,
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       margin: const EdgeInsets.all(8),
//     ),
//     dialogTheme: DialogTheme(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 4,
//     ),
//     bottomSheetTheme: const BottomSheetThemeData(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       elevation: 8,
//     ),
//     chipTheme: ChipThemeData(
//       backgroundColor: Colors.grey.shade200,
//       deleteIconColor: Colors.grey.shade700,
//       disabledColor: Colors.grey.shade300,
//       selectedColor: Colors.blue.shade100,
//       secondarySelectedColor: Colors.blue.shade200,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       labelStyle: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       secondaryLabelStyle: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//       brightness: Brightness.light,
//     ),
//     dividerTheme: DividerThemeData(
//       color: Colors.grey.shade300,
//       thickness: 1,
//       space: 0,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.dark(
//       primary: Colors.blue.shade300,
//       secondary: Colors.blue.shade200,
//       background: Colors.grey.shade900,
//       surface: Colors.grey.shade800,
//       onPrimary: Colors.black,
//       onSecondary: Colors.black,
//       onBackground: Colors.white,
//       onSurface: Colors.white,
//       error: Colors.red.shade400,
//       onError: Colors.black,
//     ),
//     scaffoldBackgroundColor: Colors.grey.shade900,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.grey.shade800,
//       foregroundColor: Colors.white,
//       elevation: 1,
//       shadowColor: Colors.black.withOpacity(0.3),
//       titleTextStyle: const TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     textTheme: const TextTheme(
//       displayLarge: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         letterSpacing: -0.5,
//         color: Colors.white,
//       ),
//       displayMedium: TextStyle(
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       displaySmall: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       headlineMedium: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       headlineSmall: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//       titleLarge: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//       bodyLarge: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.normal,
//         color: Colors.white,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//         color: Colors.white,
//       ),
//       bodySmall: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.normal,
//         color: Colors.white,
//       ),
//       labelLarge: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//       labelMedium: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//       labelSmall: TextStyle(
//         fontSize: 11,
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue.shade300,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 16,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: Colors.blue.shade300,
//         side: BorderSide(color: Colors.blue.shade300),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 16,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: Colors.blue.shade300,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         textStyle: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey.shade800,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade700),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.red.shade400, width: 2),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.red.shade400, width: 2),
//       ),
//       contentPadding: const EdgeInsets.all(16),
//       hintStyle: TextStyle(color: Colors.grey.shade500),
//       labelStyle: TextStyle(color: Colors.grey.shade400),
//       errorStyle: TextStyle(color: Colors.red.shade400),
//     ),
//     cardTheme: CardTheme(
//       color: Colors.grey.shade800,
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       margin: const EdgeInsets.all(8),
//     ),
//     dialogTheme: DialogTheme(
//       backgroundColor: Colors.grey.shade800,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 4,
//     ),
//     bottomSheetTheme: BottomSheetThemeData(
//       backgroundColor: Colors.grey.shade800,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       elevation: 8,
//     ),
//     chipTheme: ChipThemeData(
//       backgroundColor: Colors.grey.shade700,
//       deleteIconColor: Colors.grey.shade400,
//       disabledColor: Colors.grey.shade800,
//       selectedColor: Colors.blue.shade800,
//       secondarySelectedColor: Colors.blue.shade700,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       labelStyle: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//       secondaryLabelStyle: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//       brightness: Brightness.dark,
//     ),
//     dividerTheme: DividerThemeData(
//       color: Colors.grey.shade700,
//       thickness: 1,
//       space: 0,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color primaryDarkColor = Color(0xFF1D4ED8);
  static const Color primaryLightColor = Color(0xFF60A5FA);

  static const Color secondaryColor = Color(0xFF7C3AED);
  static const Color secondaryDarkColor = Color(0xFF6D28D9);
  static const Color secondaryLightColor = Color(0xFFA78BFA);

  static const Color accentColor = Color(0xFFF59E0B);
  static const Color accentDarkColor = Color(0xFFD97706);
  static const Color accentLightColor = Color(0xFFFCD34D);

  // Semantic Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);

  // Neutral Colors - Light Theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF9FAFB);
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFF3F4F6);

  // Neutral Colors - Dark Theme
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkSurfaceVariant = Color(0xFF374151);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextTertiary = Color(0xFF6B7280);
  static const Color darkBorder = Color(0xFF374151);
  static const Color darkDivider = Color(0xFF1F2937);

  // Spacing
  static const double spacingXXS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Border Radius
  static const double radiusXS = 2.0;
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusRound = 999.0;

  // Elevation
  static const double elevation0 = 0;
  static const double elevation1 = 1;
  static const double elevation2 = 2;
  static const double elevation3 = 4;
  static const double elevation4 = 8;
  static const double elevation5 = 16;

  // Duration
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Get Light Theme
  static ThemeData getLightTheme({
    bool useDynamicColor = false,
    double fontSizeScale = 1.0,
    bool highContrast = false,
  }) {
    final ColorScheme colorScheme = useDynamicColor
        ? _getDynamicColorScheme(Brightness.light)
        : _getFixedColorScheme(Brightness.light, highContrast);

    return ThemeData(
      // Core
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,

      // Scaffold
      scaffoldBackgroundColor: lightBackground,

      // AppBar
      appBarTheme: _getLightAppBarTheme(colorScheme, highContrast),

      // Text
      textTheme: _getLightTextTheme(fontSizeScale, highContrast),
      primaryTextTheme: _getLightTextTheme(fontSizeScale, highContrast),

      // Buttons
      elevatedButtonTheme: _getElevatedButtonTheme(colorScheme, highContrast),
      outlinedButtonTheme: _getOutlinedButtonTheme(colorScheme, highContrast),
      textButtonTheme: _getTextButtonTheme(colorScheme, highContrast),
      floatingActionButtonTheme: _getFloatingActionButtonTheme(colorScheme),

      // Input
      inputDecorationTheme: _getInputDecorationTheme(highContrast),

      // Cards
      cardTheme: _getCardTheme(),
      cardColor: lightSurface,

      // Dialog
      dialogTheme: _getDialogTheme(),
      dialogBackgroundColor: lightBackground,

      // Bottom Sheet
      bottomSheetTheme: _getBottomSheetTheme(),

      // Navigation
      navigationBarTheme: _getNavigationBarTheme(colorScheme),
      navigationRailTheme: _getNavigationRailTheme(colorScheme),

      // Divider
      dividerTheme: _getDividerTheme(),
      dividerColor: lightDivider,

      // Icons
      iconTheme: _getIconTheme(highContrast),

      // Progress Indicators
      progressIndicatorTheme: _getProgressIndicatorTheme(colorScheme),

      // Snackbar
      snackBarTheme: _getSnackBarTheme(),

      // Tooltip
      tooltipTheme: _getTooltipTheme(),

      // Page Transitions
      pageTransitionsTheme: _getPageTransitionsTheme(),

      // Typography
      fontFamily: 'Inter',

      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Get Dark Theme
  static ThemeData getDarkTheme({
    bool useDynamicColor = false,
    double fontSizeScale = 1.0,
    bool highContrast = false,
  }) {
    final ColorScheme colorScheme = useDynamicColor
        ? _getDynamicColorScheme(Brightness.dark)
        : _getFixedColorScheme(Brightness.dark, highContrast);

    return ThemeData(
      // Core
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,

      // Scaffold
      scaffoldBackgroundColor: darkBackground,

      // AppBar
      appBarTheme: _getDarkAppBarTheme(colorScheme, highContrast),

      // Text
      textTheme: _getDarkTextTheme(fontSizeScale, highContrast),
      primaryTextTheme: _getDarkTextTheme(fontSizeScale, highContrast),

      // Buttons
      elevatedButtonTheme: _getElevatedButtonTheme(colorScheme, highContrast),
      outlinedButtonTheme: _getOutlinedButtonTheme(colorScheme, highContrast),
      textButtonTheme: _getTextButtonTheme(colorScheme, highContrast),
      floatingActionButtonTheme: _getFloatingActionButtonTheme(colorScheme),

      // Input
      inputDecorationTheme: _getInputDecorationTheme(highContrast),

      // Cards
      cardTheme: _getDarkCardTheme(),
      cardColor: darkSurface,

      // Dialog
      dialogTheme: _getDarkDialogTheme(),
      dialogBackgroundColor: darkSurface,

      // Bottom Sheet
      bottomSheetTheme: _getBottomSheetTheme(),

      // Navigation
      navigationBarTheme: _getNavigationBarTheme(colorScheme),
      navigationRailTheme: _getNavigationRailTheme(colorScheme),

      // Divider
      dividerTheme: _getDividerTheme(),
      dividerColor: darkDivider,

      // Icons
      iconTheme: _getIconTheme(highContrast),

      // Progress Indicators
      progressIndicatorTheme: _getProgressIndicatorTheme(colorScheme),

      // Snackbar
      snackBarTheme: _getSnackBarTheme(),

      // Tooltip
      tooltipTheme: _getTooltipTheme(),

      // Page Transitions
      pageTransitionsTheme: _getPageTransitionsTheme(),

      // Typography
      fontFamily: 'Inter',

      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // MARK: - Private Helper Methods

  static ColorScheme _getFixedColorScheme(
    Brightness brightness,
    bool highContrast,
  ) {
    if (brightness == Brightness.light) {
      return ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryLightColor,
        onPrimaryContainer: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLightColor,
        onSecondaryContainer: Colors.white,
        tertiary: accentColor,
        onTertiary: Colors.white,
        error: errorColor,
        onError: Colors.white,
        background: lightBackground,
        onBackground: lightTextPrimary,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        surfaceVariant: lightSurfaceVariant,
        onSurfaceVariant: lightTextSecondary,
        outline: lightBorder,
        shadow: Colors.black.withOpacity(0.1),
        inverseSurface: darkSurface,
        onInverseSurface: darkTextPrimary,
        inversePrimary: primaryLightColor,
        surfaceTint: primaryColor,
      );
    } else {
      return ColorScheme.dark(
        primary: primaryLightColor,
        onPrimary: Colors.black,
        primaryContainer: primaryColor,
        onPrimaryContainer: Colors.white,
        secondary: secondaryLightColor,
        onSecondary: Colors.black,
        secondaryContainer: secondaryColor,
        onSecondaryContainer: Colors.white,
        tertiary: accentLightColor,
        onTertiary: Colors.black,
        error: errorColor,
        onError: Colors.black,
        background: darkBackground,
        onBackground: darkTextPrimary,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        surfaceVariant: darkSurfaceVariant,
        onSurfaceVariant: darkTextSecondary,
        outline: darkBorder,
        shadow: Colors.black.withOpacity(0.3),
        inverseSurface: lightSurface,
        onInverseSurface: lightTextPrimary,
        inversePrimary: primaryColor,
        surfaceTint: primaryLightColor,
      );
    }
  }

  static ColorScheme _getDynamicColorScheme(Brightness brightness) {
    // This would integrate with Material You dynamic colors
    // For now, return fixed scheme
    return _getFixedColorScheme(brightness, false);
  }

  static AppBarTheme _getLightAppBarTheme(
    ColorScheme colorScheme,
    bool highContrast,
  ) {
    return AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: lightTextPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: elevation0,
      centerTitle: false,
      titleSpacing: spacingMD,
      toolbarHeight: 56,
      iconTheme: IconThemeData(color: lightTextPrimary, size: 24),
      actionsIconTheme: IconThemeData(color: lightTextPrimary, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      shape: const Border(bottom: BorderSide(color: lightDivider, width: 1)),
    );
  }

  static AppBarTheme _getDarkAppBarTheme(
    ColorScheme colorScheme,
    bool highContrast,
  ) {
    return AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkTextPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: elevation0,
      centerTitle: false,
      titleSpacing: spacingMD,
      toolbarHeight: 56,
      iconTheme: IconThemeData(color: darkTextPrimary, size: 24),
      actionsIconTheme: IconThemeData(color: darkTextPrimary, size: 24),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      shape: const Border(bottom: BorderSide(color: darkDivider, width: 1)),
    );
  }

  static TextTheme _getLightTextTheme(double scale, bool highContrast) {
    final Color textColor = highContrast ? Colors.black : lightTextPrimary;
    final Color secondaryColor = highContrast
        ? Colors.black87
        : lightTextSecondary;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57 * scale,
        height: 1.12,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 45 * scale,
        height: 1.16,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 36 * scale,
        height: 1.22,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 32 * scale,
        height: 1.25,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 28 * scale,
        height: 1.29,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 24 * scale,
        height: 1.33,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22 * scale,
        height: 1.27,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16 * scale,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * scale,
        height: 1.5,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12 * scale,
        height: 1.33,
        fontWeight: FontWeight.normal,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12 * scale,
        height: 1.33,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11 * scale,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme _getDarkTextTheme(double scale, bool highContrast) {
    final Color textColor = highContrast ? Colors.white : darkTextPrimary;
    final Color secondaryColor = highContrast
        ? Colors.white70
        : darkTextSecondary;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57 * scale,
        height: 1.12,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 45 * scale,
        height: 1.16,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 36 * scale,
        height: 1.22,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 32 * scale,
        height: 1.25,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 28 * scale,
        height: 1.29,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 24 * scale,
        height: 1.33,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22 * scale,
        height: 1.27,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16 * scale,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * scale,
        height: 1.5,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12 * scale,
        height: 1.33,
        fontWeight: FontWeight.normal,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14 * scale,
        height: 1.43,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12 * scale,
        height: 1.33,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11 * scale,
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
    );
  }

  static ElevatedButtonThemeData _getElevatedButtonTheme(
    ColorScheme colorScheme,
    bool highContrast,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
        elevation: elevation0,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingSM,
        ),
        minimumSize: const Size(88, 48),
        maximumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMD),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _getOutlinedButtonTheme(
    ColorScheme colorScheme,
    bool highContrast,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        side: BorderSide(color: colorScheme.outline, width: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingSM,
        ),
        minimumSize: const Size(88, 48),
        maximumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMD),
        ),
      ),
    );
  }

  static TextButtonThemeData _getTextButtonTheme(
    ColorScheme colorScheme,
    bool highContrast,
  ) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingSM,
          vertical: spacingSM,
        ),
        minimumSize: const Size(64, 36),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMD),
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData _getFloatingActionButtonTheme(
    ColorScheme colorScheme,
  ) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: elevation4,
      focusElevation: elevation5,
      hoverElevation: elevation4,
      disabledElevation: elevation0,
      shape: const CircleBorder(),
      extendedTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static InputDecorationTheme _getInputDecorationTheme(bool highContrast) {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingSM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: lightBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: lightBorder.withOpacity(0.5), width: 1),
      ),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      helperStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      counterStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      prefixIconColor: lightTextSecondary,
      suffixIconColor: lightTextSecondary,
      errorMaxLines: 2,
      isDense: true,
    );
  }

  static DialogThemeData _getDialogThemeData() {
    return DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXL),
      ),
      elevation: elevation5,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static BottomSheetThemeData _getBottomSheetTheme() {
    return const BottomSheetThemeData(
      elevation: elevation4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXL)),
      ),
      clipBehavior: Clip.antiAlias,
      showDragHandle: true,
    );
  }

  static NavigationBarThemeData _getNavigationBarTheme(
    ColorScheme colorScheme,
  ) {
    return NavigationBarThemeData(
      elevation: elevation2,
      height: 64,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      indicatorColor: colorScheme.primaryContainer.withOpacity(0.3),
      surfaceTintColor: Colors.transparent,
    );
  }

  static NavigationRailThemeData _getNavigationRailTheme(
    ColorScheme colorScheme,
  ) {
    return NavigationRailThemeData(
      elevation: elevation2,
      labelType: NavigationRailLabelType.selected,
      groupAlignment: -1.0,
      useIndicator: true,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      indicatorColor: colorScheme.primaryContainer.withOpacity(0.3),
    );
  }

  static DividerThemeData _getDividerTheme() {
    return const DividerThemeData(
      space: spacingMD,
      thickness: 1,
      indent: spacingMD,
      endIndent: spacingMD,
    );
  }

  static IconThemeData _getIconTheme(bool highContrast) {
    return IconThemeData(
      size: 24,
      color: highContrast ? null : lightTextSecondary,
    );
  }

  static ProgressIndicatorThemeData _getProgressIndicatorTheme(
    ColorScheme colorScheme,
  ) {
    return ProgressIndicatorThemeData(
      strokeWidth: 1,
      strokeCap: StrokeCap.round,
      color: colorScheme.primary,
      circularTrackColor: colorScheme.surfaceVariant,
      linearTrackColor: colorScheme.surfaceVariant,
      refreshBackgroundColor: colorScheme.surface,
    );
  }

  static SnackBarThemeData _getSnackBarTheme() {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      elevation: elevation4,
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryColor,
    );
  }

  static TooltipThemeData _getTooltipTheme() {
    return TooltipThemeData(
      height: 32,
      padding: const EdgeInsets.symmetric(
        horizontal: spacingSM,
        vertical: spacingXS,
      ),
      margin: const EdgeInsets.all(spacingSM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusSM),
        color: Colors.black87,
      ),
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  static PageTransitionsTheme _getPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
      },
    );
  }

  // MARK: - Component Theme Functions
  static CardThemeData _getCardTheme() {
    return CardThemeData(
      elevation: elevation1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLG),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: lightSurface,
      shadowColor: Colors.black.withOpacity(0.05),
      surfaceTintColor: Colors.transparent,
    );
  }

  static CardThemeData _getDarkCardTheme() {
    return CardThemeData(
      elevation: elevation1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLG),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: darkSurface,
      shadowColor: Colors.black.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
    );
  }

  static DialogThemeData _getDialogTheme() {
    return DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXL),
      ),
      elevation: elevation5,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightTextSecondary,
      ),
      backgroundColor: lightBackground,
      surfaceTintColor: Colors.transparent,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingSM,
      ),
    );
  }

  static DialogThemeData _getDarkDialogTheme() {
    return DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXL),
      ),
      elevation: elevation5,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: darkTextSecondary,
      ),
      backgroundColor: darkSurface,
      surfaceTintColor: Colors.transparent,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingSM,
      ),
    );
  }
}
