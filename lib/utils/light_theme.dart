import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[300],
  colorScheme: ColorScheme.light(
    surface: Colors.grey[300]!,
    primary: const Color.fromARGB(255, 27, 109, 244),
    onPrimary: Colors.white,
    secondary: Colors.black54, // secondary text & icons
    tertiary: Colors.white, // status container
    shadow: Colors.grey[400],
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 17.sp,
      // fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, // Choose your desired color
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    hintStyle: GoogleFonts.poppins(
      fontSize: 12.sp,
      color: Colors.grey[600],
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 8.w,
      vertical: 8.h,
    ),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.black54,
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    subtitleTextStyle: GoogleFonts.poppins(
      fontSize: 10.sp,
      color: Colors.black54,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
      backgroundColor: WidgetStateProperty.all(Colors.black12),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 5.h,
        ),
      ),
      overlayColor: WidgetStatePropertyAll(Colors.grey[400]),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.poppins(
          //   color: Colors.black,
          fontSize: 11.sp,
        ),
      ),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    showCloseIcon: true,
    backgroundColor: Colors.grey[300],
    closeIconColor: Colors.black,
    contentTextStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 12.sp,
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: const WidgetStatePropertyAll(Colors.white),
    textStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: 12.sp,
      ),
    ),
    hintStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: 12.sp,
        color: Colors.grey,
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey[300],
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 18.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 12.sp,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[600],
  ),
  datePickerTheme: const DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      // foregroundColor: WidgetStatePropertyAll(
      //   Color.fromARGB(255, 27, 109, 244),
      // ),
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 27, 109, 244)),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
    thickness: 0.3,
  ),
);
