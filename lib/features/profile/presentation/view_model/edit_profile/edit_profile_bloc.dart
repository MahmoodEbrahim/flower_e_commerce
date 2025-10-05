import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_edit_profile_use_case.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_upload_profile_photo_use_case.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_events.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileStates>{
  final GetUploadPhotoProfileUseCase _getUploadPhotoProfileUseCase;
  final GetEditProfileUseCase _getEditProfileUseCase;
  EditProfileBloc(this._getUploadPhotoProfileUseCase,this._getEditProfileUseCase)
      :super(EditProfileStates()){
    on<GetUploadProfileEvent>((event, emit) async {

      emit(state.copyWith(uploadPhotoState: RequestState.loading));


      final result = await _getUploadPhotoProfileUseCase.uploadPhoto(
        event.token,
        event.photo,
      );

      switch (result) {
        case ApiSucessResult<UploadProfilePhotoResponse>():
          emit(state.copyWith(
            uploadProfilePhotoResponse: result.sucessResult,
            uploadPhotoState: RequestState.success,
          ));

        case ApiFailedResult<UploadProfilePhotoResponse>():
          emit(state.copyWith(
            errorMessageUploadPhoto: result.errorMessage,
            uploadPhotoState: RequestState.error,
          ));
      }
    });
on<GetEditProfileEvent>((event,emit)async{
  emit(state.copyWith(
    editProfileState: RequestState.loading
  ));
  final result=await _getEditProfileUseCase.editProfile(event.token,
      event.request);
  switch(result){
    case ApiSucessResult<EditProfileResponsea>():
      emit(state.copyWith(
          editProfileResponsea: result.sucessResult,
          editProfileState: RequestState.success
      ));

    case ApiFailedResult<EditProfileResponsea>():
      emit(state.copyWith(
          errorMessageEditProfile: result.errorMessage,
          editProfileState: RequestState.error
      ));
  }

});
  }

}