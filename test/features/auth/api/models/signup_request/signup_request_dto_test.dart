import 'package:flower_e_commerce/features/auth/api/models/signup_request/signup_request_dto.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:test/test.dart';

void main() {
  test(
      "when call toDto function with null values it should return signup_request_dto with null values  ",
      () {
//Arrange
    SignupRequestModel signupRequestModel = SignupRequestModel(
        firstName: null,
        lastName: null,
        password: null,
        repassword: null,
        phone: null,
        gender: null,
        email: null);

    //Act
    SignupRequestDto result = SignupRequestDto.toDto(signupRequestModel);
     

    //Assert
    expect(result.email, isNull);
    expect(result.password, isNull);
    expect(result.rePassword, isNull);
    expect(result.phone, isNull);
    expect(result.firstName, isNull);
    expect(result.lastName, isNull);
    expect(result.gender, isNull);
  });



  test(
      "when call toDto function with non_null values it should return signup_request_dto with correct values  ",
      () {
//Arrange
    SignupRequestModel signupRequestModel = SignupRequestModel(
       firstName: "ayayay",
    lastName: "Tech",
    email: "aya222@gmail.com",
    password: "Ahmed@123",
    repassword: "Ahmed@123",
    phone: "+201010700999",
    gender: "male",);

    //Act
    SignupRequestDto result = SignupRequestDto.toDto(signupRequestModel);
     

    //Assert
    expect(result.email, signupRequestModel.email);
    expect(result.password, signupRequestModel.password);
    expect(result.rePassword, signupRequestModel.repassword);
    expect(result.phone, signupRequestModel.phone);
    expect(result.firstName, signupRequestModel.firstName);
    expect(result.lastName, signupRequestModel.lastName);
    expect(result.gender, signupRequestModel.gender);
  });



}
