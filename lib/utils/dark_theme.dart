import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  // scaffoldBackgroundColor: const Color(0xFF121B22),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey[900]!,
    // surface: const Color(0xFF121B22),
    primary: const Color.fromARGB(255, 27, 109, 244),
    onPrimary: Colors.white,
    secondary: Colors.grey, // secondary text & icons
    tertiary: Colors.grey[900], // status container
    // tertiary: const Color(0xFF121B22), // status container
    shadow: Colors.grey[700],
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: GoogleFonts.sora(
      color: Colors.white,
      fontSize: 17.sp,
      // fontWeight: FontWeight.w600,
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: GoogleFonts.sora(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white, // Choose your desired color
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: Colors.grey[800]!,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
    hintStyle: GoogleFonts.sora(
      fontSize: 12.sp,
      color: Colors.grey[400],
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 8.w,
      vertical: 8.h,
    ),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.grey,
    titleTextStyle: GoogleFonts.sora(
      color: Colors.white,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    subtitleTextStyle: GoogleFonts.sora(
      fontSize: 10.sp,
      color: Colors.grey,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white),
      backgroundColor: WidgetStateProperty.all(Colors.grey[800]),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 5.h,
        ),
      ),
      overlayColor: WidgetStatePropertyAll(Colors.grey[700]),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.sora(
          // color: Colors.white,
          fontSize: 11.sp,
        ),
      ),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    showCloseIcon: true,
    backgroundColor: Colors.grey[900],
    // backgroundColor: const Color(0xFF121B22),
    closeIconColor: Colors.white,
    contentTextStyle: GoogleFonts.sora(
      color: Colors.white,
      fontSize: 12.sp,
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(Colors.grey[900]
        // Color(0xFF121B22),
        ),
    textStyle: WidgetStatePropertyAll(
      GoogleFonts.sora(
        fontSize: 12.sp,
      ),
    ),
    hintStyle: WidgetStatePropertyAll(
      GoogleFonts.sora(
        fontSize: 12.sp,
        color: Colors.grey[300],
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey[900],
    // backgroundColor: const Color(0xFF121B22),
    titleTextStyle: GoogleFonts.sora(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: GoogleFonts.sora(
      color: Colors.white,
      fontSize: 12.sp,
    ),
  ),
  datePickerTheme: const DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      // foregroundColor: WidgetStatePropertyAll(
      //   Color.fromARGB(255, 168, 200, 249),
      // ),
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[400],
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 27, 109, 244)),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[700],
    thickness: 0.3,
  ),
);
