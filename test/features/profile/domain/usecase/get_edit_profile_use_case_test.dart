import 'package:flower_e_commerce/features/profile/domain/usecase/get_edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_upload_profile_photo_use_case_test.mocks.dart';


@GenerateMocks([ProfileRepository])
void main() {
  late GetEditProfileUseCase useCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = GetEditProfileUseCase(mockProfileRepository);
    provideDummy<ApiResult<EditProfileResponsea>>(
        ApiFailedResult<EditProfileResponsea>("Dummy Error")
    );
  });

  const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";
  EditProfileRequest request=EditProfileRequest(
      firstName: "mariam",
      lastName: "Mohmed",
      email: "mariammohmed.25720@gmail.com",
      phone: "+201061728082"
  );
  final successResponse=EditProfileResponsea(
      message: "success",user: User(
      Id: "68a21825a8bca307f9de9365",
      firstName: "mariam",
      lastName: "Mohmed",
      email: "mariammohmed.25720@gmail.com",
      password: "T8lSnOaFaPjq6q",
      gender: "female",
      phone: "+201061728082",
      photo: "https://flower.elevateegy.com/uploads/b6bfe840-15b4-49aa-aba2-1b14b314744f-1756969431858.jpg",
      role: "user",
      wishlist: [],
      addresses: [],
      createdAt: "2025-08-17T17:57:57.084Z",
      passwordChangedAt: "2025-08-31T11:56:33.668Z"
  )
  );
  test('editProfile returns ApiSuccessResult on successful repository call', () async {

    when(mockProfileRepository.editProfile(token, request))
        .thenAnswer((_) async => ApiSucessResult<EditProfileResponsea>( successResponse));


    final result = await useCase.editProfile(token, request);


    expect(result, isA<ApiSucessResult<EditProfileResponsea>>());
    expect((result as ApiSucessResult).sucessResult, successResponse);
    verify(mockProfileRepository.editProfile(token, request)).called(1);
  });

  test('editProfile returns ApiFailedResult on failed repository call', () async {


    const errorMessage = 'Edit failed';
    when(mockProfileRepository.editProfile(token, request))
        .thenAnswer((_) async => ApiFailedResult<EditProfileResponsea>( errorMessage));

    final result = await useCase.editProfile(token, request);

    expect(result, isA<ApiFailedResult<EditProfileResponsea>>());
    expect((result as ApiFailedResult).errorMessage, errorMessage);
    verify(mockProfileRepository.editProfile(token, request)).called(1);
  });
}

