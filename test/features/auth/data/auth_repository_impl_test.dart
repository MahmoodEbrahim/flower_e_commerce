import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
main() {
  provideDummy<ApiResult<LoginEntity>>(ApiErrorResult<LoginEntity>("dummy"));
  late AuthRepositoryImp authRepositoryImp;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUpAll(
    () {
      mockAuthRemoteDataSource = MockAuthRemoteDataSource();
      authRepositoryImp = AuthRepositoryImp(mockAuthRemoteDataSource);
    },
  );

  group(
    "test AuthRepositoryImp.login",
    () {
      test(
        "should return ApiSuccessResult when login is successful'",
        () async{
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
          when(mockAuthRemoteDataSource.login(any, any)).thenAnswer(
              (_) async => ApiSuccessResult<LoginEntity>(fakeLoginEntity));

          //act
          final result=await authRepositoryImp.login(email, password);
          final success = result as ApiSuccessResult<LoginEntity>;

          //assert
          expect(result, isA<ApiSuccessResult<LoginEntity>>());
          expect(success.data.token, "fake_token");
          expect(success.data.user.email, email);
        },
      );
      
      test( "should return ApiErrorResult when login fails",
          () async{
            //arrange
            const email = "test@test.com";
            const password = "123456";
            when(mockAuthRemoteDataSource.login(any, any)).thenAnswer((_) async => ApiErrorResult<LoginEntity>("errorMessage"));
            
            
            //act 
            final result=await authRepositoryImp.login(email, password);
            final error = result as ApiErrorResult<LoginEntity>;
            
            //assert
            expect(result, isA<ApiErrorResult<LoginEntity>>());
            expect(error.errorMessage, "errorMessage");
          },);
    },
    
  );
}
