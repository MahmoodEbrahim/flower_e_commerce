import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepositoryImp])
main() {
  provideDummy<ApiResult<LoginEntity>>(ApiErrorResult<LoginEntity>("dummy"));

  group(
    "test login usecase",
    () {
      late LoginUsecase loginUsecase;
      late MockAuthRepositoryImp mockAuthRepositoryImp;

      setUpAll(
        () {
          mockAuthRepositoryImp = MockAuthRepositoryImp();
          loginUsecase = LoginUsecase(mockAuthRepositoryImp);
        },
      );

      test(
        "should return ApiSuccessResult when login success",
        () async {
          //arrange
          const email = "test@test.com";
          const password = "123456";

          LoginEntity fakeLoginEntity = LoginEntity(
            token: "fake_token",
            user: UserEntity(
              Id: "1",
              firstName: "Test",
              lastName: "User",
              email: email,
              gender: "female",
              phone: "0123456789",
              photo: null,
              role: "customer",
              wishlist: [],
              addresses: [],
              createdAt: "2025-08-20",
            ),
          );
          when(mockAuthRepositoryImp.login(any, any)).thenAnswer(
              (_) async => ApiSuccessResult<LoginEntity>(fakeLoginEntity));

          //act
          final result = await loginUsecase.call(email, password);
          final success = result as ApiSuccessResult<LoginEntity>;

          //assert
          expect(result, isA<ApiSuccessResult<LoginEntity>>());
          expect(success.data.token, fakeLoginEntity.token);
          expect(success.data.user.email, email);
        },
      );

      test("should return ApiErrorResult when login fails",
          () async{
            //arrange
            const email = "test@test.com";
            const password = "123456";
            when(mockAuthRepositoryImp.login(any, any)).thenAnswer((_) async=> ApiErrorResult<LoginEntity>("errorMessage") );

            //act
            final result=await loginUsecase.call(email, password);
            final error = result as ApiErrorResult<LoginEntity>;

          //assert
            expect(result, isA<ApiErrorResult<LoginEntity>>());
            expect(error.errorMessage, "errorMessage");

          },);
    },
  );
}
