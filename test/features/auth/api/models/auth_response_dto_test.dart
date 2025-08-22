import 'package:flower_e_commerce/features/auth/api/models/auth_response/auth_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';

void main() {
  group("Test AuthResponseDto", () {
    test("fromJson should parse correctly", () {
      // arrange
      final json = {
        "message": "Login success",
        "token": "abc123",
        "user": {
          "_id": "1",
          "firstName": "Rana",
          "lastName": "Gebril",
          "email": "test@test.com",
        }
      };

      // act
      final dto = AuthResponseDto.fromJson(json);

      // assert
      expect(dto.message, "Login success");
      expect(dto.token, "abc123");
      expect(dto.user?.firstName, "Rana");
      expect(dto.user?.lastName, "Gebril");
      expect(dto.user?.email, "test@test.com");
    });

    test("toJson should return the same map", () {
      // arrange
      final dto = AuthResponseDto(
        message: "Login success",
        token: "abc123",
        user: UserDto(
          id: "1",
          firstName: "Rana",
          lastName: "Gebril",
          email: "test@test.com",
        ),
      );

      // act
      final json = dto.toJson();

      // assert
      expect(json["message"], "Login success");
      expect(json["token"], "abc123");

      final userJson = (json["user"] as UserDto).toJson();
      expect(userJson["firstName"], "Rana");
      expect(userJson["lastName"], "Gebril");
      expect(userJson["email"], "test@test.com");
    });

    test("toLoginModel should convert correctly", () {
      // arrange
      final dto = AuthResponseDto(
        message: "Login success",
        token: "abc123",
        user: UserDto(
          id: "1",
          firstName: "Rana",
          lastName: "Gebril",
          email: "rana@test.com",
        ),
      );

      // act
      final loginModel = dto.toLoginModel();

      // assert
      expect(loginModel.token, "abc123");
      expect(loginModel.user.firstName, "Rana");
      expect(loginModel.user.lastName, "Gebril");
      expect(loginModel.user.email, "rana@test.com");
    });
  });
}
