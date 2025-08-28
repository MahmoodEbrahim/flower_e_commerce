class ValidatorConstants {
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  static const String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
  static const String nameRegex = r'^[a-zA-Z]+$';

  static const String lognEmailRegex = r'^[^@]+@[^@]+\.[^@]+$';
    static const String phoneRegex = r'^\+20\d{10}$';

}