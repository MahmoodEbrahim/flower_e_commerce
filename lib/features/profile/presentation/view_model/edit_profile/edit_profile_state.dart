import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';

class EditProfileStates extends Equatable{
final  UploadProfilePhotoResponse? uploadProfilePhotoResponse;
 final RequestState uploadPhotoState;
 final String? errorMessageUploadPhoto;
final  EditProfileResponsea? editProfileResponsea;
final RequestState editProfileState;
final String? errorMessageEditProfile;
EditProfileStates({
   this.errorMessageUploadPhoto="",
  this.uploadProfilePhotoResponse,
  this.uploadPhotoState=RequestState.loading,
  this.editProfileResponsea,
  this.errorMessageEditProfile="",
  this.editProfileState=RequestState.loading

});
EditProfileStates copyWith({
    UploadProfilePhotoResponse? uploadProfilePhotoResponse,
   RequestState? uploadPhotoState,
   String? errorMessageUploadPhoto,
    EditProfileResponsea? editProfileResponsea,
   RequestState? editProfileState,
   String? errorMessageEditProfile
}){
  return EditProfileStates(
uploadPhotoState: uploadPhotoState??this.uploadPhotoState,
    uploadProfilePhotoResponse: uploadProfilePhotoResponse??this.uploadProfilePhotoResponse,
    errorMessageUploadPhoto: errorMessageUploadPhoto??this.errorMessageUploadPhoto
 ,errorMessageEditProfile: errorMessageEditProfile??this.errorMessageEditProfile,
    editProfileState: editProfileState??this.editProfileState,
    editProfileResponsea: editProfileResponsea??this.editProfileResponsea
  );
}
  @override
  // TODO: implement props
  List<Object?> get props => [
    uploadProfilePhotoResponse,uploadPhotoState,errorMessageUploadPhoto
  ,editProfileState,errorMessageEditProfile,editProfileResponsea
  ];
}