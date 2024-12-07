import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter an email.";
    }
    else if (!EmailValidator.validate(value)) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return "Please enter a password.";
    }
    else if (value.length < 6) {
      return "Password must be 6 characters or more.";
    }
    return null;
  }

  static String? validateName(String? value){
    if(value!.trim().isEmpty){
      return "Please enter your name.";
    } else if(value.length<3) {
      return "Name must be 3 characters or more.";
    }
    return null;
  }

  static String? validateField(String? value){
    if(value!.trim().isEmpty){
      return "Please enter your name.";
    }
    return null;
  }
}
