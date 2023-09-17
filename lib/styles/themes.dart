import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData theme = ThemeData(
   colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
  ),textTheme: GoogleFonts.questrialTextTheme(),
  useMaterial3: true,
);
