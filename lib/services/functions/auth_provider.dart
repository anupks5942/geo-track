import 'package:flutter/material.dart';
import 'package:geo_track/services/providers/auth_data_provider.dart';
import 'package:geo_track/services/functions/auth_state_builder.dart';
import 'package:geo_track/utils/custom_exception.dart';
import 'package:geo_track/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends AuthDataProvider {
  bool _hasSelectedSignUpView = false;
  bool get hasSelectedSignUpView => _hasSelectedSignUpView;

  toggleAuthView() {
    _hasSelectedSignUpView = !_hasSelectedSignUpView;
    notifyListeners();
  }

  signUpUsingEmailAndPassword({
    required String name,
    required String email,
    // required String role,
    required String password,
    required String dob,
    required String department,
    required String phone,
    required String gender,
    required BuildContext context,
  }) async {
    try {
      setBusy();
      await authService.signUp(email: email, password: password);

      String docName = email.split('@')[0];

      try {
        await FirebaseFirestore.instance.collection('users').doc(docName).set({
          'name': name,
          'email': email,
          // 'role': role,
          'dob': dob,
          'dept': department,
          'gender': gender,
          'phone': phone,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } on FirebaseException catch (e) {
        Utils.alertUser(context, e.toString(), Colors.red);
      }

      setFree();
      Utils.removeAllAndPush(context, const AuthStateBuilder());
    } on CustomException catch (e) {
      setFree();
      Utils.alertUser(context, e.message, Colors.red);
    }
  }

  signInUsingEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setBusy();
    try {
      await authService.signIn(email: email, password: password);
      Utils.removeAllAndPush(context, const AuthStateBuilder());
      setFree();
    } on CustomException catch (e) {
      setFree();
      if (e.code == 'user-not-found') {
        Utils.alertUser(
            context, "No user found, try signing up instead!", Colors.red);
        return;
      }
      Utils.alertUser(context, e.message, Colors.red);
    }
  }

  resetPassword(String? email, BuildContext context) async {
    setBusy();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      Utils.alertUser(
        context,
        "Password reset link has been sent to your email. Please check your inbox (or spam folder) to proceed.",
        Colors.green,
      );

      setFree();
    } on CustomException catch (e) {
      setFree();

      if (e.code == 'user-not-found') {
        Utils.alertUser(
          context,
          "No user found, try signing up instead!",
          Colors.red,
        );
        return;
      }

      Utils.alertUser(
        context,
        e.message,
        Colors.red,
      );
    }
  }
}
