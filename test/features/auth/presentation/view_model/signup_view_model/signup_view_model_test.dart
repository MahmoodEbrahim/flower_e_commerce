import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_events.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_view_model_test.mocks.dart';

@GenerateMocks([SignupUsecase])
void main() {
  late SignupViewModel signupViewModel;
  late SignupUsecase mockSignupUsecase;
  late SignupRequestModel fakeSignupRequestModel;
  late UserModel fakeUser;
  setUp(
    () {
      mockSignupUsecase = MockSignupUsecase();
      //arange
      signupViewModel = SignupViewModel(mockSignupUsecase);

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
     
    
    },
  );
  group('signup function test in SignupViewModel ', () {
    blocTest<SignupViewModel, SignUpState>(
      "call signup function in signupViewModel with createUserEvent  and successApiResult it should emit usermodel and null errorMessage",
      build: () {
        final mockResult = ApiSucessResult<UserModel>(fakeUser);
        provideDummy<ApiResult<UserModel>>(mockResult);
        when(mockSignupUsecase.signUp(fakeSignupRequestModel))
            .thenAnswer((_) async => mockResult);

        return signupViewModel;
      },
      act: (bloc) =>
          bloc.add(CreateUserEvent(userModel: fakeSignupRequestModel)),
      expect: () {
        return [
          SignUpState(
            isLoading: true,
            errorMessage: null,
            userModel: null,
          ),
          SignUpState(
              isLoading: false, userModel: fakeUser, errorMessage: null),
        ];
      },
      verify: (signupViewModel) {
        verify(mockSignupUsecase.signUp(fakeSignupRequestModel)).called(1);
      },
    );

    blocTest<SignupViewModel, SignUpState>(
      "call signup function in signupViewModel with createUserEvent and failedApiResult it should emit failedState with errorMessage and userModel equels null   ",
      build: () {
        final mockResult = ApiFailedResult<UserModel>("Signup failed");
        provideDummy<ApiResult<UserModel>>(mockResult);
        when(mockSignupUsecase.signUp(fakeSignupRequestModel))
            .thenAnswer((_) async => mockResult);

        return signupViewModel;
      },
      act: (bloc) =>
          bloc.add(CreateUserEvent(userModel: fakeSignupRequestModel)),
      expect: () {
        return [
          SignUpState(
            isLoading: true,
            errorMessage: null,
            userModel: null,
          ),
          SignUpState(
              isLoading: false, userModel: null, errorMessage: "Signup failed"),
        ];
      },
       verify: (signupViewModel) {
        verify(mockSignupUsecase.signUp(fakeSignupRequestModel)).called(1);
      },
    );
  });
}
