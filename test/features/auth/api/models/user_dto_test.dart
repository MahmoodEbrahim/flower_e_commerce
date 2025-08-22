import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

void main() {
  group('Test UserDto', () {
    test('fromJson should create UserDto correctly', () {
      // arrange
      final json = {
        "_id": "1",
        "firstName": "Rana",
        "lastName": "Gebril",
        "email": "test@test.com",
        "gender": "female",
        "phone": "0111111111",
        "photo": "",
        "role": "user",
        "wishlist": ["item1", "item2"],
        "addresses": ["address1", "address2"],
        "createdAt": "2025-08-20T12:00:00.000Z"
      };

      // act
      final dto = UserDto.fromJson(json);

      // assert
      expect(dto.id, "1");
      expect(dto.firstName, "Rana");
      expect(dto.lastName, "Gebril");
      expect(dto.email, "test@test.com");
      expect(dto.gender, "female");
      expect(dto.phone, "0111111111");
      expect(dto.photo, "");
      expect(dto.role, "user");
      expect(dto.wishlist, ["item1", "item2"]);
      expect(dto.addresses, ["address1", "address2"]);
      expect(dto.createdAt, DateTime.parse("2025-08-20T12:00:00.000Z"));
    });

    test('toJson should return correct Map', () {
      // arrange
      final dto = UserDto(
        id: "1",
        firstName: "Rana",
        lastName: "Gebril",
        email: "test@test.com",
        gender: "female",
        phone: "0111111111",
        photo: "",
        role: "user",
        wishlist: ["item1", "item2"],
        addresses: ["address1", "address2"],
        createdAt: DateTime.parse("2025-08-20T12:00:00.000Z"),
      );

      // act
      final json = dto.toJson();

      // assert
      expect(json["_id"], "1");
      expect(json["firstName"], "Rana");
      expect(json["lastName"], "Gebril");
      expect(json["email"], "test@test.com");
      expect(json["gender"], "female");
      expect(json["phone"], "0111111111");
      expect(json["photo"], "");
      expect(json["role"], "user");
      expect(json["wishlist"], ["item1", "item2"]);
      expect(json["addresses"], ["address1", "address2"]);
      expect(json["createdAt"], "2025-08-20T12:00:00.000Z");
    });

    test('toUserModel should map to UserModel correctly', () {
      // arrange
      final dto = UserDto(
        firstName: "Rana",
        lastName: "Gebril",
        phone: "0111111111",
        email: "test@test.com",
        gender: "female",
        photo: "",
        role: "user",
        wishlist: ["item1", "item2"],
        addresses: ["address1", "address2"],
      );

      // act
      final model = dto.toUserModel();

      // assert
      expect(model, isA<UserModel>());
      expect(model.firstName, "Rana");
      expect(model.lastName, "Gebril");
      expect(model.phone, "0111111111");
      expect(model.email, "test@test.com");
      expect(model.gender, "female");
      expect(model.photo, "");
      expect(model.role, "user");
      expect(model.wishlist, ["item1", "item2"]);
      expect(model.addresses, ["address1", "address2"]);
    });
  });
}
