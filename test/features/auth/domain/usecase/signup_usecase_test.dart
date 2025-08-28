import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignupUsecase signupUsecase;
  late AuthRepository mockAuthRespository;
  late SignupRequestModel fakeSignupRequestModel;
  late UserModel fakeUser;
  setUpAll(() {
    mockAuthRespository = MockAuthRepository();
    signupUsecase = SignupUsecase(mockAuthRespository);
    fakeSignupRequestModel = SignupRequestModel(
        firstName: "Aya",
        lastName: "Saber",
        email: "aya.saber@example.com",
        password: "Ahmed@123",
        repassword: "Ahmed@123",
        phone: "+201234567890",
        gender: "female",
      );

      fakeUser = UserModel(
        firstName: "Aya",
        lastName: "Saber",
        email: "aya.saber@example.com",
        gender: "female",
        phone: "+201234567890",
        photo: "https://example.com/avatar.png",
        role: "customer",
        wishlist: ["prod_1", "prod_2", "prod_3"],
        addresses: [
          {
            "street": "123 Nile Street",
            "city": "Cairo",
            "country": "Egypt",
            "zip": "12345"
          },
          {
            "street": "456 Pyramid Road",
            "city": "Giza",
            "country": "Egypt",
            "zip": "67890"
          }
        ],
      );

  });

  group('test SignupUsecase', () {
    test(
        "when call signUp in SignupUsecase with correctParameters it should return successApiResult",
        () async {
      // arange

     
      final mockResult = ApiSucessResult<UserModel>(fakeUser);
      provideDummy<ApiResult<UserModel>>(mockResult);

      when(mockAuthRespository.signUp(fakeSignupRequestModel))
          .thenAnswer((_) async => mockResult);

      //act
      final result = await signupUsecase.signUp(fakeSignupRequestModel);

      //assert
      expect(result, isA<ApiSucessResult<UserModel>>());
      final acResult = result as ApiSucessResult<UserModel>;
      expect(acResult.sucessResult.firstName, equals("Aya"));
      expect(acResult.sucessResult.email, equals("aya.saber@example.com"));

      verify(mockAuthRespository.signUp(fakeSignupRequestModel)).called(1);
    });

    test(
        "when call signUp in SignupUsecase with incorrect parameters it should return failedApiResult",
        () async {
      // arrange
     
      final mockError = ApiFailedResult<UserModel>("Invalid signup data");
      provideDummy<ApiResult<UserModel>>(mockError);

      when(mockAuthRespository.signUp(fakeSignupRequestModel))
          .thenAnswer((_) async => mockError);

      // act
      final result = await signupUsecase.signUp(fakeSignupRequestModel);

      // assert
      expect(result, isA<ApiFailedResult<UserModel>>());
      final acResult = result as ApiFailedResult<UserModel>;
      expect(acResult.errorMessage, equals("Invalid signup data"));

      verify(mockAuthRespository.signUp(fakeSignupRequestModel)).called(1);
    });
  });
}
