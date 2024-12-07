import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class Toasts {
  void showToast(context, icon, title) {
    DelightToastBar(
        builder: (context) {
          return ToastCard(
            shadowColor: Theme.of(context).colorScheme.shadow,
            leading: Icon(
              icon, ///////////////////////////////
              size: 25.sp,
              // size: width * 0.07,
            ),
            title: Text(
              title, /////////////////////////////////////
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                // fontSize: width * 0.035,
                // fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(
          milliseconds: 1500,
        )).show(context);
  }

  void openSettingsToast(context, icon, title) {
    DelightToastBar(
            builder: (context) {
              return ToastCard(
                shadowColor: Theme.of(context).colorScheme.shadow,
                leading: Icon(
                  icon, /////////////////////
                  size: 25.sp,
                ),
                title: Text(
                  title, ////////////////////////
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () => openAppSettings(), ///////////////////////////////
              );
            },
            position: DelightSnackbarPosition.top,
            autoDismiss: true,
            snackbarDuration: const Duration(milliseconds: 1500))
        .show(context);
  }
}
