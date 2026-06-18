import 'package:flutter/material.dart';

class AppColors {
  static const navy900 = Color(0xFF0A0E1A);
  static const navy800 = Color(0xFF111827);
  static const navy700 = Color(0xFF1A2332);
  static const navy600 = Color(0xFF243044);

  static const teal500 = Color(0xFF14B8A6);
  static const teal400 = Color(0xFF2DD4BF);
  static const teal300 = Color(0xFF5EEAD4);

  static const gold500 = Color(0xFFD4A853);
  static const gold400 = Color(0xFFE8C468);
  static const gold300 = Color(0xFFF5D98A);

  static const purple500 = Color(0xFF8B5CF6);
  static const pink500 = Color(0xFFEC4899);
  static const red500 = Color(0xFFEF4444);
  static const blue500 = Color(0xFF3B82F6);

  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);

  static const glassFill = Color(0x1AFFFFFF);
  static const glassBorder = Color(0x33FFFFFF);

  static const vipBronze = Color(0xFFCD7F32);
  static const vipSilver = Color(0xFFC0C0C0);
  static const vipGold = Color(0xFFFFD700);
  static const vipDiamond = Color(0xFF67E8F9);
  static const svipPurple = Color(0xFFA855F7);
  static const svipCrimson = Color(0xFFDC2626);

  static List<Color> get backgroundGradient => [
        navy900,
        const Color(0xFF0F172A),
        navy700,
      ];

  static List<Color> get accentGradient => [teal500, teal400, gold400];

  static List<Color> get vipGradient => [gold500, gold300, gold400];

  static List<Color> get svipGradient => [purple500, pink500, gold400];

  static Color vipColorForTier(int tier) {
    switch (tier) {
      case 1:
        return vipBronze;
      case 2:
        return vipSilver;
      case 3:
        return vipGold;
      case 4:
        return vipDiamond;
      case 5:
        return svipPurple;
      case 6:
        return svipCrimson;
      default:
        return textMuted;
    }
  }
}
