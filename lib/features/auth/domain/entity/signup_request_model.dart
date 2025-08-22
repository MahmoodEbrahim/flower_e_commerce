class SignupRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? repassword;
  String? gender;
  SignupRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.repassword,
    this.gender,
  });
}