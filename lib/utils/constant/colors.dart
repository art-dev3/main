// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E40AF); // Primary  (blue)
  static const Color secondary = Color(
    0xFFF59E0B,
  ); // Secondary (yellow - also used in icons)

  // Backgrounds
  static const Color background = Color(0xFFF1F5F9); // App main background
  static const Color white = Color(0xFFFFFFFF); // Card backgrounds
  static const Color publicServiceCardBackground1 = Color(
    0xFFDBEAFE,
  ); // Public service card background 1
  static const Color publicServiceCardBackground2 = Color(
    0xFFFED7AA,
  ); // Public service card background 2
  static const Color publicServiceCardBackground3 = Color(
    0xFFA7F3D0,
  ); // Public service card background 2

  // Text Colors
  static const Color gray800 = Color(
    0xFF1E293B,
  ); // Titles of cards and articles, main body
  static const Color gray600 = Color(0xFF475569); // Sub-titles, descriptions
  static const Color gray500 = Color(
    0xFF64748B,
  ); // Less-used alternate for secondary
  static const Color gray400 = Color(0xFF94A3B8); // Hints, timestamps
  static const Color gray300 = Color(0xFFCBD5E1); // For disabled buttons
  static const Color gray200 = Color(0xFFE2E8F0); // For borders
  static const Color red500 = Color(0xFFEF4444); // Error messages
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate800 = Color(0xFF1E293B);
}
