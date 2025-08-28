
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/auth_response/auth_response_dto.dart';
import 'package:flower_e_commerce/features/auth/api/models/signup_request/signup_request_dto.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/api/source/auth_remote_data_souce_imp.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_souce_imp_test.mocks.dart';

@GenerateMocks([AuthApiService])
void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRemoteDataSouceImp authRemoteDataSouceImp;
  late SignupRequestModel fakeSignupRequestModel;
  late UserDto fakeUser;


  setUpAll(
    () {
      mockAuthApiService = MockAuthApiService();
      authRemoteDataSouceImp = AuthRemoteDataSouceImp(mockAuthApiService);
      fakeSignupRequestModel = SignupRequestModel(
        firstName: "Aya",
        lastName: "Saber",
        email: "aya.saber@example.com",
        password: "Ahmed@123",
        repassword: "Ahmed@123",
        phone: "+201234567890",
        gender: "female",
      );

      fakeUser = UserDto(
        id: "user_12345",
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
        createdAt: DateTime.now(),
      );
    
    },
  );

  
  group("test signup function in the AuthRemoteDataSourceImp", () {
    test(
        "when call signup function with a correct parameters then it should return success api_result",
        () async {
      //------------------------Arrange----------------------------//

      SignupResponseDto fakeSignupResponseDto = SignupResponseDto(
          message: "sucess", user: fakeUser, token: "hhhhhhhhh");

      when(mockAuthApiService.signUp(SignupRequestDto.toDto(fakeSignupRequestModel))).thenAnswer((_) async => fakeSignupResponseDto);

      //----------------Act----------------------------------//
      final result =
          await authRemoteDataSouceImp.signUp(fakeSignupRequestModel);

      //----------------Assert----------------------------------//

      verify(mockAuthApiService.signUp(SignupRequestDto.toDto(fakeSignupRequestModel))).called(1);
      expect(result, isA<ApiSucessResult<UserModel>>());
      final acResult = result as ApiSucessResult<UserModel>;
      expect(acResult.sucessResult.email, fakeUser.email);
    });

    test(
        "when call signup function with a correct parameters but there is dio exception then it should return failed api_result",
        () async {
      //------------------------Arrange----------------------------//
      final String dioExceptionMessage = "dio error";
      final DioException mockDioException = DioException(
          requestOptions: RequestOptions(
            path: '',
          ),
          message: dioExceptionMessage);
    

      when(mockAuthApiService.signUp(SignupRequestDto.toDto(fakeSignupRequestModel))).thenThrow(mockDioException);

      //----------------Act----------------------------------//
      final result =
          await authRemoteDataSouceImp.signUp(fakeSignupRequestModel);

      //----------------Assert----------------------------------//

      verify(mockAuthApiService.signUp(any)).called(1);

      expect(result, isA<ApiFailedResult<UserModel>>());
      final ApiFailedResult<UserModel> acResult =
          result as ApiFailedResult<UserModel>;
      expect(acResult.errorMessage, equals(dioExceptionMessage));
    });

    test(
        "when call signup function with a correct parameters but there is exception then it should return failed api_result",
        () async {
      //------------------------Arrange----------------------------//
      final String exceptionMessage = "exception error";
      final Exception mockException = Exception(exceptionMessage);

      SignupRequestModel fakeSignupRequestModel = SignupRequestModel(
        firstName: "Aya",
        lastName: "Saber",
        email: "aya.saber@example.com",
        password: "Ahmed@123",
        repassword: "Ahmed@123",
        phone: "+201234567890",
        gender: "female",
      );

      when(mockAuthApiService.signUp(SignupRequestDto.toDto(fakeSignupRequestModel))).thenThrow(mockException);

      //----------------Act----------------------------------//
      final result =
          await authRemoteDataSouceImp.signUp(fakeSignupRequestModel);

      //----------------Assert----------------------------------//

      verify(mockAuthApiService.signUp(any)).called(1);

      expect(result, isA<ApiFailedResult<UserModel>>());
      final ApiFailedResult<UserModel> acResult =
          result as ApiFailedResult<UserModel>;
      expect(acResult.errorMessage, equals(mockException.toString()));
    });
  });
}
