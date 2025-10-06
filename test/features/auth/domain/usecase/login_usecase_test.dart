import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepositoryImp])
main() {
  provideDummy<Result<LoginModel>>(FailedResult<LoginModel>("dummy"));

  group("test login usecase", () {
    late LoginUsecase loginUsecase;
    late MockAuthRepositoryImp mockAuthRepositoryImp;

    setUpAll(() {
      mockAuthRepositoryImp = MockAuthRepositoryImp();
      loginUsecase = LoginUsecase(mockAuthRepositoryImp);
    });

    test("should return ApiSucessResult when login success", () async {
      //arrange
      const email = "test@test.com";
      const password = "123456";

      LoginModel fakeLoginModel = LoginModel(
        token: "fake_token",
        user: UserModel(
          iid: "1",
          firstName: "Test",
          lastName: "User",
          email: email,
          gender: "female",
          phone: "0123456789",
          photo: null,
          role: "customer",
          wishlist: [],
          addresses: [],
        ),
      );
      when(
        mockAuthRepositoryImp.login(any, any),
      ).thenAnswer((_) async => SucessResult<LoginModel>(fakeLoginModel));

      //act
      final result = await loginUsecase.call(email, password);
      final success = result as SucessResult<LoginModel>;

      //assert
      expect(result, isA<SucessResult<LoginModel>>());
      expect(success.sucessResult.token, fakeLoginModel.token);
      expect(success.sucessResult.user.email, email);
    });

    test("should return FailedResult when login fails", () async {
      //arrange
      const email = "test@test.com";
      const password = "123456";
      when(
        mockAuthRepositoryImp.login(any, any),
      ).thenAnswer((_) async => FailedResult<LoginModel>("errorMessage"));

      //act
      final result = await loginUsecase.call(email, password);
      final error = result as FailedResult<LoginModel>;

      //assert
      expect(result, isA<FailedResult<LoginModel>>());
      expect(error.errorMessage, "errorMessage");
    });
  });
}
