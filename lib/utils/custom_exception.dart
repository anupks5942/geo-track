import 'dart:developer';

class CustomException implements Exception {
  String message;
  String? code;

  CustomException(this.message, {this.code}) {
    log(toString());
  }

  @override
  String toString() {
    return "CustomException: $message";
  }
}
