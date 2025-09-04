import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_edit_profile_use_case.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_upload_profile_photo_use_case.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_events.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'edit_profile_bloc_test.mocks.dart';
@GenerateMocks([GetUploadPhotoProfileUseCase, GetEditProfileUseCase])
void main() {
  late EditProfileBloc bloc;
  late MockGetUploadPhotoProfileUseCase mockUploadUseCase;
  late MockGetEditProfileUseCase mockEditUseCase;
  late File photo;
  const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";

  setUp((){
    mockEditUseCase=MockGetEditProfileUseCase();
    mockUploadUseCase=MockGetUploadPhotoProfileUseCase();
    bloc=EditProfileBloc(mockUploadUseCase, mockEditUseCase);
    photo=File("/mock/path/to/file.jpg");
    provideDummy<ApiResult<UploadProfilePhotoResponse>>(
        ApiFailedResult<UploadProfilePhotoResponse>("Dummy Error")
    );
    provideDummy<ApiResult<EditProfileResponsea>>(
        ApiFailedResult<EditProfileResponsea>("Dummy Error")
    );
  });
  test('Initial state should be EditProfileStates', () {
    expect(bloc.state, isA<EditProfileStates>());
  });

group("Upload Profile Photo Bloc", (){
  final successResponse=UploadProfilePhotoResponse(
      message: "success"
  );
blocTest<EditProfileBloc,EditProfileStates>("emits [success state] when GetUploadProfileEvent is added successfully",
    build: (){
when(mockUploadUseCase.uploadPhoto(token, photo)).thenAnswer((_)async=>
    ApiSucessResult<UploadProfilePhotoResponse>(successResponse));
return bloc;
},act: (bloc)=>bloc..add(GetUploadProfileEvent
      (photo: photo, token: token)),expect: ()=>[
  EditProfileStates(
    uploadPhotoState: RequestState.loading
  ),
      EditProfileStates(uploadPhotoState: RequestState.success,
        uploadProfilePhotoResponse: successResponse
      )
    ],verify: (_){
  verify(mockUploadUseCase.uploadPhoto(token, photo)).called(1);
    });
final failreResponse="error";
blocTest<EditProfileBloc,EditProfileStates>("emits [failure state] when GetUploadProfileEvent is failed", build: (){
when(mockUploadUseCase.uploadPhoto(token, photo)).thenAnswer((_)async=>ApiFailedResult<UploadProfilePhotoResponse>(failreResponse));
return bloc;
},act: (bloc)=>bloc.add(GetUploadProfileEvent(photo: photo, token: token)),expect: ()=>[
  EditProfileStates(uploadPhotoState:RequestState.loading ),
  EditProfileStates(uploadPhotoState:RequestState.error,errorMessageUploadPhoto:  failreResponse)
],verify: (_){
  verify(mockUploadUseCase.uploadPhoto(token, photo)).called(1);
});
}

);
group("Edit Profile Bloc", (){
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
  blocTest<EditProfileBloc,EditProfileStates>("emits [success state] when GetEditProfileEvent is added successfull", build: (){
    when(mockEditUseCase.editProfile(token, request)).thenAnswer((_)async=>ApiSucessResult<EditProfileResponsea>(successResponse));
    return bloc;
  },act:(bloc)=> bloc..add(GetEditProfileEvent(request: request, token: token)),
  expect: ()=>[
    EditProfileStates(
      editProfileState: RequestState.loading
    ),
    EditProfileStates(
      editProfileState: RequestState.success,editProfileResponsea: successResponse
    )
  ],
    verify: (_){
    verify(mockEditUseCase.editProfile(token, request)).called(1);
    }
  );
  final failureResponse="Failed";
  blocTest<EditProfileBloc,EditProfileStates>("", build: (){
    when(mockEditUseCase.editProfile(token, request)).thenAnswer((_)async=>ApiFailedResult<EditProfileResponsea>(failureResponse));
    return bloc;
  },act: ( bloc)=>bloc..add(GetEditProfileEvent(request: request, token: token)),expect: ()=>[
    EditProfileStates(editProfileState: RequestState.loading),
    EditProfileStates(editProfileState: RequestState.error,errorMessageEditProfile: failureResponse)
  ],verify: (_){
    verify(mockEditUseCase.editProfile(token, request)).called(1);
  });
});
}