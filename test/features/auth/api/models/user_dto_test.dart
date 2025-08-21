import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      "when call toModel function in user_dto with null values it should return userModel with null values",
      () {
    //arrange

    UserDto userDto = UserDto(
      id: null,
      firstName: null,
      lastName: null,
      email: null,
      gender: null,
      phone: null,
      photo: null,
      role: null,
      wishlist: null,
      addresses: null,
      createdAt: null,
    );

    //act
    UserModel userModel = userDto.toUserModel();

    //assert
    expect(userModel.firstName, null);
    expect(userModel.lastName, null);
    expect(userModel.email, null);
    expect(userModel.gender, null);
    expect(userModel.phone, null);
    expect(userModel.photo, null);
    expect(userModel.role, null);
    expect(userModel.wishlist, null);
    expect(userModel.addresses, null);
  });

  test(
      "when call toModel function in user_dto with non-null values it should return userModel with same values",
      () {
    //arrange
    UserDto userDto = UserDto(
      id: "1",
      firstName: "jana",
      lastName: "mohamed",
      email: "jana.mohamed@example.com",
      gender: "male",
      phone: "1234567890",
      photo: "photo_url",
      role: "user",
      wishlist: ["item1", "item2"],
      addresses: ["address1", "address2"],
      createdAt: DateTime.parse("2024-01-01T00:00:00.000Z"),
    );

    //act
    UserModel userModel = userDto.toUserModel();

    //assert
    expect(userModel.firstName, "jana");
    expect(userModel.lastName, "mohamed");
    expect(userModel.email, "jana.mohamed@example.com");
    expect(userModel.gender, "male");
    expect(userModel.phone, "1234567890");
    expect(userModel.photo, "photo_url");
    expect(userModel.role, "user");
    expect(userModel.wishlist, ["item1", "item2"]);
    expect(userModel.addresses, ["address1", "address2"]);
  });
}
