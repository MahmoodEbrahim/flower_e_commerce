class Validator {
  Validator._();
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null) {
      return 'This Email field is required';
    } else if (val.trim().isEmpty) {
      return 'This  Email field is required';
    } else if (emailRegex.hasMatch(val) == false) {
      return 'This Email is not valid';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null) {
      return 'This Password field is required';
    } else if (val.isEmpty) {
      return 'This Password is required';
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return 'This Password is not valid';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val != password) {
      return 'same password';
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null) {
      return 'this field is required';
    } else if (val.isEmpty) {
      return 'this field is required';
    } else if (!usernameRegex.hasMatch(val)) {
      return 'enter valid username';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return 'this field is required';
    } else if (int.tryParse(val.trim()) == null) {
      return 'enter numbers only';
    } else if (val.trim().length != 11) {
      return 'enter value must equal 11 digit';
    } else {
      return null;
    }
  }
}