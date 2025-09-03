import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_upload_profile_photo_use_case.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile_events.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileStates>{
  GetUploadPhotoProfileUseCase _case;
  EditProfileBloc(this._case):super(EditProfileStates()){
on<GetUploadProfileEvent>((event,emit)async{
  final result=await _case.uploadPhoto(event.token, event.photo);
  switch(result){
    case ApiSucessResult<UploadProfilePhotoResponse>():
      emit(state.copyWith(
        uploadProfilePhotoResponse: result.sucessResult,
        uploadPhotoState: RequestState.success
      ));

    case ApiFailedResult<UploadProfilePhotoResponse>():
      emit(state.copyWith(
       errorMessageUploadPhoto: result.errorMessage,
          uploadPhotoState: RequestState.error
      ));
  }
});
  }

}