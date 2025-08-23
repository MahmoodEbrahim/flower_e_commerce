import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
main() {
  provideDummy<ApiResult<LoginModel>>(ApiErrorResult<LoginModel>("dummy"));
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

          LoginModel fakeLoginEntity = LoginModel(
            token: "fake_token",
            user: UserModel(
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
            ),
          );
          when(mockAuthRemoteDataSource.login(any, any)).thenAnswer(
              (_) async => ApiSuccessResult<LoginModel>(fakeLoginEntity));

          //act
          final result=await authRepositoryImp.login(email, password);
          final success = result as ApiSuccessResult<LoginModel>;

          //assert
          expect(result, isA<ApiSuccessResult<LoginModel>>());
          expect(success.data.token, "fake_token");
          expect(success.data.user.email, email);
        },
      );
      
      test( "should return ApiErrorResult when login fails",
          () async{
            //arrange
            const email = "test@test.com";
            const password = "123456";
            when(mockAuthRemoteDataSource.login(any, any)).thenAnswer((_) async => ApiErrorResult<LoginModel>("errorMessage"));
            
            
            //act 
            final result=await authRepositoryImp.login(email, password);
            final error = result as ApiErrorResult<LoginModel>;
            
            //assert
            expect(result, isA<ApiErrorResult<LoginModel>>());
            expect(error.errorMessage, "errorMessage");
          },);
    },
    
  );
}
