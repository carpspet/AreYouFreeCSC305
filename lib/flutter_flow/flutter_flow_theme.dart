// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color buttonColor;
  late Color customColor1;
  late Color borderColor;
  late Color blue;
  late Color border2;
  late Color calendarTop;
  late Color gold;
  late Color redd;
  late Color orange;
  late Color yellow;
  late Color limeGreen;
  late Color green;
  late Color aqua;
  late Color realBlue;
  late Color pink;
  late Color purple;
  late Color black;
  late Color white;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0xFF4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color buttonColor = const Color(0x4AA86CA9);
  late Color customColor1 = const Color(0xFFDD534C);
  late Color borderColor = const Color(0xCFA839EF);
  late Color blue = const Color(0xFF00B2FF);
  late Color border2 = const Color(0xFF2E9DC9);
  late Color calendarTop = const Color(0xFF74CAEE);
  late Color gold = const Color(0xCFD1AF13);
  late Color redd = const Color(0xFFFF0000);
  late Color orange = const Color(0xFFFFA500);
  late Color yellow = const Color(0xFFFFFF00);
  late Color limeGreen = const Color(0xFF00FF00);
  late Color green = const Color(0xFF008000);
  late Color aqua = const Color(0xFF00FFFF);
  late Color realBlue = const Color(0xFF0000FF);
  late Color pink = const Color(0xFFFF00FF);
  late Color purple = const Color(0xFF800080);
  late Color black = const Color(0xFF000000);
  late Color white = const Color(0xFFFFFFFF);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Lato';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 64.0,
        fontStyle: FontStyle.normal,
      );
  String get displayMediumFamily => 'Lato';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
        fontStyle: FontStyle.normal,
      );
  String get displaySmallFamily => 'Lato';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 36.0,
        fontStyle: FontStyle.normal,
      );
  String get headlineLargeFamily => 'Lato';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28.0,
        fontStyle: FontStyle.normal,
      );
  String get headlineMediumFamily => 'Lato';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 22.0,
        fontStyle: FontStyle.normal,
      );
  String get headlineSmallFamily => 'Lato';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 22.0,
        fontStyle: FontStyle.normal,
      );
  String get titleLargeFamily => 'Lato';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 22.0,
        fontStyle: FontStyle.normal,
      );
  String get titleMediumFamily => 'Lato';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
      );
  String get titleSmallFamily => 'Lato';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
      );
  String get labelLargeFamily => 'Lato';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
      );
  String get labelMediumFamily => 'Lato';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
      );
  String get labelSmallFamily => 'Lato';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Lato';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Lato';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Lato';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFF262D34);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xEBFFFFFF);
  late Color primaryBackground = const Color(0xFF1D2428);
  late Color secondaryBackground = const Color(0xFF14181B);
  late Color accent1 = const Color(0xCFA839EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color buttonColor = const Color(0xFF4AAB04);
  late Color customColor1 = const Color(0xFFDD534C);
  late Color borderColor = const Color(0xFFF213AC);
  late Color blue = const Color(0xFF008113);
  late Color border2 = const Color(0xFFE9900A);
  late Color calendarTop = const Color(0xFF92CDC1);
  late Color gold = const Color(0xCFD1AF13);
  late Color redd = const Color(0xFFD92148);
  late Color orange = const Color(0xFFA9C58D);
  late Color yellow = const Color(0xFFA5C18E);
  late Color limeGreen = const Color(0xFF23624C);
  late Color green = const Color(0xFF751931);
  late Color aqua = const Color(0xFF91424F);
  late Color realBlue = const Color(0xFF1CA2FD);
  late Color pink = const Color(0xFFE5FEB7);
  late Color purple = const Color(0xFFB2605B);
  late Color black = const Color(0xFF80BBCE);
  late Color white = const Color(0xFF49EE89);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            );
}
