import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/api/models/auth_response/auth_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';

void main() {
  group("Test AuthResponseDto", () {

    test("toLoginModel should convert correctly", () {
      final List<Address>address=[
        Address(
        city: "fkwjk",
        username: "ajfwejfw",
        
      ),
        Address(
        city: "erger",
        username: "ajfwegwegewejfw",
        
      ),
      ];
      // arrange
      final dto = AuthResponseDto(
        message: "Login success",
        token: "abc123",
        user: UserDto(
          id: "1",
          firstName: "Rana",
          lastName: "Gebril",
          email: "rana@test.com",
          addresses: address
          
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