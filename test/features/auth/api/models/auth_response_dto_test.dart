import 'package:flower_e_commerce/features/auth/api/models/auth_response/auth_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';

void main() {
  group("Test AuthResponseDto", () {

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