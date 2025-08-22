import 'package:flower_e_commerce/core/utils/constants/validator_constants.dart';
import 'package:flutter/widgets.dart';

class SignupValidators {
  static String? userNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    if (value.length < 3) {
      return "Username is too short";
    }
    return null;
  }

  static String? firstNameValidation(String? value) {
    final firstnameRegex = RegExp(ValidatorConstants.nameRegex);

    if (value == null || value.isEmpty) {
      return "First name is required";
    }
    if (value.length < 3) {
      return "First name is too short";
    }
    if (!firstnameRegex.hasMatch(value)) {
      return "Invalid first name";
    }

    return null;
  }

  static String? lastNameValidation(String? value) {
    final lastnameRegex = RegExp(ValidatorConstants.nameRegex);

    if (value == null || value.isEmpty) {
      return "Last name is required";
    }
    if (value.length < 3) {
      return "Last name is too short";
    }
    if (!lastnameRegex.hasMatch(value)) {
      return "Invalid last name";
    }

    return null;
  }

  static String? emailValidation(String? value) {
    final emailRegex = RegExp(ValidatorConstants.emailRegex);

    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!emailRegex.hasMatch(value)) {
      return "Invalid email address";
    }

    return null;
  }

  static String? passwordValidation(String? value) {
    final passwordRegex = RegExp(ValidatorConstants.passwordRegex);

    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (!passwordRegex.hasMatch(value)) {
      return "password length should be at min 6 chars . With upper case letter and a number at least";
    }
    return null;
  }

  static String? confirmPasswordValidation(
    String? value,
    TextEditingController? optionalValue,
  ) {
   

    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    if (value != optionalValue?.text) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    final phoneRegex = RegExp(ValidatorConstants.phoneRegex);

    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (!phoneRegex.hasMatch(value)) {
      return "Invalid phone number";
    }
    return null;
  }
}